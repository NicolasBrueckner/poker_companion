import 'dart:math';

import 'package:flutter/material.dart';
import 'package:poker_companion/core/payout_data.dart';
import 'package:poker_companion/core/utility.dart';
import 'package:poker_companion/screens/base_screen.dart';
import 'package:poker_companion/screens/history_screen.dart';
import 'package:poker_companion/widgets/buttons.dart';
import 'package:poker_companion/widgets/preset_sheet.dart';
import 'package:poker_companion/widgets/screenshot.dart';
import 'package:poker_companion/widgets/session_rows.dart';

class SessionScreen extends StatefulWidget {
  const SessionScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SessionScreenState();
}

class _SessionScreenState extends State<SessionScreen> {
  final _repaintKey = GlobalKey();
  final List<PlayerEntry> _players = List.generate(PrefValues.savedPlayerCount, (i) => PlayerEntry());
  final List<Transaction> _transactions = [];
  HistoryData _currentSession = HistoryData(
    date: '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
    table: [],
  );
  Preset _currentPreset = Preset(names: [], moneyIns: []);
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
    final sumIn = _players.fold<double>(0, (sum, p) => sum + p.moneyIn);
    final sumOut = _players.fold<double>(0, (sum, p) => sum + p.moneyOut);

    FocusManager.instance.primaryFocus?.unfocus();

    if ((sumIn - sumOut).abs() > 0.001) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Totals don\'t match - in: ${sumIn.toStringAsFixed(2)}, out: ${sumOut.toStringAsFixed(2)}'),
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

  Future<void> _onSharePressed() async {
    final overlay = Overlay.of(context);
    final width = MediaQuery.sizeOf(context).width * 0.8;
    final entry = OverlayEntry(
      builder: (_) => Positioned(
        left: -width - 100,
        width: width,
        child: Material(
          child: RepaintBoundary(
            key: _repaintKey,
            child: SessionResultScreenshot(date: _currentSession.date, players: _players, transactions: _transactions),
          ),
        ),
      ),
    );
    overlay.insert(entry);
    await WidgetsBinding.instance.endOfFrame;
    await ScreenCapture.capture(_repaintKey);
    entry.remove();
  }

  void _onSessionSavePressed() async {
    await _saveSession();
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Session saved')));
  }

  Future<void> _saveSession() async {
    final sessions = await HistoryUtility.load();
    _currentSession.table = _players.map((p) => p.copy()).toList();
    final i = sessions.indexWhere((s) => s.id == _currentSession.id);
    if (i >= 0) {
      sessions[i] = _currentSession;
    } else {
      sessions.add(_currentSession);
    }
    await HistoryUtility.save(sessions);
  }

  Future<void> _onPresetsPressed() async {
    final presets = await SessionUtility.load();
    if (!mounted) return;

    final selected = await showPresetPicker(
      context,
      presets: presets,
      onDelete: (preset) async {
        final current = await SessionUtility.load();
        current.removeWhere((p) => p.id == preset.id);
        await SessionUtility.save(current);
      },
      onSave: _savePresets,
      isPresetActive: _currentPreset.names.isNotEmpty,
    );
    if (selected == null) return;

    setState(() {
      _players
        ..clear()
        ..addAll(
          List.generate(
            selected.names.length,
            (i) => PlayerEntry(name: selected.names[i], moneyIn: selected.moneyIns[i]),
          ),
        );
      _currentPreset = selected;
      _transactions.clear();
      _isCalculated = false;
      _currentSession = HistoryData(
        date: '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
        table: [],
      );
    });
  }

  void _resetSession() {
    FocusManager.instance.primaryFocus?.unfocus();
    setState(() {
      _players
        ..clear()
        ..addAll(List.generate(PrefValues.savedPlayerCount, (_) => PlayerEntry()));
      _transactions.clear();
      _currentPreset = Preset(names: [], moneyIns: []);
      _isCalculated = false;
      _currentSession = HistoryData(
        date: '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
        table: [],
      );
    });
  }

  Future<Preset> _savePresets() async {
    final presets = await SessionUtility.load();
    _currentPreset.names = _players.map((p) => p.name).toList();
    _currentPreset.moneyIns = _players.map((p) => p.moneyIn).toList();
    final i = presets.indexWhere((s) => s.id == _currentPreset.id);
    if (i >= 0) {
      presets[i] = _currentPreset;
    } else {
      presets.add(_currentPreset);
    }
    await SessionUtility.save(presets);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Preset saved')));
    }
    return _currentPreset;
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: 'New Session',
      actions: [
        IconButton(onPressed: _onPresetsPressed, icon: Icon(Icons.bookmark_border)),
        SizedBox(width: 10),
        IconButton(onPressed: _resetSession, icon: Icon(Icons.loop)),
        SizedBox(width: 10),
        IconButton(onPressed: _isCalculated ? _onSharePressed : null, icon: Icon(Icons.share)),
      ],
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
            _ActionButtons(
              condition: _isCalculated,
              onAddPressed: _onAddPressed,
              onCalculatePressed: _onCalculatePressed,
              onEditPressed: _onEditPressed,
              onSavePressed: _onSessionSavePressed,
            ),
            if (_isCalculated) ...[const SizedBox(height: 16), _SettlementsList(transactions: _transactions)],
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

class _ActionButtons extends StatelessWidget {
  const _ActionButtons({
    required this.condition,
    required this.onAddPressed,
    required this.onCalculatePressed,
    required this.onEditPressed,
    required this.onSavePressed,
  });
  final bool condition;
  final VoidCallback onAddPressed;
  final VoidCallback onCalculatePressed;
  final VoidCallback onEditPressed;
  final VoidCallback onSavePressed;

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
    return Row(
      children: [
        Expanded(
          child: BaseTextButton(label: 'Edit', onPressed: onEditPressed),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: BaseTextButton(label: 'Save', onPressed: onSavePressed),
        ),
      ],
    );
  }
}

class _SettlementsList extends StatelessWidget {
  const _SettlementsList({required this.transactions});
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
