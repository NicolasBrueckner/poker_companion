import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:poker_companion/core/root.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  final prefs = await SharedPreferences.getInstance();
  final savedThemeKey = prefs.getString('themeID') ?? '0';
  runApp(Root(initThemeKey: savedThemeKey));
}
