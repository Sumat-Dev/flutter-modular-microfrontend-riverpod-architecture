import 'package:feature_pokemon/src/domain/entities/pokemon.dart';
import 'package:material_ui/material_ui.dart';
import 'package:ui_components/ui_components.dart';

class PokemonCard extends StatelessWidget {
  const PokemonCard({required this.pokemon, required this.onTap, super.key});

  final Pokemon pokemon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AppEntityCard(
      leading: AppNetworkThumbnail(
        imageUrl: pokemon.imageUrl,
        fallbackIcon: Icons.catching_pokemon,
      ),
      title: pokemon.name,
      subtitle: '#${pokemon.id}',
      onTap: onTap,
    );
  }
}
