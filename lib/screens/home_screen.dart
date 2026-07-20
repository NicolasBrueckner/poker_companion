import 'package:poker_companion/core/utility.dart';
import 'package:poker_companion/screens/payout_screen.dart';
import 'package:poker_companion/screens/settings_screen.dart';
import 'package:poker_companion/screens/statistics_screen.dart';
import 'package:poker_companion/widgets/base_button.dart';
import 'package:flutter/material.dart';
import 'package:poker_companion/widgets/suits_row.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 0.5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SuitsRowWidget(),
              BaseButton(
                label: 'Payout Calculator',
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => PayoutScreen())),
              ),
              BaseButton(
                label: 'Statistics',
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => StatisticsScreen())),
              ),
              BaseButton(
                label: 'Settings',
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => SettingsScreen())),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
