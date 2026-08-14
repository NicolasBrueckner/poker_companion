// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Poker Payout Calculator';

  @override
  String get newSession => 'Nouvelle Session';

  @override
  String get history => 'Historique';

  @override
  String get settings => 'Paramètres';

  @override
  String get cancel => 'Annuler';

  @override
  String get delete => 'Supprimer';

  @override
  String get update => 'Mettre à jour';

  @override
  String get close => 'Fermer';

  @override
  String get tableHeaderPlayer => 'Joueur';

  @override
  String get tableHeaderBuyIn => 'Mise';

  @override
  String get tableHeaderCashOut => 'Retrait';

  @override
  String get tableHeaderNet => 'Net';

  @override
  String get addPlayer => '+ Ajouter un joueur';

  @override
  String get calculate => 'Calculer';

  @override
  String get edit => 'Modifier';

  @override
  String get save => 'Enregistrer';

  @override
  String totalsMismatch(String sumIn, String sumOut) {
    return 'Les totaux ne correspondent pas - mises : $sumIn, retraits : $sumOut';
  }

  @override
  String get sessionSaved => 'Session enregistrée';

  @override
  String get presetSaved => 'Modèle enregistré';

  @override
  String get noSettlementsNeeded => 'Aucun règlement nécessaire';

  @override
  String get settlements => 'Règlements';

  @override
  String get nameHint => 'Nom';

  @override
  String get noSessionsSavedYet => 'Aucune session enregistrée pour le moment';

  @override
  String potLabel(String amount) {
    return 'Pot  $amount';
  }

  @override
  String get deleteSessionTitle => 'Supprimer la session ?';

  @override
  String get deleteSessionContent =>
      'Cette session sera définitivement supprimée.';

  @override
  String get loadPreset => 'Charger un modèle';

  @override
  String get noPresetsSavedYet => 'Aucun modèle enregistré pour le moment';

  @override
  String get updatePresetTitle => 'Mettre à jour le modèle ?';

  @override
  String get updatePresetContent =>
      'Cela remplacera le modèle précédemment enregistré.';

  @override
  String get updatePresetButton => '+ Mettre à jour le modèle';

  @override
  String get savePresetButton =>
      '+ Enregistrer la session actuelle comme modèle';

  @override
  String get deletePresetTitle => 'Supprimer le modèle ?';

  @override
  String get deletePresetContent => 'Ce modèle sera définitivement supprimé.';

  @override
  String playersCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count joueurs',
      one: '1 joueur',
    );
    return '$_temp0';
  }

  @override
  String get appearanceSection => 'APPARENCE';

  @override
  String get gameDefaultsSection => 'PARAMÈTRES PAR DÉFAUT';

  @override
  String get generalSection => 'GÉNÉRAL';

  @override
  String get languageSection => 'LANGUE';

  @override
  String get defaultPlayerCount => 'Nombre de joueurs par défaut';

  @override
  String get removeAds => 'Supprimer les publicités';

  @override
  String get adsRemoved => 'Publicités supprimées';

  @override
  String get restorePurchases => 'Restaurer les achats';

  @override
  String get about => 'À propos';

  @override
  String get couldNotOpenLink => 'Impossible d\'ouvrir le lien';

  @override
  String get privacyPolicy => 'Politique de confidentialité';

  @override
  String appVersion(String version) {
    return 'Version $version';
  }

  @override
  String copyrightNotice(int year) {
    return 'Copyright © $year Mosscode Studios.\nTous droits réservés.';
  }

  @override
  String get lightTheme => 'CLAIR';

  @override
  String get darkTheme => 'SOMBRE';

  @override
  String get systemDefault => 'Par défaut du système';

  @override
  String get pokerSessionHeading => 'Poker Session';

  @override
  String get tutorialPresetTitle => 'Préréglages';

  @override
  String get tutorialPresetDescription =>
      'Enregistrez un groupe de joueurs comme préréglage et rechargez-le lors de prochaines sessions.';

  @override
  String get tutorialResetTitle => 'Réinitialiser';

  @override
  String get tutorialResetDescription =>
      'Videz le tableau et démarrez une nouvelle session.';

  @override
  String get tutorialShareTitle => 'Partager';

  @override
  String get tutorialShareDescription =>
      'Une fois le calcul effectué, partagez un aperçu des résultats avec votre groupe.';

  @override
  String get tutorialDeleteTitle => 'Supprimer un joueur';

  @override
  String get tutorialDeleteDescription =>
      'Balayez une ligne de joueur vers la gauche pour la supprimer.';

  @override
  String get tutorialCalculateTitle => 'Calculer';

  @override
  String get tutorialCalculateDescription =>
      'Saisissez les mises et les gains, puis appuyez ici pour calculer qui paie qui.';

  @override
  String get tutorialNext => 'Suivant';

  @override
  String get tutorialSkip => 'Passer';

  @override
  String get tutorialGotIt => 'Compris';
}
