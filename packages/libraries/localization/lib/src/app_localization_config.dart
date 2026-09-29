import 'package:material_ui/material_ui.dart';

/// Shared localization configuration reused by the app shell and features.
///
/// As of Flutter 3.47, the Material/Cupertino localization delegates ship
/// inside `package:material_ui` (they were unbundled from
/// `flutter_localizations`). Feature packages depend on this instead of wiring
/// up delegates individually, keeping locale support consistent across the
/// whole application.
class AppLocalizationConfig {
  const AppLocalizationConfig._();

  /// Locales the application officially supports.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
  ];

  /// The default locale used when the device locale is unsupported.
  static const Locale fallbackLocale = Locale('en');

  /// Localizations delegates required by [WidgetsApp]/[MaterialApp].
  ///
  /// [GlobalMaterialLocalizations.delegates] bundles the Material, Cupertino,
  /// and Widgets delegates in one list, so no separate `flutter_localizations`
  /// wiring is needed.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      GlobalMaterialLocalizations.delegates;

  /// Resolves a device [locale] to a supported one, falling back to
  /// [fallbackLocale] when there is no match.
  static Locale resolveLocale(Locale? locale) {
    if (locale == null) {
      return fallbackLocale;
    }
    for (final supported in supportedLocales) {
      if (supported.languageCode == locale.languageCode) {
        return supported;
      }
    }
    return fallbackLocale;
  }
}
