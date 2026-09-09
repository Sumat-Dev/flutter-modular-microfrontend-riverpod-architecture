import 'package:flutter/material.dart';

import '../../domain/entities/pokemon.dart';

/// List tile / card for a single Pokemon in the list.
class PokemonCard extends StatelessWidget {
  const PokemonCard({required this.pokemon, required this.onTap, super.key});

  final Pokemon pokemon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: ListTile(
        leading: Image.network(
          pokemon.imageUrl,
          width: 48,
          height: 48,
          errorBuilder: (_, _, _) => const Icon(Icons.catching_pokemon),
        ),
        title: Text(pokemon.name),
        subtitle: Text('#${pokemon.id}'),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
