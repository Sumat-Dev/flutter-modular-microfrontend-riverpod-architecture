import 'package:feature_pokemon/src/presentation/providers/pokemon_habitat_detail_provider.dart';
import 'package:feature_pokemon/src/presentation/utils/failure_message.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:ui_components/ui_components.dart';

class PokemonHabitatDetailPage extends ConsumerWidget {
  const PokemonHabitatDetailPage({required this.idOrName, super.key});

  final String idOrName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detail = ref.watch(pokemonHabitatDetailProvider(idOrName));
    return Scaffold(
      appBar: AppBar(title: Text(idOrName)),
      body: AppAsyncView(
        isLoading: detail.isLoading,
        hasError: detail.hasError,
        data: detail.value,
        errorMessage: detail.hasError ? failureToMessage(detail.error!) : null,
        onRetry: () => ref.invalidate(pokemonHabitatDetailProvider(idOrName)),
        dataBuilder: (context, habitat) {
          final theme = Theme.of(context);
          final species = habitat.pokemonSpecies.take(30).toList();
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  habitat.displayName ?? habitat.name,
                  style: theme.textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text('#${habitat.id}'),
                if (species.isNotEmpty) ...[
                  const AppSectionHeader(title: 'Species'),
                  AppChipWrap(
                    labels: [for (final s in species) s.name],
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
