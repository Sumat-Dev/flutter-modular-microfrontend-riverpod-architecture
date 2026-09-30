import 'package:material_ui/material_ui.dart';

/// A tappable [Card] wrapping a [ListTile], used for rows in resource lists.
///
/// Replaces the near-identical `PokemonCard` / `BerryCard` / `ItemCard`
/// widgets. Callers provide a [title], optional [subtitle] and a [leading]
/// widget (e.g. a network image or avatar). A trailing chevron is shown by
/// default to signal navigation.
class AppEntityCard extends StatelessWidget {
  const AppEntityCard({
    required this.title,
    required this.onTap,
    super.key,
    this.subtitle,
    this.leading,
    this.trailing = const Icon(Icons.chevron_right),
  });

  /// Primary line of text.
  final String title;

  /// Optional secondary line of text.
  final String? subtitle;

  /// Optional leading widget (image, icon, avatar).
  final Widget? leading;

  /// Trailing widget; defaults to a chevron.
  final Widget? trailing;

  /// Tap handler.
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: ListTile(
        leading: leading,
        title: Text(title),
        subtitle: subtitle == null ? null : Text(subtitle!),
        trailing: trailing,
        onTap: onTap,
      ),
    );
  }
}

/// Convenience leading widget: a fixed-size network image that falls back to
/// [fallbackIcon] when the image fails to load. Feature-agnostic replacement
/// for the repeated `Image.network(..., errorBuilder: ...)` pattern.
class AppNetworkThumbnail extends StatelessWidget {
  const AppNetworkThumbnail({
    required this.imageUrl,
    required this.fallbackIcon,
    super.key,
    this.size = 48,
  });

  /// Image URL to load.
  final String imageUrl;

  /// Icon shown when the image cannot be loaded.
  final IconData fallbackIcon;

  /// Width and height of the thumbnail.
  final double size;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageUrl,
      width: size,
      height: size,
      errorBuilder: (_, _, _) => Icon(fallbackIcon),
    );
  }
}
