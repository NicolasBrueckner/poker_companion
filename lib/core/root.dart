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
  ThemeData _theme = AppTheme.themeFor('4');

  void setTheme(String id) => setState(() => _theme = AppTheme.themeFor(id));

  // root
  @override
  Widget build(BuildContext context) {
    return ThemeController(
      setTheme: setTheme,
      child: MaterialApp(
        title: 'Poker Companion',
        theme: _theme,
        home: const HomePage(title: 'home page'),
        color: Colors.cyan,
      ),
    );
  }
}
