import 'package:feature_pokemon/src/presentation/providers/pokemon_detail_provider.dart';
import 'package:feature_pokemon/src/presentation/utils/failure_message.dart';
import 'package:feature_pokemon/src/presentation/widgets/pokemon_stat_view.dart';
import 'package:feature_pokemon/src/presentation/widgets/pokemon_type_chip.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:ui_components/ui_components.dart';

/// Detail page for a single Pokemon, resolved by [name].
class PokemonDetailPage extends ConsumerWidget {
  const PokemonDetailPage({required this.name, super.key});

  final String name;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detail = ref.watch(pokemonDetailProvider(name));
    return Scaffold(
      appBar: AppBar(title: Text(name)),
      body: detail.when(
        loading: () => const AppLoadingView(),
        error: (error, _) => AppErrorView(
          message: failureToMessage(error),
          onRetry: () => ref.invalidate(pokemonDetailProvider(name)),
        ),
        data: (pokemon) => SingleChildScrollView(
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
              Wrap(
                spacing: 8,
                children: [
                  for (final type in pokemon.types) PokemonTypeChip(type: type),
                ],
              ),
              const SizedBox(height: 16),
              Text('Height: ${pokemon.height}   Weight: ${pokemon.weight}'),
              const SizedBox(height: 16),
              Text(
                'Base stats',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              for (final stat in pokemon.stats) PokemonStatView(stat: stat),
            ],
          ),
        ),
      ),
    );
  }
}
