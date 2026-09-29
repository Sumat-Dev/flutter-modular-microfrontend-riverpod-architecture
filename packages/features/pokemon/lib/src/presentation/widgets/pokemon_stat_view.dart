import 'package:feature_pokemon/src/domain/entities/pokemon_detail.dart';
import 'package:material_ui/material_ui.dart';

/// Displays a single base stat as a labelled progress bar.
class PokemonStatView extends StatelessWidget {
  const PokemonStatView({required this.stat, super.key});

  final PokemonStat stat;

  @override
  Widget build(BuildContext context) {
    // PokeAPI base stats are 0..255 in practice.
    final fraction = (stat.baseValue / 255).clamp(0.0, 1.0);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(width: 120, child: Text(stat.name)),
          Expanded(child: LinearProgressIndicator(value: fraction)),
          const SizedBox(width: 8),
          Text('${stat.baseValue}'),
        ],
      ),
    );
  }
}
