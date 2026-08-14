import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:path_provider/path_provider.dart';
import 'package:poker_companion/core/payout_data.dart';
import 'package:poker_companion/screens/history_screen.dart';
import 'package:share_plus/share_plus.dart';
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

class LocaleController extends InheritedWidget {
  const LocaleController({super.key, required this.setLocale, required this.locale, required super.child});

  final void Function(Locale?) setLocale;
  final Locale? locale;

  static LocaleController of(BuildContext context) => context.dependOnInheritedWidgetOfExactType<LocaleController>()!;

  @override
  bool updateShouldNotify(LocaleController old) => locale != old.locale;
}

Future<File> _appDataFile(String fileName) async {
  final docsDir = await getApplicationDocumentsDirectory();
  final appDir = Directory('${docsDir.path}/PokerPayoutCalculator');
  await appDir.create(recursive: true);
  return File('${appDir.path}/$fileName');
}

class HistoryUtility {
  static Future<File> _file() => _appDataFile('history.json');

  static Future<void> save(List<HistoryData> sessions) async {
    final file = await _file();
    await file.writeAsString(jsonEncode(sessions.map((s) => s.toJSON()).toList()));
  }

  static Future<List<HistoryData>> load() async {
    final file = await _file();
    if (!await file.exists()) return [];
    try {
      final data = jsonDecode(await file.readAsString()) as List<dynamic>;
      return data.map((j) => HistoryData.fromJSON(j)).toList();
    } catch (_) {
      return [];
    }
  }

  static Future<void> clear() async {
    List<HistoryData> sessions = await load();
    sessions.clear();
    save(sessions);
  }
}

class SessionUtility {
  static Future<File> _file() => _appDataFile('presets.json');

  static Future<void> save(List<Preset> presets) async {
    final file = await _file();
    await file.writeAsString(jsonEncode(presets.map((p) => p.toJSON()).toList()));
  }

  static Future<List<Preset>> load() async {
    final file = await _file();
    if (!await file.exists()) return [];
    try {
      final data = jsonDecode(await file.readAsString()) as List<dynamic>;
      return data.map((j) => Preset.fromJSON(j)).toList();
    } catch (_) {
      return [];
    }
  }

  static Future<void> clear() async {
    List<Preset> presets = await load();
    presets.clear();
    save(presets);
  }
}

class PrefValues {
  static late final SharedPreferences prefs;
  static Future<void> init() async => prefs = await SharedPreferences.getInstance();

  static String get savedThemeId => prefs.getString('themeID') ?? '0';
  static int get savedPlayerCount => prefs.getInt('playerCount') ?? 1;
  static bool get adsRemoved => prefs.getBool('adsRemoved') ?? false;
  static String? get savedLocaleCode => prefs.getString('localeCode');
  static bool get hasSeenSessionTutorial => prefs.getBool('hasSeenSessionTutorial') ?? false;

  static set savedThemeId(String value) => prefs.setString('themeID', value);
  static set savedPlayerCount(int value) => prefs.setInt('playerCount', value);
  static set adsRemoved(bool value) => prefs.setBool('adsRemoved', value);
  static set hasSeenSessionTutorial(bool value) => prefs.setBool('hasSeenSessionTutorial', value);
  static set savedLocaleCode(String? value) {
    if (value == null) {
      prefs.remove('localeCode');
    } else {
      prefs.setString('localeCode', value);
    }
  }
}

class ScreenCapture {
  static Future<void> share(GlobalKey key, {String fileName = 'poker_session.png'}) async {
    final boundary = key.currentContext!.findRenderObject() as RenderRepaintBoundary;
    final image = await boundary.toImage(pixelRatio: 3.0);
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    final bytes = byteData!.buffer.asUint8List();

    if (Platform.isWindows) {
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/$fileName');
      await file.writeAsBytes(bytes);
      return;
    }

    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/$fileName');
    await file.writeAsBytes(bytes);

    await SharePlus.instance.share(ShareParams(files: [XFile(file.path)]));
  }
}
