import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:poker_companion/core/root.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await PrefValues.init();
  runApp(Root());
}

class PrefValues {
  static late final SharedPreferences prefs;
  static Future<void> init() async => prefs = await SharedPreferences.getInstance();

  static String get savedThemeId => prefs.getString('themeID') ?? '0';
  static int get savedPlayerCount => prefs.getInt('playerCount') ?? 1;

  static set savedThemeId(String value) => prefs.setString('themeID', value);
  static set savedPlayerCount(int value) => prefs.setInt('playerCount', value);
}
