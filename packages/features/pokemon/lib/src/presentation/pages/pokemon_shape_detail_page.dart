import 'package:feature_pokemon/src/presentation/providers/pokemon_shape_detail_provider.dart';
import 'package:feature_pokemon/src/presentation/utils/failure_message.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:ui_components/ui_components.dart';

class PokemonShapeDetailPage extends ConsumerWidget {
  const PokemonShapeDetailPage({required this.idOrName, super.key});

  final String idOrName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detail = ref.watch(pokemonShapeDetailProvider(idOrName));
    return Scaffold(
      appBar: AppBar(title: Text(idOrName)),
      body: detail.when(
        loading: () => const AppLoadingView(),
        error: (error, _) => AppErrorView(
          message: failureToMessage(error),
          onRetry: () => ref.invalidate(pokemonShapeDetailProvider(idOrName)),
        ),
        data: (shape) {
          final theme = Theme.of(context);
          final species = shape.pokemonSpecies.take(30).toList();
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  shape.displayName ?? shape.name,
                  style: theme.textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text('#${shape.id}'),
                if (species.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  Text('Species', style: theme.textTheme.titleMedium),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    children: [
                      for (final s in species) Chip(label: Text(s.name)),
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
