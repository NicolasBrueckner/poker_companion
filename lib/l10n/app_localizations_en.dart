// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Poker Payout Calculator';

  @override
  String get newSession => 'New Session';

  @override
  String get history => 'History';

  @override
  String get settings => 'Settings';

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get update => 'Update';

  @override
  String get close => 'Close';

  @override
  String get tableHeaderPlayer => 'Player';

  @override
  String get tableHeaderBuyIn => 'Buy In';

  @override
  String get tableHeaderCashOut => 'Cash Out';

  @override
  String get tableHeaderNet => 'Net';

  @override
  String get addPlayer => '+ Add Player';

  @override
  String get calculate => 'Calculate';

  @override
  String get edit => 'Edit';

  @override
  String get save => 'Save';

  @override
  String totalsMismatch(String sumIn, String sumOut) {
    return 'Totals don\'t match - in: $sumIn, out: $sumOut';
  }

  @override
  String get sessionSaved => 'Session saved';

  @override
  String get presetSaved => 'Preset saved';

  @override
  String get noSettlementsNeeded => 'No settlements needed';

  @override
  String get settlements => 'Settlements';

  @override
  String get nameHint => 'Name';

  @override
  String get noSessionsSavedYet => 'No sessions saved yet';

  @override
  String potLabel(String amount) {
    return 'Pot  $amount';
  }

  @override
  String get deleteSessionTitle => 'Delete session?';

  @override
  String get deleteSessionContent =>
      'This session will be permanently removed.';

  @override
  String get loadPreset => 'Load Preset';

  @override
  String get noPresetsSavedYet => 'No presets saved yet';

  @override
  String get updatePresetTitle => 'Update preset?';

  @override
  String get updatePresetContent =>
      'This will overwrite the previously saved preset.';

  @override
  String get updatePresetButton => '+ Update Preset';

  @override
  String get savePresetButton => '+ Save Current as Preset';

  @override
  String get deletePresetTitle => 'Delete preset?';

  @override
  String get deletePresetContent => 'This preset will be permanently removed.';

  @override
  String playersCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count players',
      one: '1 player',
    );
    return '$_temp0';
  }

  @override
  String get appearanceSection => 'APPEARANCE';

  @override
  String get gameDefaultsSection => 'GAME DEFAULTS';

  @override
  String get generalSection => 'GENERAL';

  @override
  String get languageSection => 'LANGUAGE';

  @override
  String get defaultPlayerCount => 'Default player count';

  @override
  String get removeAds => 'Remove ads';

  @override
  String get adsRemoved => 'Ads removed';

  @override
  String get restorePurchases => 'Restore purchases';

  @override
  String get about => 'About';

  @override
  String get couldNotOpenLink => 'Could not open link';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String appVersion(String version) {
    return 'Version $version';
  }

  @override
  String copyrightNotice(int year) {
    return 'Copyright © $year Mosscode Studios.\n All rights reserved.';
  }

  @override
  String get lightTheme => 'LIGHT';

  @override
  String get darkTheme => 'DARK';

  @override
  String get systemDefault => 'System default';

  @override
  String get pokerSessionHeading => 'Poker Session';
}
