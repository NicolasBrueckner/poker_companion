import 'package:flutter/material.dart';
import 'package:poker_companion/screens/base_screen.dart';
import 'package:poker_companion/screens/payout_screen.dart';
import 'package:poker_companion/screens/settings_screen.dart';
import 'package:poker_companion/screens/statistics_screen.dart';
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
            label: 'Payout Calculator',
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PayoutScreen())),
          ),
          const SizedBox(height: 12),
          BaseTextButton(
            label: 'Statistics',
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const StatisticsScreen())),
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
