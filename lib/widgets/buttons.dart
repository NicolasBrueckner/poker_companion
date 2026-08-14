import 'package:flutter/material.dart';
import 'package:poker_companion/core/utility.dart';

class BaseTextButton extends StatelessWidget {
  const BaseTextButton({super.key, required this.label, this.onPressed, this.primary = true});
  final String label;
  final VoidCallback? onPressed;
  final bool primary;

  @override
  Widget build(BuildContext context) {
    final scheme = ThemeController.of(context).colorScheme;
    return TextButton(
      onPressed: onPressed,
      style: primary ? _primaryStyle(scheme) : _secondaryStyle(scheme),
      child: Text(label),
    );
  }
}

class BaseIconButton extends StatelessWidget {
  const BaseIconButton({super.key, required this.icon, this.onPressed});
  final Icon icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final scheme = ThemeController.of(context).colorScheme;
    return IconButton(
      onPressed: onPressed,
      icon: icon,
      style: IconButton.styleFrom(
        foregroundColor: scheme.onSurface,
        disabledForegroundColor: scheme.onSurface.withValues(alpha: 0.3),
        overlayColor: scheme.primary,
        side: BorderSide(color: scheme.onSurface.withValues(alpha: 0.2)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        minimumSize: const Size.square(48),
        padding: const EdgeInsets.all(12),
      ),
    );
  }
}

const _shape = RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12)));
const _textStyle = TextStyle(fontSize: 15, fontWeight: FontWeight.w700);
const _padding = EdgeInsets.symmetric(vertical: 14);
const _minimumSize = Size.fromHeight(48);

ButtonStyle _primaryStyle(ColorScheme scheme) => TextButton.styleFrom(
  backgroundColor: scheme.primary,
  foregroundColor: scheme.onPrimary,
  disabledBackgroundColor: scheme.onSurface.withValues(alpha: 0.08),
  disabledForegroundColor: scheme.onSurface.withValues(alpha: 0.3),
  overlayColor: scheme.onPrimary,
  elevation: 0,
  shape: _shape,
  padding: _padding,
  minimumSize: _minimumSize,
  textStyle: _textStyle,
);

ButtonStyle _secondaryStyle(ColorScheme scheme) => TextButton.styleFrom(
  backgroundColor: Colors.transparent,
  foregroundColor: scheme.onSurface,
  disabledForegroundColor: scheme.onSurface.withValues(alpha: 0.3),
  overlayColor: scheme.primary,
  side: BorderSide(color: scheme.onSurface.withValues(alpha: 0.2)),
  elevation: 0,
  shape: _shape,
  padding: _padding,
  minimumSize: _minimumSize,
  textStyle: _textStyle,
);
