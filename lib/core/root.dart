import 'package:flutter/material.dart';
import 'package:poker_companion/core/themes.dart';
import 'package:poker_companion/core/utility.dart';
import 'package:poker_companion/l10n/app_localizations.dart';
import 'package:poker_companion/screens/home_screen.dart';

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  late String _activeTheme = PrefValues.savedThemeId;
  late ThemeData _theme = AppTheme.themeFor(_activeTheme);
  Locale? _locale = _localeFromCode(PrefValues.savedLocaleCode);

  static Locale? _localeFromCode(String? code) => code == null ? null : Locale(code);

  Future<void> setTheme(String id) async {
    setState(() {
      _activeTheme = id;
      _theme = AppTheme.themeFor(id);
    });
    PrefValues.savedThemeId = id;
  }

  void setLocale(Locale? locale) {
    setState(() => _locale = locale);
    PrefValues.savedLocaleCode = locale?.languageCode;
  }

  // root
  @override
  Widget build(BuildContext context) {
    return ThemeController(
      setTheme: setTheme,
      activeTheme: _activeTheme,
      colorScheme: _theme.colorScheme,
      child: LocaleController(
        setLocale: setLocale,
        locale: _locale,
        child: MaterialApp(
          onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
          theme: _theme,
          locale: _locale,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const HomePage(),
        ),
      ),
    );
  }
}
