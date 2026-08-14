import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
  ];

  /// Application title, shown as home/new session screen title and in the about dialog
  ///
  /// In en, this message translates to:
  /// **'Poker Payout Calculator'**
  String get appTitle;

  /// No description provided for @newSession.
  ///
  /// In en, this message translates to:
  /// **'New Session'**
  String get newSession;

  /// No description provided for @history.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get history;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @update.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @tableHeaderPlayer.
  ///
  /// In en, this message translates to:
  /// **'Player'**
  String get tableHeaderPlayer;

  /// No description provided for @tableHeaderBuyIn.
  ///
  /// In en, this message translates to:
  /// **'Buy In'**
  String get tableHeaderBuyIn;

  /// No description provided for @tableHeaderCashOut.
  ///
  /// In en, this message translates to:
  /// **'Cash Out'**
  String get tableHeaderCashOut;

  /// No description provided for @tableHeaderNet.
  ///
  /// In en, this message translates to:
  /// **'Net'**
  String get tableHeaderNet;

  /// No description provided for @addPlayer.
  ///
  /// In en, this message translates to:
  /// **'+ Add Player'**
  String get addPlayer;

  /// No description provided for @calculate.
  ///
  /// In en, this message translates to:
  /// **'Calculate'**
  String get calculate;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// Shown when buy-in and cash-out totals don't match
  ///
  /// In en, this message translates to:
  /// **'Totals don\'t match - in: {sumIn}, out: {sumOut}'**
  String totalsMismatch(String sumIn, String sumOut);

  /// No description provided for @sessionSaved.
  ///
  /// In en, this message translates to:
  /// **'Session saved'**
  String get sessionSaved;

  /// No description provided for @presetSaved.
  ///
  /// In en, this message translates to:
  /// **'Preset saved'**
  String get presetSaved;

  /// No description provided for @noSettlementsNeeded.
  ///
  /// In en, this message translates to:
  /// **'No settlements needed'**
  String get noSettlementsNeeded;

  /// No description provided for @settlements.
  ///
  /// In en, this message translates to:
  /// **'Settlements'**
  String get settlements;

  /// No description provided for @nameHint.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get nameHint;

  /// No description provided for @noSessionsSavedYet.
  ///
  /// In en, this message translates to:
  /// **'No sessions saved yet'**
  String get noSessionsSavedYet;

  /// Total pot amount shown on a history/preset card
  ///
  /// In en, this message translates to:
  /// **'Pot  {amount}'**
  String potLabel(String amount);

  /// No description provided for @deleteSessionTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete session?'**
  String get deleteSessionTitle;

  /// No description provided for @deleteSessionContent.
  ///
  /// In en, this message translates to:
  /// **'This session will be permanently removed.'**
  String get deleteSessionContent;

  /// No description provided for @loadPreset.
  ///
  /// In en, this message translates to:
  /// **'Load Preset'**
  String get loadPreset;

  /// No description provided for @noPresetsSavedYet.
  ///
  /// In en, this message translates to:
  /// **'No presets saved yet'**
  String get noPresetsSavedYet;

  /// No description provided for @updatePresetTitle.
  ///
  /// In en, this message translates to:
  /// **'Update preset?'**
  String get updatePresetTitle;

  /// No description provided for @updatePresetContent.
  ///
  /// In en, this message translates to:
  /// **'This will overwrite the previously saved preset.'**
  String get updatePresetContent;

  /// No description provided for @updatePresetButton.
  ///
  /// In en, this message translates to:
  /// **'+ Update Preset'**
  String get updatePresetButton;

  /// No description provided for @savePresetButton.
  ///
  /// In en, this message translates to:
  /// **'+ Save Current as Preset'**
  String get savePresetButton;

  /// No description provided for @deletePresetTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete preset?'**
  String get deletePresetTitle;

  /// No description provided for @deletePresetContent.
  ///
  /// In en, this message translates to:
  /// **'This preset will be permanently removed.'**
  String get deletePresetContent;

  /// Number of players in a preset
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{1 player} other{{count} players}}'**
  String playersCount(int count);

  /// No description provided for @appearanceSection.
  ///
  /// In en, this message translates to:
  /// **'APPEARANCE'**
  String get appearanceSection;

  /// No description provided for @gameDefaultsSection.
  ///
  /// In en, this message translates to:
  /// **'GAME DEFAULTS'**
  String get gameDefaultsSection;

  /// No description provided for @generalSection.
  ///
  /// In en, this message translates to:
  /// **'GENERAL'**
  String get generalSection;

  /// No description provided for @languageSection.
  ///
  /// In en, this message translates to:
  /// **'LANGUAGE'**
  String get languageSection;

  /// No description provided for @defaultPlayerCount.
  ///
  /// In en, this message translates to:
  /// **'Default player count'**
  String get defaultPlayerCount;

  /// No description provided for @removeAds.
  ///
  /// In en, this message translates to:
  /// **'Remove ads'**
  String get removeAds;

  /// No description provided for @adsRemoved.
  ///
  /// In en, this message translates to:
  /// **'Ads removed'**
  String get adsRemoved;

  /// No description provided for @restorePurchases.
  ///
  /// In en, this message translates to:
  /// **'Restore purchases'**
  String get restorePurchases;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @couldNotOpenLink.
  ///
  /// In en, this message translates to:
  /// **'Could not open link'**
  String get couldNotOpenLink;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// App version shown in the about dialog
  ///
  /// In en, this message translates to:
  /// **'Version {version}'**
  String appVersion(String version);

  /// Copyright notice in the about dialog
  ///
  /// In en, this message translates to:
  /// **'Copyright © {year} Mosscode Studios.\n All rights reserved.'**
  String copyrightNotice(int year);

  /// No description provided for @lightTheme.
  ///
  /// In en, this message translates to:
  /// **'LIGHT'**
  String get lightTheme;

  /// No description provided for @darkTheme.
  ///
  /// In en, this message translates to:
  /// **'DARK'**
  String get darkTheme;

  /// No description provided for @systemDefault.
  ///
  /// In en, this message translates to:
  /// **'System default'**
  String get systemDefault;

  /// No description provided for @pokerSessionHeading.
  ///
  /// In en, this message translates to:
  /// **'Poker Session'**
  String get pokerSessionHeading;

  /// No description provided for @tutorialPresetTitle.
  ///
  /// In en, this message translates to:
  /// **'Presets'**
  String get tutorialPresetTitle;

  /// No description provided for @tutorialPresetDescription.
  ///
  /// In en, this message translates to:
  /// **'Save a group of players as a preset and load them again in future sessions.'**
  String get tutorialPresetDescription;

  /// No description provided for @tutorialResetTitle.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get tutorialResetTitle;

  /// No description provided for @tutorialResetDescription.
  ///
  /// In en, this message translates to:
  /// **'Clear the table and start a fresh session.'**
  String get tutorialResetDescription;

  /// No description provided for @tutorialShareTitle.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get tutorialShareTitle;

  /// No description provided for @tutorialShareDescription.
  ///
  /// In en, this message translates to:
  /// **'Once calculated, share a snapshot of the results with your group.'**
  String get tutorialShareDescription;

  /// No description provided for @tutorialDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete a Player'**
  String get tutorialDeleteTitle;

  /// No description provided for @tutorialDeleteDescription.
  ///
  /// In en, this message translates to:
  /// **'Swipe a player row to the left to remove them.'**
  String get tutorialDeleteDescription;

  /// No description provided for @tutorialCalculateTitle.
  ///
  /// In en, this message translates to:
  /// **'Calculate'**
  String get tutorialCalculateTitle;

  /// No description provided for @tutorialCalculateDescription.
  ///
  /// In en, this message translates to:
  /// **'Enter buy-ins and cash-outs, then tap here to work out who pays whom.'**
  String get tutorialCalculateDescription;

  /// No description provided for @tutorialNext.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get tutorialNext;

  /// No description provided for @tutorialSkip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get tutorialSkip;

  /// No description provided for @tutorialGotIt.
  ///
  /// In en, this message translates to:
  /// **'Got it'**
  String get tutorialGotIt;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['de', 'en', 'es', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
