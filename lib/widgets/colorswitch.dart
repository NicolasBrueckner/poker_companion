import 'package:flutter/material.dart';
import 'package:poker_companion/core/themes.dart';
import 'package:poker_companion/core/utility.dart';

class ColorSwitch extends StatelessWidget {
  const ColorSwitch({super.key});
  static const double spacing = 30;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Wrap(
        alignment: WrapAlignment.center,
        children: [
          ...(globalColorSchemes.entries
              .where((entry) => entry.key != 'default')
              .map((entry) {
                final key = entry.key;
                final (a, _, b, _) = entry.value;
                return Expanded(
                  child: ColorSwitchButton(
                    onPressed: () {
                      ThemeController.of(context).setTheme(key);
                    },
                    surface: b,
                    onSurface: a,
                  ),
                );
              })),
        ],
      ),
    );
  }
}

class ColorSwitchButton extends StatelessWidget {
  const ColorSwitchButton({
    super.key,
    required this.onPressed,
    required this.surface,
    required this.onSurface,
  });
  final VoidCallback onPressed;
  final Color surface;
  final Color onSurface;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      child: null,
      style: ButtonStyle(
        side: WidgetStateProperty.resolveWith<BorderSide?>((states) {
          return BorderSide(
            color: surface,
            width: 5,
            style: BorderStyle.solid,
            strokeAlign: BorderSide.strokeAlignCenter,
          );
        }),
        backgroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
          return onSurface;
        }),
      ),
    );
  }
}
