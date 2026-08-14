// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'Poker Payout Calculator';

  @override
  String get newSession => 'Neue Session';

  @override
  String get history => 'Verlauf';

  @override
  String get settings => 'Einstellungen';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get delete => 'Löschen';

  @override
  String get update => 'Aktualisieren';

  @override
  String get close => 'Schließen';

  @override
  String get tableHeaderPlayer => 'Spieler';

  @override
  String get tableHeaderBuyIn => 'Einsatz';

  @override
  String get tableHeaderCashOut => 'Auszahlung';

  @override
  String get tableHeaderNet => 'Netto';

  @override
  String get addPlayer => '+ Spieler hinzufügen';

  @override
  String get calculate => 'Berechnen';

  @override
  String get edit => 'Bearbeiten';

  @override
  String get save => 'Speichern';

  @override
  String totalsMismatch(String sumIn, String sumOut) {
    return 'Summen stimmen nicht überein - Einsatz: $sumIn, Auszahlung: $sumOut';
  }

  @override
  String get sessionSaved => 'Session gespeichert';

  @override
  String get presetSaved => 'Vorlage gespeichert';

  @override
  String get noSettlementsNeeded => 'Keine Ausgleichszahlungen nötig';

  @override
  String get settlements => 'Ausgleichszahlungen';

  @override
  String get nameHint => 'Name';

  @override
  String get noSessionsSavedYet => 'Noch keine Sessions gespeichert';

  @override
  String potLabel(String amount) {
    return 'Pot  $amount';
  }

  @override
  String get deleteSessionTitle => 'Session löschen?';

  @override
  String get deleteSessionContent => 'Diese Session wird dauerhaft gelöscht.';

  @override
  String get loadPreset => 'Vorlage laden';

  @override
  String get noPresetsSavedYet => 'Noch keine Vorlagen gespeichert';

  @override
  String get updatePresetTitle => 'Vorlage aktualisieren?';

  @override
  String get updatePresetContent =>
      'Die zuvor gespeicherte Vorlage wird überschrieben.';

  @override
  String get updatePresetButton => '+ Vorlage aktualisieren';

  @override
  String get savePresetButton => '+ Aktuelle Session als Vorlage speichern';

  @override
  String get deletePresetTitle => 'Vorlage löschen?';

  @override
  String get deletePresetContent => 'Diese Vorlage wird dauerhaft gelöscht.';

  @override
  String playersCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Spieler',
      one: '1 Spieler',
    );
    return '$_temp0';
  }

  @override
  String get appearanceSection => 'DARSTELLUNG';

  @override
  String get gameDefaultsSection => 'SPIELVOREINSTELLUNGEN';

  @override
  String get generalSection => 'ALLGEMEIN';

  @override
  String get languageSection => 'SPRACHE';

  @override
  String get defaultPlayerCount => 'Standardanzahl Spieler';

  @override
  String get removeAds => 'Werbung entfernen';

  @override
  String get adsRemoved => 'Werbung entfernt';

  @override
  String get restorePurchases => 'Käufe wiederherstellen';

  @override
  String get about => 'Über';

  @override
  String get couldNotOpenLink => 'Link konnte nicht geöffnet werden';

  @override
  String get privacyPolicy => 'Datenschutzerklärung';

  @override
  String appVersion(String version) {
    return 'Version $version';
  }

  @override
  String copyrightNotice(int year) {
    return 'Copyright © $year Mosscode Studios.\nAlle Rechte vorbehalten.';
  }

  @override
  String get lightTheme => 'HELL';

  @override
  String get darkTheme => 'DUNKEL';

  @override
  String get systemDefault => 'Systemstandard';

  @override
  String get pokerSessionHeading => 'Poker Session';

  @override
  String get tutorialPresetTitle => 'Vorlagen';

  @override
  String get tutorialPresetDescription =>
      'Speichere eine Gruppe von Spielern als Vorlage und lade sie in zukünftigen Sessions erneut.';

  @override
  String get tutorialResetTitle => 'Zurücksetzen';

  @override
  String get tutorialResetDescription =>
      'Leere die Tabelle und starte eine neue Session.';

  @override
  String get tutorialShareTitle => 'Teilen';

  @override
  String get tutorialShareDescription =>
      'Teile nach der Berechnung eine Übersicht der Ergebnisse mit deiner Gruppe.';

  @override
  String get tutorialDeleteTitle => 'Spieler löschen';

  @override
  String get tutorialDeleteDescription =>
      'Wische eine Spielerzeile nach links, um sie zu entfernen.';

  @override
  String get tutorialCalculateTitle => 'Berechnen';

  @override
  String get tutorialCalculateDescription =>
      'Trage Einsätze und Auszahlungen ein und tippe dann hier, um zu berechnen, wer wem zahlt.';

  @override
  String get tutorialNext => 'Weiter';

  @override
  String get tutorialSkip => 'Überspringen';

  @override
  String get tutorialGotIt => 'Verstanden';
}
