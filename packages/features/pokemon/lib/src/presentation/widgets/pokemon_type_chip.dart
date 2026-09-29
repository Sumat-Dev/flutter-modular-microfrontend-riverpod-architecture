import 'package:material_ui/material_ui.dart';

/// Small chip displaying a Pokemon type label.
class PokemonTypeChip extends StatelessWidget {
  const PokemonTypeChip({required this.type, super.key});

  final String type;

  @override
  Widget build(BuildContext context) {
    return Chip(label: Text(type), visualDensity: VisualDensity.compact);
  }
}
