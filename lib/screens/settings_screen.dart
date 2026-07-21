import 'package:flutter/material.dart';
import 'package:poker_companion/screens/base_screen.dart';
import 'package:poker_companion/widgets/colorswitch.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const BaseScreen(
      title: 'Settings',
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 12),
        child: ColorSwitch(),
      ),
    );
  }
}
