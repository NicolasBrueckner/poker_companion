import 'package:flutter/material.dart';
import 'package:poker_companion/core/payout_data.dart';
import 'package:poker_companion/core/utility.dart';
import 'package:poker_companion/widgets/preset_item.dart';

Future<Preset?> showPresetPicker(
  BuildContext context, {
  required List<Preset> presets,
  required Future<void> Function(Preset) onDelete,
}) {
  return showModalBottomSheet<Preset>(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
    builder: (context) => _PresetPickerSheet(presets: presets, onDelete: onDelete),
  );
}

class _PresetPickerSheet extends StatefulWidget {
  const _PresetPickerSheet({required this.presets, required this.onDelete});
  final List<Preset> presets;
  final Future<void> Function(Preset) onDelete;

  @override
  State<_PresetPickerSheet> createState() => _PresetPickerSheetState();
}

class _PresetPickerSheetState extends State<_PresetPickerSheet> {
  late final List<Preset> _presets = List.of(widget.presets);

  @override
  Widget build(BuildContext context) {
    final scheme = ThemeController.of(context).colorScheme;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: 36,
                height: 4,
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: scheme.onSurface.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            Text(
              'Load Preset',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: scheme.onSurface),
            ),
            const SizedBox(height: 12),
            if (_presets.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: Text(
                  'No presets saved yet',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: scheme.onSurface.withValues(alpha: 0.45)),
                ),
              )
            else
              Flexible(
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: _presets.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 10),
                  itemBuilder: (_, i) {
                    final preset = _presets[_presets.length - 1 - i];
                    return PresetItem(
                      preset: preset,
                      onSelect: () => Navigator.of(context).pop(preset),
                      onDelete: () {
                        widget.onDelete(preset);
                        setState(() => _presets.remove(preset));
                      },
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
