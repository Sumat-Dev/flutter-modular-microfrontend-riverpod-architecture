import 'package:flutter/material.dart';
import 'package:ui_components/ui_components.dart';

/// Centralised light/dark theming for the app shell.
///
/// Mirrors the reference `AppTheme` (system mode + light/dark [ThemeData]) and
/// sources the shared [Font] family from the `ui_components` constants library.
class AppTheme {
  AppTheme._();

  /// Default theme mode the app launches with.
  static ThemeMode system = ThemeMode.light;

  static ThemeData get lightTheme => ThemeData(
    fontFamily: Font.poppins,
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      primary: Color(0xFFFFFFFF),
      secondary: Color(0xFFEFF0F6),
    ),
    scaffoldBackgroundColor: const Color(0xFFF6F7FC),
  );

  static ThemeData get darkTheme => ThemeData(
    fontFamily: Font.poppins,
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF1C243F),
      secondary: Color(0xFF262F4B),
    ),
    scaffoldBackgroundColor: const Color(0xFF0F172F),
  );
}
