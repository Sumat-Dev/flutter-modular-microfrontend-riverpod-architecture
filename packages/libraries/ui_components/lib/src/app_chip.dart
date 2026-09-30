import 'package:material_ui/material_ui.dart';

/// A compact label [Chip], the shared replacement for the per-feature chip
/// widgets (`PokemonTypeChip`, `ItemAttributeChip`, `BerryFlavorChip`).
class AppChip extends StatelessWidget {
  const AppChip({required this.label, super.key});

  /// Text shown inside the chip.
  final String label;

  @override
  Widget build(BuildContext context) {
    return Chip(label: Text(label), visualDensity: VisualDensity.compact);
  }
}
