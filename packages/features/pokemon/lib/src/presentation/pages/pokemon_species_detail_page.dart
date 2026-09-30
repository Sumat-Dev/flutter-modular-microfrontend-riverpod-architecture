import 'package:feature_pokemon/src/presentation/providers/pokemon_species_detail_provider.dart';
import 'package:feature_pokemon/src/presentation/utils/failure_message.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:ui_components/ui_components.dart';

class PokemonSpeciesDetailPage extends ConsumerWidget {
  const PokemonSpeciesDetailPage({required this.idOrName, super.key});

  final String idOrName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detail = ref.watch(pokemonSpeciesDetailProvider(idOrName));
    return Scaffold(
      appBar: AppBar(title: Text(idOrName)),
      body: detail.when(
        loading: () => const AppLoadingView(),
        error: (error, _) => AppErrorView(
          message: failureToMessage(error),
          onRetry: () => ref.invalidate(pokemonSpeciesDetailProvider(idOrName)),
        ),
        data: (species) {
          final theme = Theme.of(context);
          final eggGroups = species.eggGroups;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  species.displayName ?? species.name,
                  style: theme.textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text('#${species.id}'),
                const SizedBox(height: 12),
                Text('Capture rate: ${species.captureRate}'),
                Text('Base happiness: ${species.baseHappiness}'),
                Text('Gender rate: ${species.genderRate}'),
                Text('Hatch counter: ${species.hatchCounter}'),
                Text('Baby: ${species.isBaby}'),
                Text('Legendary: ${species.isLegendary}'),
                Text('Mythical: ${species.isMythical}'),
                const SizedBox(height: 12),
                if (species.growthRate != null)
                  Text('Growth rate: ${species.growthRate!.name}'),
                if (species.color != null)
                  Text('Color: ${species.color!.name}'),
                if (species.shape != null)
                  Text('Shape: ${species.shape!.name}'),
                if (species.habitat != null)
                  Text('Habitat: ${species.habitat!.name}'),
                if (species.generation != null)
                  Text('Generation: ${species.generation!.name}'),
                if (species.evolvesFromSpecies != null)
                  Text(
                    'Evolves from: '
                    '${species.evolvesFromSpecies!.name}',
                  ),
                if (species.genera.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Text('Genera: ${species.genera.join(', ')}'),
                ],
                if (species.flavorText != null) ...[
                  const SizedBox(height: 12),
                  Text(species.flavorText!),
                ],
                if (eggGroups.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  Text('Egg groups', style: theme.textTheme.titleMedium),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    children: [
                      for (final g in eggGroups) Chip(label: Text(g.name)),
                    ],
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}
