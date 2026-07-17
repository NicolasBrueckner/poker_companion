import 'package:flutter/material.dart';

class BaseButton extends StatelessWidget {
  const BaseButton({super.key, required this.label, this.onPressed});
  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          alignment: Alignment.center,
        ),
        child: Text(label, textScaler: TextScaler.linear(1.7)),
      ),
    );
  }
}
