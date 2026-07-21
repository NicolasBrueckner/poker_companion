import 'dart:math';

import 'package:flutter/material.dart';
import 'package:poker_companion/core/payout_data.dart';
import 'package:poker_companion/core/utility.dart';
import 'package:poker_companion/screens/base_screen.dart';
import 'package:poker_companion/screens/statistics_screen.dart';
import 'package:poker_companion/widgets/buttons.dart';
import 'package:poker_companion/widgets/payout_rows.dart';

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
    final List<PlayerBalance> balances = _players.map((p) => PlayerBalance(name: p.name, balance: p.net)).toList();
    PlayerBalance? debtor;
    PlayerBalance? creditor;

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
    if (!mounted) return;
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
    return BaseScreen(
      title: 'Payout Calculator',
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ...(_players.map(
              (p) => PayoutInputRow(
                key: ObjectKey(p),
                entry: p,
                onChanged: (_) => setState(() {}),
                onDelete: (_) {
                  _players.remove(p);
                  setState(() {});
                },
                isInputLocked: _isCalculated,
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
          BaseTextButton(label: '+', onPressed: onAddPressed),
          BaseTextButton(label: 'Calculate', onPressed: onCalculatePressed),
        ],
      );
    }
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: BaseTextButton(label: 'Edit', onPressed: onEditPressed),
            ),
            Expanded(
              child: BaseTextButton(label: 'Save', onPressed: onSavePressed),
            ),
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
      spacing: 5,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: Text('From', textAlign: TextAlign.center)),
            Expanded(child: Text('To', textAlign: TextAlign.center)),
            Expanded(child: Text('Amount', textAlign: TextAlign.center)),
          ],
        ),
        ...(transactions.map((r) => PayoutOutputRow(transaction: r))),
      ],
    );
  }
}
