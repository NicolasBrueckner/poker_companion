import 'package:flutter/material.dart';

const globalColorSchemes = {
  '0': (Color(0xFFFAF7F2), Color(0xFF1F2430), Color(0xFFD4213D), Brightness.light),
  '1': (Color(0xFFF5F8F3), Color(0xFF262222), Color(0xFF3A5A41), Brightness.light),
  '2': (Color(0xFFFBF6F1), Color(0xFF2A2320), Color(0xFF8F4228), Brightness.light),
  '3': (Color(0xFFF3F6F7), Color(0xFF222829), Color(0xFF35576B), Brightness.light),
  '4': (Color(0xFF1E2420), Color(0xFFE8EFE9), Color(0xFF9FC6A6), Brightness.dark),
  '5': (Color(0xFF241F1A), Color(0xFFF0E9DE), Color(0xFFD9BE8C), Brightness.dark),
  '6': (Color(0xFF1B2124), Color(0xFFE4ECEF), Color(0xFFA8C4D2), Brightness.dark),
  '7': (Color(0xFF221D20), Color(0xFFEDE6E8), Color(0xFFD3A9B6), Brightness.dark),
  'default': (Colors.white, Colors.black, Colors.red, Brightness.light),
};

class AppTheme {
  static ThemeData themeFor(String id) {
    final (surface, onSurface, accent, brightness) = globalColorSchemes.containsKey(id)
        ? globalColorSchemes[id]!
        : globalColorSchemes['default']!;
    return _build(_scheme(surface, onSurface, accent, brightness));
  }

  static ThemeData _build(ColorScheme scheme) => ThemeData(
    colorScheme: scheme,
    useMaterial3: true,
    fontFamily: 'Nunito',
    textTheme: _text(),
    outlinedButtonTheme: _outlinedButton(scheme),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: scheme.onPrimary,
      selectionColor: scheme.onPrimary.withValues(alpha: 0.3),
      selectionHandleColor: scheme.onPrimary,
    ),
  );

  static ColorScheme _scheme(Color surface, Color onSurface, Color accent, Brightness brightness) {
    if (brightness == Brightness.light) {
      return ColorScheme.light(surface: surface, onSurface: onSurface, primary: accent, onPrimary: surface);
    }
    return ColorScheme.dark(surface: surface, onSurface: onSurface, primary: accent, onPrimary: surface);
  }

  static OutlinedButtonThemeData _outlinedButton(ColorScheme scheme) {
    const BorderSide baseSide = BorderSide(
      width: 1.0,
      strokeAlign: BorderSide.strokeAlignInside,
      style: BorderStyle.solid,
    );

    return OutlinedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
          if (states.contains(WidgetState.pressed)) {
            return scheme.primary;
          }
          return scheme.surface;
        }),
        foregroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
          if (states.contains(WidgetState.pressed)) {
            return scheme.surface;
          }
          return scheme.onSurface;
        }),
        side: WidgetStateProperty.resolveWith<BorderSide?>((states) {
          if (states.contains(WidgetState.pressed)) {
            return baseSide.copyWith(color: scheme.primary);
          }
          return baseSide.copyWith(color: scheme.onSurface);
        }),
      ),
    );
  }

  static TextTheme _text() {
    return TextTheme(headlineSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.w600));
  }
}
