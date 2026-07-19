import 'package:flutter/material.dart';
import 'package:poker_companion/widgets/colorswitch.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 0.8,
          child: Column(
            spacing: 10,
            children: [
              Text('Themes', style: Theme.of(context).textTheme.headlineSmall),
              FractionallySizedBox(widthFactor: 0.3, child: ColorSwitch()),
            ],
          ),
        ),
      ),
    );
  }
}
