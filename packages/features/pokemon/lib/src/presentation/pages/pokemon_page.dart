import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ui_components/ui_components.dart';

import '../providers/pokemon_list_provider.dart';
import '../utils/failure_message.dart';
import '../widgets/pokemon_card.dart';

/// Paginated Pokemon list. Consumes the domain use case via Riverpod (§7) and
/// never touches the API directly (§5).
class PokemonPage extends ConsumerStatefulWidget {
  const PokemonPage({super.key});

  @override
  ConsumerState<PokemonPage> createState() => _PokemonPageState();
}

class _PokemonPageState extends ConsumerState<PokemonPage> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 300) {
      ref.read(pokemonListProvider.notifier).loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(pokemonListProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Pokédex')),
      body: state.when(
        loading: () => const AppLoadingView(message: 'Loading Pokémon...'),
        error: (error, _) => AppErrorView(
          message: failureToMessage(error),
          onRetry: () => ref.read(pokemonListProvider.notifier).refresh(),
        ),
        data: (data) {
          return RefreshIndicator(
            onRefresh: () => ref.read(pokemonListProvider.notifier).refresh(),
            child: ListView.builder(
              controller: _scrollController,
              itemCount: data.items.length + (data.hasMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index >= data.items.length) {
                  return const Padding(
                    padding: EdgeInsets.all(16),
                    child: Center(child: CircularProgressIndicator.adaptive()),
                  );
                }
                final pokemon = data.items[index];
                return PokemonCard(
                  pokemon: pokemon,
                  onTap: () => context.push('/pokemon/${pokemon.name}'),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
