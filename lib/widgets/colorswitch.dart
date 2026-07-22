import 'package:flutter/material.dart';
import 'package:poker_companion/core/themes.dart';
import 'package:poker_companion/core/utility.dart';

class ColorSwitch extends StatelessWidget {
  const ColorSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    final String activeKey = PrefValues.savedThemeId;
    final scheme = ThemeController.of(context).colorScheme;

    final lightEntries = globalColorSchemes.entries
        .where((e) => e.key != 'default' && e.value.$4 == Brightness.light)
        .toList();
    final darkEntries = globalColorSchemes.entries
        .where((e) => e.key != 'default' && e.value.$4 == Brightness.dark)
        .toList();

    final labelStyle = TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w600,
      color: scheme.onSurface.withValues(alpha: 0.55),
      letterSpacing: 0.5,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('LIGHT', style: labelStyle),
        const SizedBox(height: 8),
        _ThemeGrid(entries: lightEntries, activeKey: activeKey),
        const SizedBox(height: 20),
        Text('DARK', style: labelStyle),
        const SizedBox(height: 8),
        _ThemeGrid(entries: darkEntries, activeKey: activeKey),
      ],
    );
  }
}

class _ThemeGrid extends StatelessWidget {
  const _ThemeGrid({required this.entries, required this.activeKey});
  final List<MapEntry<String, (Color, Color, Color, Brightness)>> entries;
  final String activeKey;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 4,
      crossAxisSpacing: 15,
      mainAxisSpacing: 10,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: entries.map((entry) {
        final key = entry.key;
        final (a, _, b, _) = entry.value;
        return ColorSwitchButton(
          onPressed: () => ThemeController.of(context).setTheme(key),
          outer: activeKey == key ? a : b,
          inner: activeKey == key ? b : a,
          innerSizeFactor: activeKey == key ? 0.8 : 0.5,
        );
      }).toList(),
    );
  }
}

class ColorSwitchButton extends StatelessWidget {
  const ColorSwitchButton({
    super.key,
    required this.onPressed,
    required this.outer,
    required this.inner,
    required this.innerSizeFactor,
  });
  final VoidCallback onPressed;
  final Color outer;
  final Color inner;
  final double innerSizeFactor;
  static const int ms = 200;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: ms),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(color: outer, shape: BoxShape.circle),
        child: AnimatedFractionallySizedBox(
          duration: const Duration(milliseconds: ms),
          widthFactor: innerSizeFactor,
          heightFactor: innerSizeFactor,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: ms),
            curve: Curves.easeInOut,
            decoration: BoxDecoration(color: inner, shape: BoxShape.circle),
          ),
        ),
      ),
    );
  }
}
