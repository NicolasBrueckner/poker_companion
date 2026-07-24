import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:path_provider/path_provider.dart';
import 'package:poker_companion/screens/history_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OutlineMapper extends ColorMapper {
  const OutlineMapper(this.black, this.red);
  final Color red;
  final Color black;

  @override
  Color substitute(String? id, String elementName, String attributeName, Color color) {
    if (color == Color(0xFFFFFFFF)) {
      return red;
    } else if (color == Color(0xFF000000)) {
      return black;
    }
    return color;
  }
}

class ThemeController extends InheritedWidget {
  const ThemeController({
    super.key,
    required this.setTheme,
    required this.activeTheme,
    required this.colorScheme,
    required super.child,
  });

  final void Function(String) setTheme;
  final String activeTheme;
  final ColorScheme colorScheme;

  static ThemeController of(BuildContext context) => context.dependOnInheritedWidgetOfExactType<ThemeController>()!;

  @override
  bool updateShouldNotify(ThemeController old) => activeTheme != old.activeTheme || colorScheme != old.colorScheme;
}

class SessionUtility {
  static Future<File> _file() async {
    final dir = await getApplicationDocumentsDirectory();
    return File('${dir.path}/sessions.json');
  }

  static Future<void> save(List<SessionInfo> sessions) async {
    final file = await _file();
    await file.writeAsString(jsonEncode(sessions.map((s) => s.toJSON()).toList()));
  }

  static Future<List<SessionInfo>> load() async {
    final file = await _file();
    if (!await file.exists()) return [];
    final data = jsonDecode(await file.readAsString()) as List<dynamic>;
    return data.map((j) => SessionInfo.fromJSON(j)).toList();
  }

  static Future<void> clear() async {
    List<SessionInfo> sessions = await load();
    sessions.clear();
    save(sessions);
  }
}

class PrefValues {
  static late final SharedPreferences prefs;
  static Future<void> init() async => prefs = await SharedPreferences.getInstance();

  static String get savedThemeId => prefs.getString('themeID') ?? '0';
  static int get savedPlayerCount => prefs.getInt('playerCount') ?? 1;

  static set savedThemeId(String value) => prefs.setString('themeID', value);
  static set savedPlayerCount(int value) => prefs.setInt('playerCount', value);
}
