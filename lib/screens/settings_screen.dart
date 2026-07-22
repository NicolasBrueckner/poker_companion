import 'package:flutter/material.dart';
import 'package:poker_companion/core/utility.dart';
import 'package:poker_companion/screens/base_screen.dart';
import 'package:poker_companion/widgets/colorswitch.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  int _playerCount = PrefValues.savedPlayerCount;

  void _increment() => setState(() {
    _playerCount++;
    PrefValues.savedPlayerCount = _playerCount;
  });

  void _decrement() {
    if (_playerCount > 1) {
      setState(() {
        _playerCount--;
        PrefValues.savedPlayerCount = _playerCount;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return BaseScreen(
      title: 'Settings',
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ColorSwitch(),
            const SizedBox(height: 24),
            Text(
              'DEFAULT PLAYER COUNT',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: scheme.onSurface.withValues(alpha: 0.55),
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _StepButton(icon: Icons.remove, onPressed: _playerCount > 1 ? _decrement : null, scheme: scheme),
                const SizedBox(width: 4),
                Container(
                  width: 48,
                  alignment: Alignment.center,
                  child: Text(
                    '$_playerCount',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: scheme.onSurface),
                  ),
                ),
                const SizedBox(width: 4),
                _StepButton(icon: Icons.add, onPressed: _increment, scheme: scheme),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StepButton extends StatelessWidget {
  const _StepButton({required this.icon, required this.onPressed, required this.scheme});
  final IconData icon;
  final VoidCallback? onPressed;
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    final enabled = onPressed != null;
    return GestureDetector(
      onTap: onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: enabled ? scheme.primary : scheme.onSurface.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, size: 20, color: enabled ? scheme.onPrimary : scheme.onSurface.withValues(alpha: 0.3)),
      ),
    );
  }
}
