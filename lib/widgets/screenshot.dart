import 'package:flutter/material.dart';
import 'package:poker_companion/core/payout_data.dart';
import 'package:poker_companion/core/utility.dart';
import 'package:poker_companion/widgets/session_rows.dart';

class SessionResultScreenshot extends StatelessWidget {
  const SessionResultScreenshot({super.key, required this.date, required this.players, required this.transactions});

  final String date;
  final List<PlayerEntry> players;
  final List<Transaction> transactions;

  @override
  Widget build(BuildContext context) {
    final scheme = ThemeController.of(context).colorScheme;
    return Container(
      color: scheme.surface,
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Poker Session',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: scheme.onSurface),
          ),
          Text(date, style: TextStyle(fontSize: 12, color: scheme.onSurface.withValues(alpha: 0.55))),
          const SizedBox(height: 16),
          _HeaderRow(scheme: scheme),
          ...players.map((p) => _PlayerRow(entry: p, scheme: scheme)),
          const SizedBox(height: 20),
          Text(
            'Settlements',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: scheme.onSurface, letterSpacing: 0.5),
          ),
          const SizedBox(height: 8),
          if (transactions.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Text(
                'No settlements needed',
                textAlign: TextAlign.center,
                style: TextStyle(color: scheme.onSurface.withValues(alpha: 0.5)),
              ),
            )
          else
            ...transactions.map((t) => PayoutOutputRow(transaction: t)),
        ],
      ),
    );
  }
}

class _HeaderRow extends StatelessWidget {
  const _HeaderRow({required this.scheme});
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w600,
      color: scheme.onSurface.withValues(alpha: 0.55),
      letterSpacing: 0.5,
    );
    return Padding(
      padding: const EdgeInsets.fromLTRB(3, 0, 3, 6),
      child: Row(
        spacing: 5,
        children: [
          Expanded(flex: 4, child: Text('Player', style: style, textAlign: TextAlign.center)),
          Expanded(flex: 3, child: Text('Buy In', style: style, textAlign: TextAlign.center)),
          Expanded(flex: 3, child: Text('Cash Out', style: style, textAlign: TextAlign.center)),
          Expanded(flex: 3, child: Text('Net', style: style, textAlign: TextAlign.center)),
        ],
      ),
    );
  }
}

class _PlayerRow extends StatelessWidget {
  const _PlayerRow({required this.entry, required this.scheme});
  final PlayerEntry entry;
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    final netColor = entry.net > 0
        ? scheme.primary
        : entry.net < 0
        ? scheme.error
        : scheme.onSurface;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 4),
      child: Row(
        spacing: 5,
        children: [
          Expanded(
            flex: 4,
            child: Text(
              entry.name.isEmpty ? '-' : entry.name,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontWeight: FontWeight.w500, color: scheme.onSurface),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(entry.moneyIn.toStringAsFixed(2), textAlign: TextAlign.center, style: TextStyle(color: scheme.onSurface)),
          ),
          Expanded(
            flex: 3,
            child: Text(entry.moneyOut.toStringAsFixed(2), textAlign: TextAlign.center, style: TextStyle(color: scheme.onSurface)),
          ),
          Expanded(
            flex: 3,
            child: Text(
              entry.net.toStringAsFixed(2),
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w700, color: netColor),
            ),
          ),
        ],
      ),
    );
  }
}
