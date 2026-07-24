import 'dart:math';

import 'package:flutter/material.dart';
import 'package:poker_companion/core/payout_data.dart';
import 'package:poker_companion/core/utility.dart';
import 'package:poker_companion/screens/base_screen.dart';
import 'package:poker_companion/screens/history_screen.dart';
import 'package:poker_companion/widgets/buttons.dart';
import 'package:poker_companion/widgets/session_rows.dart';

class SessionScreen extends StatefulWidget {
  const SessionScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SessionScreenState();
}

class _SessionScreenState extends State<SessionScreen> {
  final List<PlayerEntry> _players = List.generate(PrefValues.savedPlayerCount, (i) => PlayerEntry());
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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Money out is ${sum.abs().toStringAsFixed(2)} '
            '${sum < 0 ? 'short of' : 'over'} money in',
          ),
        ),
      );
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
      title: 'New Session',
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const _ColumnHeaders(),
            ...(_players.map(
              (p) => PayoutInputRow(
                key: ObjectKey(p),
                entry: p,
                onChanged: (_) {},
                onDelete: (_) {
                  _players.remove(p);
                  setState(() {});
                },
                isInputLocked: _isCalculated,
              ),
            )),
            const SizedBox(height: 8),
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

class _ColumnHeaders extends StatelessWidget {
  const _ColumnHeaders();

  @override
  Widget build(BuildContext context) {
    final scheme = ThemeController.of(context).colorScheme;
    final style = TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w600,
      color: scheme.onSurface.withValues(alpha: 0.55),
      letterSpacing: 0.5,
    );
    return Padding(
      padding: const EdgeInsets.fromLTRB(3, 0, 3, 2),
      child: Row(
        spacing: 5,
        children: [
          Expanded(
            flex: 4,
            child: Text('Player', style: style, textAlign: TextAlign.center),
          ),
          Expanded(
            flex: 3,
            child: Text('Buy In', style: style, textAlign: TextAlign.center),
          ),
          Expanded(
            flex: 3,
            child: Text('Cash Out', style: style, textAlign: TextAlign.center),
          ),
          Expanded(
            flex: 3,
            child: Text('Net', style: style, textAlign: TextAlign.center),
          ),
        ],
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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          BaseTextButton(label: '+ Add Player', onPressed: onAddPressed),
          const SizedBox(height: 8),
          BaseTextButton(label: 'Calculate', onPressed: onCalculatePressed),
        ],
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: BaseTextButton(label: 'Edit', onPressed: onEditPressed),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: BaseTextButton(label: 'Save', onPressed: onSavePressed),
            ),
          ],
        ),
        const SizedBox(height: 16),
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
    final scheme = ThemeController.of(context).colorScheme;
    if (transactions.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Text(
          'No settlements needed',
          textAlign: TextAlign.center,
          style: TextStyle(color: scheme.onSurface.withValues(alpha: 0.5)),
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(
            'Settlements',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: scheme.onSurface, letterSpacing: 0.5),
          ),
        ),
        ...transactions.map((r) => PayoutOutputRow(transaction: r)),
      ],
    );
  }
}
