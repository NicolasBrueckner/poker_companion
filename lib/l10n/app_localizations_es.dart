// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Poker Payout Calculator';

  @override
  String get newSession => 'Nueva Sesión';

  @override
  String get history => 'Historial';

  @override
  String get settings => 'Ajustes';

  @override
  String get cancel => 'Cancelar';

  @override
  String get delete => 'Eliminar';

  @override
  String get update => 'Actualizar';

  @override
  String get close => 'Cerrar';

  @override
  String get tableHeaderPlayer => 'Jugador';

  @override
  String get tableHeaderBuyIn => 'Entrada';

  @override
  String get tableHeaderCashOut => 'Salida';

  @override
  String get tableHeaderNet => 'Neto';

  @override
  String get addPlayer => '+ Añadir jugador';

  @override
  String get calculate => 'Calcular';

  @override
  String get edit => 'Editar';

  @override
  String get save => 'Guardar';

  @override
  String totalsMismatch(String sumIn, String sumOut) {
    return 'Los totales no coinciden - entrada: $sumIn, salida: $sumOut';
  }

  @override
  String get sessionSaved => 'Sesión guardada';

  @override
  String get presetSaved => 'Plantilla guardada';

  @override
  String get noSettlementsNeeded => 'No se necesitan pagos';

  @override
  String get settlements => 'Pagos';

  @override
  String get nameHint => 'Nombre';

  @override
  String get noSessionsSavedYet => 'Aún no hay sesiones guardadas';

  @override
  String potLabel(String amount) {
    return 'Bote  $amount';
  }

  @override
  String get deleteSessionTitle => '¿Eliminar sesión?';

  @override
  String get deleteSessionContent =>
      'Esta sesión se eliminará permanentemente.';

  @override
  String get loadPreset => 'Cargar plantilla';

  @override
  String get noPresetsSavedYet => 'Aún no hay plantillas guardadas';

  @override
  String get updatePresetTitle => '¿Actualizar plantilla?';

  @override
  String get updatePresetContent =>
      'Esto sobrescribirá la plantilla guardada anteriormente.';

  @override
  String get updatePresetButton => '+ Actualizar plantilla';

  @override
  String get savePresetButton => '+ Guardar sesión actual como plantilla';

  @override
  String get deletePresetTitle => '¿Eliminar plantilla?';

  @override
  String get deletePresetContent =>
      'Esta plantilla se eliminará permanentemente.';

  @override
  String playersCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count jugadores',
      one: '1 jugador',
    );
    return '$_temp0';
  }

  @override
  String get appearanceSection => 'APARIENCIA';

  @override
  String get gameDefaultsSection => 'VALORES PREDETERMINADOS';

  @override
  String get generalSection => 'GENERAL';

  @override
  String get languageSection => 'IDIOMA';

  @override
  String get defaultPlayerCount => 'Número de jugadores predeterminado';

  @override
  String get removeAds => 'Quitar anuncios';

  @override
  String get adsRemoved => 'Anuncios eliminados';

  @override
  String get restorePurchases => 'Restaurar compras';

  @override
  String get about => 'Acerca de';

  @override
  String get couldNotOpenLink => 'No se pudo abrir el enlace';

  @override
  String get privacyPolicy => 'Política de privacidad';

  @override
  String appVersion(String version) {
    return 'Versión $version';
  }

  @override
  String copyrightNotice(int year) {
    return 'Copyright © $year Mosscode Studios.\nTodos los derechos reservados.';
  }

  @override
  String get lightTheme => 'CLARO';

  @override
  String get darkTheme => 'OSCURO';

  @override
  String get systemDefault => 'Predeterminado del sistema';

  @override
  String get pokerSessionHeading => 'Poker Session';

  @override
  String get tutorialPresetTitle => 'Preajustes';

  @override
  String get tutorialPresetDescription =>
      'Guarda un grupo de jugadores como preajuste y cárgalo de nuevo en futuras sesiones.';

  @override
  String get tutorialResetTitle => 'Reiniciar';

  @override
  String get tutorialResetDescription =>
      'Borra la tabla y comienza una nueva sesión.';

  @override
  String get tutorialShareTitle => 'Compartir';

  @override
  String get tutorialShareDescription =>
      'Una vez calculado, comparte una captura de los resultados con tu grupo.';

  @override
  String get tutorialDeleteTitle => 'Eliminar jugador';

  @override
  String get tutorialDeleteDescription =>
      'Desliza una fila de jugador hacia la izquierda para eliminarlo.';

  @override
  String get tutorialCalculateTitle => 'Calcular';

  @override
  String get tutorialCalculateDescription =>
      'Introduce las entradas y salidas, luego toca aquí para calcular quién le paga a quién.';

  @override
  String get tutorialNext => 'Siguiente';

  @override
  String get tutorialSkip => 'Omitir';

  @override
  String get tutorialGotIt => 'Entendido';
}
