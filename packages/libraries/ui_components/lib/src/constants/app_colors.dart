part of 'app_constants.dart';

/// Centralised colour tokens for the design system.
///
/// Grouped into semantic ramps (primary / secondary), a neutral grey scale and
/// a few named surface colours. Prefer referencing these tokens over inlining
/// raw [Color] literals in widgets so the palette stays consistent and can be
/// re-themed from a single place.
///
/// This class only holds constants and is not meant to be instantiated.
abstract final class AppColors {
  // --- Primary ramp -------------------------------------------------------
  static const Color primary = Color(0xFF3D5AFE);
  static const Color primary200 = Color(0xFFC5CEFF);
  static const Color primary400 = Color(0xFF6E85FE);
  static const Color primary600 = Color(0xFF3048CB);
  static const Color primary800 = Color(0xFF1E2E85);

  // --- Secondary ramp -----------------------------------------------------
  static const Color secondary = Color(0xFF00BFA5);
  static const Color secondary200 = Color(0xFF9EEDE2);
  static const Color secondary400 = Color(0xFF4CD6C1);
  static const Color secondary600 = Color(0xFF00997F);
  static const Color secondary800 = Color(0xFF006B59);

  // --- Neutral scale ------------------------------------------------------
  static const Color black = Color(0xFF303030);
  static const Color gray200 = Color(0xFFE6E6E6);
  static const Color gray400 = Color(0xFFD5D5D5);
  static const Color gray600 = Color(0xFFB1B1B1);
  static const Color gray800 = Color(0xFF707070);
  static const Color white = Color(0xFFFFFFFF);

  static const Color transparent = Colors.transparent;

  // --- Surfaces -----------------------------------------------------------
  static const Color bgWhite = Color(0xFFFFFFFF);
  static const Color bgGray = Color(0xFFF6F7FC);

  // --- Light theme surfaces ----------------------------------------------
  static const Color lightPrimary = Color(0xFFFFFFFF);
  static const Color lightSecondary = Color(0xFFEFF0F6);
  static const Color lightBackground = Color(0xFFF6F7FC);

  // --- Dark theme surfaces -----------------------------------------------
  static const Color darkPrimary = Color(0xFF1C243F);
  static const Color darkSecondary = Color(0xFF262F4B);
  static const Color darkBackground = Color(0xFF0F172F);

  /// Ordered stops for the app's main background gradient.
  static const List<Color> mainGradient = [primary, primary400, secondary400];
}
