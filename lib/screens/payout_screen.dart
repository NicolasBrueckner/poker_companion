import 'dart:math';

import 'package:flutter/material.dart';
import 'package:poker_companion/core/utility.dart';
import 'package:poker_companion/screens/statistics_screen.dart';
import 'package:poker_companion/widgets/base_button.dart';
import 'package:poker_companion/widgets/payout_row.dart';

class PayoutScreen extends StatefulWidget {
  const PayoutScreen({super.key});

  @override
  State<StatefulWidget> createState() => _PayoutScreenState();
}

class _PayoutScreenState extends State<PayoutScreen> {
  final List<PlayerEntry> _players = [PlayerEntry()];
  final List<Transaction> _transactions = [];
  final SessionInfo _currentSession = SessionInfo(
    date: '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
    table: [],
  );
  bool _isCalculated = false;

  void _calculateTransactions() {
    final List<_PlayerBalance> balances = _players.map((p) => _PlayerBalance(name: p.name, balance: p.net)).toList();
    _PlayerBalance? debtor;
    _PlayerBalance? creditor;

    _transactions.clear();

    while (balances.isNotEmpty) {
      debtor = balances.where((b) => b.balance < 0).firstOrNull;
      creditor = balances.where((b) => b.balance > 0).firstOrNull;

      if (debtor == null || creditor == null) break;

      double transferAmount = min(-debtor.balance, creditor.balance);

      debtor.balance += transferAmount;
      creditor.balance -= transferAmount;

      _transactions.add(Transaction(from: debtor.name, to: creditor.name, amount: transferAmount));

      if (debtor.balance.abs() < 0.001) {
        balances.remove(debtor);
      }
      if (creditor.balance.abs() < 0.001) {
        balances.remove(creditor);
      }
    }
  }

  void _onAddPressed() {
    setState(() {
      _players.add(PlayerEntry());
    });
  }

  void _onCalculatePressed() {
    final sum = _players.fold<double>(0, (sum, p) => sum + p.net);
    if (sum.abs() > 0.001) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Money In and out don\'t match')));
      return;
    }
    setState(() {
      _isCalculated = true;
      _calculateTransactions();
    });
  }

  void _onEditPressed() {
    setState(() {
      _isCalculated = false;
    });
  }

  void _onSavePressed() async {
    await _saveSession();
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Saved')));
  }

  Future<void> _saveSession() async {
    final sessions = await SessionUtility.load();
    _currentSession.table = _players.map((p) => p.copy()).toList();
    final i = sessions.indexWhere((s) => s.id == _currentSession.id);
    if (i >= 0) {
      sessions[i] = _currentSession;
    } else {
      sessions.add(_currentSession);
    }
    await SessionUtility.save(sessions);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Payout Calculator')),
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 0.5,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ...(_players.map(
                  (p) => PayoutInputRowWidget(
                    key: ObjectKey(p),
                    entry: p,
                    onChanged: (_) => setState(() {}),
                    onDelete: () {
                      _players.remove(p);
                      setState(() {});
                    },
                  ),
                )),
                _ConditionalSlice(
                  condition: _isCalculated,
                  onAddPressed: _onAddPressed,
                  onCalculatePressed: _onCalculatePressed,
                  onEditPressed: _onEditPressed,
                  onSavePressed: _onSavePressed,
                  transactions: _transactions,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ConditionalSlice extends StatelessWidget {
  const _ConditionalSlice({
    required this.condition,
    required this.onAddPressed,
    required this.onCalculatePressed,
    required this.onEditPressed,
    required this.transactions,
    required this.onSavePressed,
  });
  final bool condition;
  final VoidCallback onAddPressed;
  final VoidCallback onCalculatePressed;
  final VoidCallback onEditPressed;
  final VoidCallback onSavePressed;
  final List<Transaction> transactions;

  @override
  Widget build(BuildContext context) {
    if (!condition) {
      return Column(
        children: [
          BaseButton(label: '+', onPressed: onAddPressed),
          BaseButton(label: 'Calculate', onPressed: onCalculatePressed),
        ],
      );
    }
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BaseButton(label: 'Edit', onPressed: onEditPressed),
            BaseButton(label: 'Save', onPressed: onSavePressed),
          ],
        ),
        PayoutResult(transactions: transactions),
      ],
    );
  }
}

class PayoutResult extends StatelessWidget {
  const PayoutResult({super.key, required this.transactions});
  final List<Transaction> transactions;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: Text('From', textAlign: TextAlign.center)),
            Expanded(child: Text('To', textAlign: TextAlign.center)),
            Expanded(child: Text('Amount', textAlign: TextAlign.center)),
          ],
        ),
        ...(transactions.map(
          (r) => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(child: Text(r.from, textAlign: TextAlign.center)),
              Expanded(child: Text(r.to, textAlign: TextAlign.center)),
              Expanded(child: Text(r.amount.toStringAsFixed(2), textAlign: TextAlign.center)),
            ],
          ),
        )),
      ],
    );
  }
}

class _PlayerBalance {
  _PlayerBalance({required this.name, required this.balance});
  final String name;
  double balance;
}

class PlayerEntry {
  PlayerEntry({this.name = '', this.moneyIn = 0, this.moneyOut = 0});

  String name;
  double moneyIn;
  double moneyOut;
  double get net => moneyOut - moneyIn;

  Map<String, dynamic> toJSON() => {'name': name, 'moneyIn': moneyIn, 'moneyOut': moneyOut, 'net': net};
  PlayerEntry.fromJSON(Map<String, dynamic> j)
    : name = j['name'] ?? '',
      moneyIn = (j['moneyIn'] as num).toDouble(),
      moneyOut = (j['moneyOut'] as num).toDouble();

  PlayerEntry copy() => PlayerEntry(name: name, moneyIn: moneyIn, moneyOut: moneyOut);
}

class Transaction {
  Transaction({this.from = '', this.to = '', this.amount = 0});

  String from;
  String to;
  double amount;
}
