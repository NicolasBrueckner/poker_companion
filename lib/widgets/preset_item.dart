import 'package:flutter/material.dart';
import 'package:poker_companion/core/payout_data.dart';
import 'package:poker_companion/core/utility.dart';

class PresetItem extends StatelessWidget {
  const PresetItem({super.key, required this.preset, required this.onSelect, required this.onDelete});
  final Preset preset;
  final VoidCallback onSelect;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final scheme = ThemeController.of(context).colorScheme;
    return Dismissible(
      key: ValueKey(preset.id),
      direction: DismissDirection.endToStart,
      confirmDismiss: (_) => showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Delete preset?'),
          content: const Text('This preset will be permanently removed.'),
          actions: [
            TextButton(onPressed: () => Navigator.of(ctx).pop(false), child: const Text('Cancel')),
            TextButton(onPressed: () => Navigator.of(ctx).pop(true), child: const Text('Delete')),
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
      child: _PresetCard(preset: preset, onSelect: onSelect),
    );
  }
}

class _PresetCard extends StatefulWidget {
  const _PresetCard({required this.preset, required this.onSelect});
  final Preset preset;
  final VoidCallback onSelect;

  @override
  State<_PresetCard> createState() => _PresetCardState();
}

class _PresetCardState extends State<_PresetCard> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final scheme = ThemeController.of(context).colorScheme;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: widget.onSelect,
        onHighlightChanged: (value) => setState(() => _pressed = value),
        borderRadius: BorderRadius.circular(12),
        splashColor: scheme.primary.withValues(alpha: 0.12),
        highlightColor: scheme.primary.withValues(alpha: 0.08),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _pressed ? scheme.primary.withValues(alpha: 0.06) : null,
            border: Border.all(
              color: _pressed ? scheme.primary : scheme.onSurface,
              width: 1,
              strokeAlign: BorderSide.strokeAlignInside,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _PresetHeader(preset: widget.preset),
              const SizedBox(height: 8),
              Divider(height: 1, color: scheme.onSurface.withValues(alpha: 0.1)),
              const SizedBox(height: 8),
              const _TableHeaders(),
              const SizedBox(height: 2),
              ...List.generate(
                widget.preset.names.length,
                (i) => _PresetRow(name: widget.preset.names[i], moneyIn: widget.preset.moneyIns[i]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PresetHeader extends StatelessWidget {
  const _PresetHeader({required this.preset});
  final Preset preset;

  @override
  Widget build(BuildContext context) {
    final scheme = ThemeController.of(context).colorScheme;
    final total = preset.moneyIns.fold<double>(0, (sum, m) => sum + m);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('${preset.names.length} players', style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Pot  ${total.toStringAsFixed(2)}',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13,
                color: scheme.onSurface.withValues(alpha: 0.55),
              ),
            ),
            const SizedBox(width: 4),
            Icon(Icons.chevron_right, size: 18, color: scheme.onSurface.withValues(alpha: 0.4)),
          ],
        ),
      ],
    );
  }
}

class _TableHeaders extends StatelessWidget {
  const _TableHeaders();

  @override
  Widget build(BuildContext context) {
    final scheme = ThemeController.of(context).colorScheme;
    final style = TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w600,
      color: scheme.onSurface.withValues(alpha: 0.55),
      letterSpacing: 0.5,
    );
    return Row(
      children: [
        Expanded(flex: 4, child: Text('Player', style: style)),
        Expanded(
          flex: 3,
          child: Text('Buy In', style: style, textAlign: TextAlign.right),
        ),
      ],
    );
  }
}

class _PresetRow extends StatelessWidget {
  const _PresetRow({required this.name, required this.moneyIn});
  final String name;
  final double moneyIn;

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
              name.isEmpty ? '—' : name,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              moneyIn.toStringAsFixed(2),
              textAlign: TextAlign.right,
              style: TextStyle(color: scheme.onSurface.withValues(alpha: 0.65)),
            ),
          ),
        ],
      ),
    );
  }
}
