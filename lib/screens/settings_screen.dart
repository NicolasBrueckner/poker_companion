import 'package:flutter/material.dart';
import 'package:poker_companion/screens/base_screen.dart';
import 'package:poker_companion/widgets/colorswitch.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: 'Settings',
      child: Column(
        spacing: 10,
        children: [
          Text('Themes', style: Theme.of(context).textTheme.headlineSmall),
          FractionallySizedBox(widthFactor: 1, child: ColorSwitch()),
        ],
      ),
    );
  }
}
