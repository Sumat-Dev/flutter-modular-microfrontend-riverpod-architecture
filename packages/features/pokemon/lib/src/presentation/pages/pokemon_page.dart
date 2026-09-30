import 'package:feature_pokemon/src/presentation/providers/pokemon_list_provider.dart';
import 'package:feature_pokemon/src/presentation/utils/failure_message.dart';
import 'package:feature_pokemon/src/presentation/widgets/pokemon_card.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:ui_components/ui_components.dart';

class PokemonPage extends ConsumerWidget {
  const PokemonPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(pokemonListProvider);
    final notifier = ref.read(pokemonListProvider.notifier);
    return Scaffold(
      appBar: AppBar(title: const Text('Pokédex')),
      body: AppAsyncView<PokemonListState>(
        isLoading: state.isLoading,
        hasError: state.hasError,
        data: state.value,
        loadingMessage: 'Loading Pokémon...',
        errorMessage: state.hasError ? failureToMessage(state.error!) : null,
        onRetry: notifier.refresh,
        dataBuilder: (context, data) => AppPaginatedListView(
          items: data.items,
          hasMore: data.hasMore,
          onLoadMore: notifier.loadMore,
          onRefresh: notifier.refresh,
          itemBuilder: (context, pokemon, index) => PokemonCard(
            pokemon: pokemon,
            onTap: () => Modular.to.pushNamed('/pokemon/${pokemon.name}'),
          ),
        ),
      ),
    );
  }
}
