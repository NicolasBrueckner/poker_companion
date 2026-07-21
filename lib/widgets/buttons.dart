import 'package:flutter/material.dart';

class BaseTextButton extends StatelessWidget {
  const BaseTextButton({super.key, required this.label, this.onPressed});
  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: _buttonStyle(Theme.of(context).colorScheme),
      child: Text(label, textScaler: TextScaler.linear(1.7)),
    );
  }
}

class BaseIconButton extends StatelessWidget {
  const BaseIconButton({super.key, required this.icon, this.onPressed});
  final Icon icon;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: onPressed, style: _buttonStyle(Theme.of(context).colorScheme), icon: icon);
  }
}

ButtonStyle _buttonStyle(ColorScheme scheme) {
  const BorderSide baseSide = BorderSide(
    width: 1.0,
    strokeAlign: BorderSide.strokeAlignInside,
    style: BorderStyle.solid,
  );

  return ButtonStyle(
    padding: WidgetStateProperty.resolveWith<EdgeInsetsGeometry>((states) => EdgeInsets.all(12)),
    alignment: Alignment.center,
    backgroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
      if (states.contains(WidgetState.pressed)) {
        return scheme.primary;
      }
      return scheme.surface;
    }),
    foregroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
      if (states.contains(WidgetState.pressed)) {
        return scheme.surface;
      }
      return scheme.onSurface;
    }),
    side: WidgetStateProperty.resolveWith<BorderSide?>((states) {
      if (states.contains(WidgetState.pressed)) {
        return baseSide.copyWith(color: scheme.primary);
      }
      return baseSide.copyWith(color: scheme.onSurface);
    }),
  );
}


//const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//alignment: Alignment.center,