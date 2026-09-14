import 'package:flutter/material.dart' show MaterialApp;
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

/// Shared localization configuration reused by the app shell and features.
///
/// Feature packages depend on this instead of wiring up
/// `flutter_localizations` individually, keeping locale support consistent
/// across the whole application.
class AppLocalizationConfig {
  const AppLocalizationConfig._();

  /// Locales the application officially supports.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
  ];

  /// The default locale used when the device locale is unsupported.
  static const Locale fallbackLocale = Locale('en');

  /// Localizations delegates required by [WidgetsApp]/[MaterialApp].
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ];

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
