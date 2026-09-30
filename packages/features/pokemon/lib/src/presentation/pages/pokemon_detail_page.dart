import 'package:feature_pokemon/src/presentation/providers/pokemon_detail_provider.dart';
import 'package:feature_pokemon/src/presentation/utils/failure_message.dart';
import 'package:feature_pokemon/src/presentation/widgets/pokemon_encounters_view.dart';
import 'package:feature_pokemon/src/presentation/widgets/pokemon_stat_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:ui_components/ui_components.dart';

class PokemonDetailPage extends ConsumerWidget {
  const PokemonDetailPage({required this.name, super.key});

  final String name;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detail = ref.watch(pokemonDetailProvider(name));
    return Scaffold(
      appBar: AppBar(title: Text(name)),
      body: AppAsyncView(
        isLoading: detail.isLoading,
        hasError: detail.hasError,
        data: detail.value,
        errorMessage: detail.hasError ? failureToMessage(detail.error!) : null,
        onRetry: () => ref.invalidate(pokemonDetailProvider(name)),
        dataBuilder: (context, pokemon) => SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.network(
                  pokemon.imageUrl,
                  height: 180,
                  errorBuilder: (_, _, _) =>
                      const Icon(Icons.catching_pokemon, size: 120),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                '#${pokemon.id}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              AppChipWrap(labels: pokemon.types),
              const SizedBox(height: 16),
              Text('Height: ${pokemon.height}   Weight: ${pokemon.weight}'),
              const AppSectionHeader(title: 'Base stats'),
              for (final stat in pokemon.stats) PokemonStatView(stat: stat),
              const SizedBox(height: 16),
              PokemonEncountersView(name: name),
            ],
          ),
        ),
      ),
    );
  }
}
