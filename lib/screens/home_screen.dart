import 'package:poker_companion/screens/base_screen.dart';
import 'package:poker_companion/screens/payout_screen.dart';
import 'package:poker_companion/screens/settings_screen.dart';
import 'package:poker_companion/screens/statistics_screen.dart';
import 'package:poker_companion/widgets/buttons.dart';
import 'package:flutter/material.dart';
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
        spacing: 17,
        children: [
          SuitsRowWidget(),
          SizedBox(height: 20),
          BaseTextButton(
            label: 'Calculator',
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => PayoutScreen())),
          ),
          BaseTextButton(
            label: 'Statistics',
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => StatisticsScreen())),
          ),
          BaseTextButton(
            label: 'Settings',
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => SettingsScreen())),
          ),
        ],
      ),
    );
  }
}
