import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:library_core/library_core.dart';

import '../../domain/entities/pokemon.dart';
import 'pokemon_providers.dart';

/// Immutable UI state for the paginated Pokemon list.
class PokemonListState {
  const PokemonListState({
    this.items = const [],
    this.isLoadingMore = false,
    this.hasMore = true,
    this.nextOffset = 0,
  });

  final List<Pokemon> items;
  final bool isLoadingMore;
  final bool hasMore;
  final int nextOffset;

  PokemonListState copyWith({
    List<Pokemon>? items,
    bool? isLoadingMore,
    bool? hasMore,
    int? nextOffset,
  }) => PokemonListState(
    items: items ?? this.items,
    isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    hasMore: hasMore ?? this.hasMore,
    nextOffset: nextOffset ?? this.nextOffset,
  );
}

/// Loads the first page and appends subsequent pages on demand.
class PokemonListNotifier extends AsyncNotifier<PokemonListState> {
  static const _limit = 20;

  @override
  Future<PokemonListState> build() => _fetch(const PokemonListState());

  Future<PokemonListState> _fetch(PokemonListState current) async {
    final useCase = ref.read(getPokemonListProvider);
    final result = await useCase(
      PageRequest(offset: current.nextOffset, limit: _limit),
    );
    return result.when(
      success: (page) => current.copyWith(
        items: [...current.items, ...page.items],
        hasMore: page.hasMore,
        nextOffset: current.nextOffset + _limit,
        isLoadingMore: false,
      ),
      failure: (f) => throw f,
    );
  }

  /// Loads the next page, keeping already-loaded items visible.
  Future<void> loadMore() async {
    final current = state.valueOrNull;
    if (current == null || current.isLoadingMore || !current.hasMore) {
      return;
    }
    state = AsyncData(current.copyWith(isLoadingMore: true));
    try {
      state = AsyncData(await _fetch(current));
    } on Failure catch (f, st) {
      state = AsyncError(f, st);
    }
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _fetch(const PokemonListState()));
  }
}

final pokemonListProvider =
    AsyncNotifierProvider<PokemonListNotifier, PokemonListState>(
      PokemonListNotifier.new,
    );
