import 'package:material_ui/material_ui.dart';
import 'package:ui_components/src/app_chip.dart';
import 'package:ui_components/src/constants/app_constants.dart';

/// A titled section header (`titleMedium`) preceded by vertical spacing.
///
/// Replaces the repeated `SizedBox(height: 16) + Text(title, titleMedium) +
/// SizedBox(height: 8)` pattern seen across detail pages.
class AppSectionHeader extends StatelessWidget {
  const AppSectionHeader({
    required this.title,
    super.key,
    this.topSpacing = kSpacing,
    this.bottomSpacing = kSpacing / 2,
  });

  /// The section title.
  final String title;

  /// Space above the title.
  final double topSpacing;

  /// Space below the title.
  final double bottomSpacing;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: topSpacing),
        Text(title, style: Theme.of(context).textTheme.titleMedium),
        SizedBox(height: bottomSpacing),
      ],
    );
  }
}

/// A [Wrap] of [AppChip]s built from a list of labels. Renders nothing when
/// [labels] is empty. Consolidates the `Wrap(spacing, runSpacing, children:
/// [for (...) Chip(...)])` pattern repeated across detail pages.
class AppChipWrap extends StatelessWidget {
  const AppChipWrap({
    required this.labels,
    super.key,
    this.spacing = 8,
    this.runSpacing = 4,
  });

  /// Chip labels.
  final List<String> labels;

  /// Horizontal spacing between chips.
  final double spacing;

  /// Vertical spacing between chip runs.
  final double runSpacing;

  @override
  Widget build(BuildContext context) {
    if (labels.isEmpty) return const SizedBox.shrink();
    return Wrap(
      spacing: spacing,
      runSpacing: runSpacing,
      children: [for (final label in labels) AppChip(label: label)],
    );
  }
}
