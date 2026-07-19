import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:path_provider/path_provider.dart';
import 'package:poker_companion/screens/statistics_screen.dart';

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
  const ThemeController({super.key, required this.setTheme, required this.activeTheme, required super.child});

  final void Function(String) setTheme;
  final String activeTheme;

  static ThemeController of(BuildContext context) => context.dependOnInheritedWidgetOfExactType<ThemeController>()!;

  @override
  bool updateShouldNotify(ThemeController old) => activeTheme != old.activeTheme;
}

class SessionUtility {
  Future<File> _file() async {
    final dir = await getApplicationDocumentsDirectory();
    return File('${dir.path}/sessions.json');
  }

  Future<void> save(List<SessionInfo> sessions) async {
    final file = await _file();
    await file.writeAsString(jsonEncode(sessions.map((s) => s.toJSON().toString())));
  }

  Future<List<SessionInfo>> load() async {
    final file = await _file();
    if (!await file.exists()) return [];
    final data = jsonDecode(await file.readAsString()) as List<dynamic>;
    return data.map((j) => SessionInfo.fromJSON(j)).toList();
  }
}
