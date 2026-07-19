import 'package:flutter/material.dart';
import 'package:poker_companion/core/themes.dart';
import 'package:poker_companion/core/utility.dart';
import 'package:poker_companion/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Root extends StatefulWidget {
  const Root({super.key, required this.initThemeKey});
  final String initThemeKey;

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  late String _activeTheme = widget.initThemeKey;
  late ThemeData _theme = AppTheme.themeFor(_activeTheme);

  Future<void> setTheme(String id) async {
    setState(() {
      _activeTheme = id;
      _theme = AppTheme.themeFor(id);
    });
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('themeID', id);
  }

  // root
  @override
  Widget build(BuildContext context) {
    return ThemeController(
      setTheme: setTheme,
      activeTheme: _activeTheme,
      child: MaterialApp(
        title: 'Poker Companion',
        theme: _theme,
        home: const HomePage(title: 'home page'),
        color: Colors.cyan,
      ),
    );
  }
}
