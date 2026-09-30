import 'package:material_ui/material_ui.dart';
import 'package:ui_components/ui_components.dart';

/// Centralised light/dark theming for the app shell.
///
/// Mirrors the reference `AppTheme` (system mode + light/dark [ThemeData]) and
/// sources the shared [Font] family and [AppColors] tokens from the
/// `ui_components` constants library.
class AppTheme {
  AppTheme._();

  /// Default theme mode the app launches with.
  static ThemeMode system = ThemeMode.light;

  static ThemeData get lightTheme => ThemeData(
    fontFamily: Font.poppins,
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      primary: AppColors.lightPrimary,
      secondary: AppColors.lightSecondary,
    ),
    scaffoldBackgroundColor: AppColors.lightBackground,
  );

  static ThemeData get darkTheme => ThemeData(
    fontFamily: Font.poppins,
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.darkPrimary,
      secondary: AppColors.darkSecondary,
    ),
    scaffoldBackgroundColor: AppColors.darkBackground,
  );
}
