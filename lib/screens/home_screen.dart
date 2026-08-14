import 'package:flutter/material.dart';
import 'package:poker_companion/l10n/app_localizations.dart';
import 'package:poker_companion/screens/base_screen.dart';
import 'package:poker_companion/screens/session_screen.dart';
import 'package:poker_companion/screens/settings_screen.dart';
import 'package:poker_companion/screens/history_screen.dart';
import 'package:poker_companion/widgets/buttons.dart';
import 'package:poker_companion/widgets/suits_row.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BaseScreen(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 12),
          const SuitsRowWidget(),
          const SizedBox(height: 40),
          BaseTextButton(
            label: l10n.newSession,
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SessionScreen())),
          ),
          const SizedBox(height: 12),
          BaseTextButton(
            label: l10n.history,
            primary: false,
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const HistoryScreen())),
          ),
          const SizedBox(height: 12),
          BaseTextButton(
            label: l10n.settings,
            primary: false,
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsScreen())),
          ),
        ],
      ),
    );
  }
}
