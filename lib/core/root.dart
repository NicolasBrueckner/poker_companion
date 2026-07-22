import 'package:flutter/material.dart';
import 'package:poker_companion/core/themes.dart';
import 'package:poker_companion/core/utility.dart';
import 'package:poker_companion/screens/home_screen.dart';

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  late String _activeTheme = PrefValues.savedThemeId;
  late ThemeData _theme = AppTheme.themeFor(_activeTheme);

  Future<void> setTheme(String id) async {
    setState(() {
      _activeTheme = id;
      _theme = AppTheme.themeFor(id);
    });
    PrefValues.savedThemeId = id;
  }

  // root
  @override
  Widget build(BuildContext context) {
    return ThemeController(
      setTheme: setTheme,
      activeTheme: _activeTheme,
      colorScheme: Theme.of(context).colorScheme,
      child: MaterialApp(
        title: 'Poker Companion',
        theme: _theme,
        home: const HomePage(title: 'Poker Companion'),
      ),
    );
  }
}
