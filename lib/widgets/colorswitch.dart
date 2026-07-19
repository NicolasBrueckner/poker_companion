import 'package:flutter/material.dart';
import 'package:poker_companion/core/themes.dart';
import 'package:poker_companion/core/utility.dart';

class ColorSwitch extends StatelessWidget {
  const ColorSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    final String activeKey = ThemeController.of(context).activeTheme;

    return GridView.count(
      crossAxisCount: 4,
      crossAxisSpacing: 15,
      mainAxisSpacing: 10,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        ...(globalColorSchemes.entries.where((entry) => entry.key != 'default').map((entry) {
          final key = entry.key;
          final (a, _, b, _) = entry.value;
          return ColorSwitchButton(
            onPressed: () {
              ThemeController.of(context).setTheme(key);
            },
            outer: activeKey == key ? a : b,
            inner: activeKey == key ? b : a,
            innerSizeFactor: activeKey == key ? 0.8 : 0.5,
          );
        })),
      ],
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
          duration: Duration(milliseconds: ms),
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
