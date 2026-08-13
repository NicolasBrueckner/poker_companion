import 'package:flutter/material.dart';
import 'package:poker_companion/core/payout_data.dart';
import 'package:poker_companion/core/utility.dart';
import 'package:poker_companion/widgets/buttons.dart';
import 'package:poker_companion/widgets/preset_item.dart';

Future<Preset?> showPresetPicker(
  BuildContext context, {
  required List<Preset> presets,
  required Future<void> Function(Preset) onDelete,
  required Future<Preset> Function() onSave,
  required bool isPresetActive,
}) {
  return showModalBottomSheet<Preset>(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
    builder: (context) =>
        _PresetPickerSheet(presets: presets, onDelete: onDelete, onSave: onSave, isPresetActive: isPresetActive),
  );
}

class _PresetPickerSheet extends StatefulWidget {
  const _PresetPickerSheet({
    required this.presets,
    required this.onDelete,
    required this.onSave,
    required this.isPresetActive,
  });
  final List<Preset> presets;
  final Future<void> Function(Preset) onDelete;
  final Future<Preset> Function() onSave;
  final bool isPresetActive;

  @override
  State<_PresetPickerSheet> createState() => _PresetPickerSheetState();
}

class _PresetPickerSheetState extends State<_PresetPickerSheet> {
  late final List<Preset> _presets = List.of(widget.presets);

  Future<void> _onSavePressed() async {
    if (widget.isPresetActive) {
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Update preset?'),
          content: const Text('This will overwrite the previously saved preset.'),
          actions: [
            TextButton(onPressed: () => Navigator.of(ctx).pop(false), child: const Text('Cancel')),
            TextButton(onPressed: () => Navigator.of(ctx).pop(true), child: const Text('Update')),
          ],
        ),
      );
      if (confirmed != true) return;
    }
    if (!mounted) return;
    await widget.onSave();
    if (!mounted) return;
    Navigator.of(context).pop();
  }

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
            const SizedBox(height: 12),
            BaseTextButton(
              label: widget.isPresetActive ? '+ Update Preset' : '+ Save Current as Preset',
              onPressed: _onSavePressed,
            ),
          ],
        ),
      ),
    );
  }
}
