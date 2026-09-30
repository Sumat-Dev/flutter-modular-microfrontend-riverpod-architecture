part of 'app_constants.dart';

/// Font family names bundled with the design system.
abstract final class Font {
  static const String poppins = 'Poppins';
}

/// Paths to Lottie/animation assets.
abstract final class ImageAnimationPath {
  static const String _folder = 'assets/images/animation';

  static const String mock = '$_folder/mock-animation.json';
}

/// Paths to raster image assets (PNG/JPG).
abstract final class ImageRasterPath {
  static const String _folder = 'assets/images/raster';

  static const String mock = '$_folder/mock-image.png';
}

/// Paths to vector image assets (SVG).
abstract final class ImageVectorPath {
  static const String _folder = 'assets/images/vector';

  static const String mock = '$_folder/mock-image.svg';
}
