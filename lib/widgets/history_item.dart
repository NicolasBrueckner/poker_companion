import 'package:flutter/material.dart';
import 'package:poker_companion/core/payout_data.dart';
import 'package:poker_companion/core/utility.dart';
import 'package:poker_companion/l10n/app_localizations.dart';
import 'package:poker_companion/screens/history_screen.dart';

class StatisticItem extends StatelessWidget {
  const StatisticItem({super.key, required this.info, required this.onDelete});
  final HistoryData info;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final scheme = ThemeController.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;
    return Dismissible(
      key: ValueKey(info.id),
      direction: DismissDirection.endToStart,
      confirmDismiss: (_) => showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text(l10n.deleteSessionTitle),
          content: Text(l10n.deleteSessionContent),
          actions: [
            TextButton(onPressed: () => Navigator.of(ctx).pop(false), child: Text(l10n.cancel)),
            TextButton(onPressed: () => Navigator.of(ctx).pop(true), child: Text(l10n.delete)),
          ],
        ),
      ),
      onDismissed: (_) => onDelete(),
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          color: scheme.primary.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(Icons.delete_outline, color: scheme.primary),
      ),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: scheme.onSurface.withValues(alpha: 0.15)),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SessionHeader(info: info),
            const SizedBox(height: 8),
            Divider(height: 1, color: scheme.onSurface.withValues(alpha: 0.1)),
            const SizedBox(height: 8),
            _TableHeaders(),
            const SizedBox(height: 2),
            ...info.table.map((entry) => _PlayerRow(entry: entry)),
          ],
        ),
      ),
    );
  }
}

class _SessionHeader extends StatelessWidget {
  const _SessionHeader({required this.info});
  final HistoryData info;

  @override
  Widget build(BuildContext context) {
    final scheme = ThemeController.of(context).colorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(info.date, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
        Text(
          AppLocalizations.of(context)!.potLabel(info.pot.toStringAsFixed(2)),
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: scheme.onSurface.withValues(alpha: 0.55)),
        ),
      ],
    );
  }
}

class _TableHeaders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final scheme = ThemeController.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;
    final style = TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w600,
      color: scheme.onSurface.withValues(alpha: 0.55),
      letterSpacing: 0.5,
    );
    return Row(
      children: [
        Expanded(flex: 4, child: Text(l10n.tableHeaderPlayer, style: style)),
        Expanded(
          flex: 3,
          child: Text(l10n.tableHeaderBuyIn, style: style, textAlign: TextAlign.right),
        ),
        Expanded(
          flex: 3,
          child: Text(l10n.tableHeaderCashOut, style: style, textAlign: TextAlign.right),
        ),
        Expanded(
          flex: 3,
          child: Text(l10n.tableHeaderNet, style: style, textAlign: TextAlign.right),
        ),
      ],
    );
  }
}

class _PlayerRow extends StatelessWidget {
  const _PlayerRow({required this.entry});
  final PlayerEntry entry;

  @override
  Widget build(BuildContext context) {
    final scheme = ThemeController.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Text(
              entry.name.isEmpty ? '—' : entry.name,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              entry.moneyIn.toStringAsFixed(2),
              textAlign: TextAlign.right,
              style: TextStyle(color: scheme.onSurface.withValues(alpha: 0.65)),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              entry.moneyOut.toStringAsFixed(2),
              textAlign: TextAlign.right,
              style: TextStyle(color: scheme.onSurface.withValues(alpha: 0.65)),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              '${entry.net > 0 ? '+' : ''}${entry.net.toStringAsFixed(2)}',
              textAlign: TextAlign.right,
              style: TextStyle(fontWeight: FontWeight.w700, color: entry.net > 0 ? scheme.primary : scheme.onSurface),
            ),
          ),
        ],
      ),
    );
  }
}
