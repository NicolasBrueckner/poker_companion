import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:poker_companion/core/utility.dart';
import 'package:poker_companion/screens/base_screen.dart';
import 'package:poker_companion/widgets/buttons.dart';
import 'package:poker_companion/widgets/colorswitch.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> with SingleTickerProviderStateMixin {
  int _playerCount = PrefValues.savedPlayerCount;

  late final AnimationController _spadeController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 400),
  );
  late final Animation<double> _spadeScale = TweenSequence<double>([
    TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.0).chain(CurveTween(curve: Curves.easeOut)), weight: 40),
    TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.0).chain(CurveTween(curve: Curves.easeIn)), weight: 60),
  ]).animate(_spadeController);

  ColorScheme? _previousScheme;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final scheme = ThemeController.of(context).colorScheme;
    if (_previousScheme != null && _previousScheme != scheme) {
      _spadeController.forward(from: 0);
    }
    _previousScheme = scheme;
  }

  @override
  void dispose() {
    _spadeController.dispose();
    super.dispose();
  }

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
    final scheme = ThemeController.of(context).colorScheme;
    return BaseScreen(
      title: 'Settings',
      actions: [
        for (final suit in ['club', 'heart', 'spade', 'diamond'])
          ScaleTransition(
            scale: _spadeScale,
            child: SvgPicture.asset(
              'assets/playing-cards/suits/$suit.svg',
              width: 32,
              height: 32,
              colorMapper: OutlineMapper(scheme.onSurface, scheme.primary),
            ),
          ),
      ],
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 20,
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
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _StepButton(icon: Icons.remove, onPressed: _playerCount > 1 ? _decrement : null),
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
                _StepButton(icon: Icons.add, onPressed: _increment),
              ],
            ),
            const SizedBox(height: 8),
            BaseTextButton(label: 'Remove ads'),
          ],
        ),
      ),
    );
  }
}

class _StepButton extends StatelessWidget {
  const _StepButton({required this.icon, required this.onPressed});
  final IconData icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final enabled = onPressed != null;
    final scheme = ThemeController.of(context).colorScheme;
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
