import 'package:flutter/material.dart';
import 'package:poker_companion/screens/base_screen.dart';
import 'package:poker_companion/screens/session_screen.dart';
import 'package:poker_companion/screens/settings_screen.dart';
import 'package:poker_companion/screens/history_screen.dart';
import 'package:poker_companion/widgets/buttons.dart';
import 'package:poker_companion/widgets/suits_row.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 12),
          const SuitsRowWidget(),
          const SizedBox(height: 40),
          BaseTextButton(
            label: 'New Session',
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SessionScreen())),
          ),
          const SizedBox(height: 12),
          BaseTextButton(
            label: 'History',
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const HistoryScreen())),
          ),
          const SizedBox(height: 12),
          BaseTextButton(
            label: 'Settings',
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsScreen())),
          ),
        ],
      ),
    );
  }
}
