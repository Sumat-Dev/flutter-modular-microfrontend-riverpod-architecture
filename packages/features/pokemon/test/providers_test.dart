import 'package:core/core.dart';
import 'package:feature_pokemon/pokemon_module.dart';
import 'package:feature_pokemon/src/domain/repositories/pokemon_repository.dart';
import 'package:feature_pokemon/src/presentation/providers/pokemon_detail_provider.dart';
import 'package:feature_pokemon/src/presentation/providers/pokemon_list_provider.dart';
import 'package:feature_pokemon/src/presentation/providers/pokemon_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

/// A repository fake that returns pages driven by [offset] so we can exercise
/// pagination (loadMore) and refresh flows deterministically.
class _PagingRepo implements PokemonRepository {
  int listCalls = 0;

  @override
  ResultFuture<PaginatedResult<Pokemon>> getPokemonList(
    PageRequest page,
  ) async {
    listCalls++;
    // First page (offset 0) has more; second page (offset 20) is the last.
    final isFirst = page.offset == 0;
    return Right(
      PaginatedResult<Pokemon>(
        count: 2,
        next: isFirst ? 'next' : null,
        items: [
          Pokemon(
            id: page.offset + 1,
            name: isFirst ? 'bulbasaur' : 'ivysaur',
          ),
        ],
      ),
    );
  }

  @override
  ResultFuture<PokemonDetail> getPokemon(String name) async {
    if (name == 'error') {
      return const Left(ServerFailure(message: 'boom'));
    }
    return Right(
      PokemonDetail(
        id: 25,
        name: name,
        height: 4,
        weight: 60,
        types: const ['electric'],
        stats: const [PokemonStat(name: 'hp', baseValue: 35)],
      ),
    );
  }
}

class _FailingLoadMoreRepo implements PokemonRepository {
  int calls = 0;

  @override
  ResultFuture<PaginatedResult<Pokemon>> getPokemonList(
    PageRequest page,
  ) async {
    calls++;
    if (calls == 1) {
      return const Right(
        PaginatedResult<Pokemon>(
          count: 2,
          next: 'next',
          items: [Pokemon(id: 1, name: 'bulbasaur')],
        ),
      );
    }
    return const Left(NetworkFailure(message: 'offline'));
  }

  @override
  ResultFuture<PokemonDetail> getPokemon(String name) async =>
      const Left(UnexpectedFailure(message: 'unused'));
}

ProviderContainer _container(PokemonRepository repo) {
  final container = ProviderContainer(
    overrides: [pokemonRepositoryProvider.overrideWithValue(repo)],
  );
  return container;
}

void main() {
  group('pokemonDetailProvider', () {
    test('emits detail on success', () async {
      final container = _container(_PagingRepo());
      addTearDown(container.dispose);
      container.listen(pokemonDetailProvider('pikachu'), (_, _) {});

      final detail = await container.read(
        pokemonDetailProvider('pikachu').future,
      );
      expect(detail.name, 'pikachu');
      expect(detail.types, ['electric']);
    });

    test('surfaces domain Failure as AsyncError', () async {
      final container = _container(_PagingRepo());
      addTearDown(container.dispose);

      final sub = container.listen(pokemonDetailProvider('error'), (_, _) {});
      await container.pump();

      final state = sub.read();
      expect(state.hasError, isTrue);
      expect(state.error, isA<ServerFailure>());
    });
  });

  group('PokemonList loadMore', () {
    test('appends the next page and updates paging flags', () async {
      final repo = _PagingRepo();
      final container = _container(repo);
      addTearDown(container.dispose);
      container.listen(pokemonListProvider, (_, _) {});

      final first = await container.read(pokemonListProvider.future);
      expect(first.items.single.name, 'bulbasaur');
      expect(first.hasMore, isTrue);
      expect(first.nextOffset, 20);

      await container.read(pokemonListProvider.notifier).loadMore();

      final after = container.read(pokemonListProvider).value!;
      expect(after.items.map((e) => e.name), ['bulbasaur', 'ivysaur']);
      expect(after.hasMore, isFalse);
      expect(after.isLoadingMore, isFalse);
      expect(after.nextOffset, 40);
    });

    test('loadMore is a no-op when there is no more data', () async {
      final repo = _PagingRepo();
      final container = _container(repo);
      addTearDown(container.dispose);
      container.listen(pokemonListProvider, (_, _) {});

      await container.read(pokemonListProvider.future);
      await container.read(pokemonListProvider.notifier).loadMore();
      final callsAfterLast = repo.listCalls;

      // hasMore is now false; another loadMore must not hit the repository.
      await container.read(pokemonListProvider.notifier).loadMore();
      expect(repo.listCalls, callsAfterLast);
    });

    test('loadMore failure surfaces as AsyncError', () async {
      final container = _container(_FailingLoadMoreRepo());
      addTearDown(container.dispose);
      container.listen(pokemonListProvider, (_, _) {});

      await container.read(pokemonListProvider.future);
      await container.read(pokemonListProvider.notifier).loadMore();

      final state = container.read(pokemonListProvider);
      expect(state.hasError, isTrue);
      expect(state.error, isA<NetworkFailure>());
    });
  });

  group('PokemonList refresh', () {
    test('rebuilds from the first page', () async {
      final repo = _PagingRepo();
      final container = _container(repo);
      addTearDown(container.dispose);
      container.listen(pokemonListProvider, (_, _) {});

      await container.read(pokemonListProvider.future);
      await container.read(pokemonListProvider.notifier).loadMore();
      expect(container.read(pokemonListProvider).value!.items.length, 2);

      await container.read(pokemonListProvider.notifier).refresh();

      final refreshed = container.read(pokemonListProvider).value!;
      expect(refreshed.items.single.name, 'bulbasaur');
      expect(refreshed.nextOffset, 20);
    });
  });

  group('PokemonListState.copyWith', () {
    test('overrides only provided fields', () {
      const state = PokemonListState();
      final copy = state.copyWith(isLoadingMore: true, hasMore: false);
      expect(copy.isLoadingMore, isTrue);
      expect(copy.hasMore, isFalse);
      expect(copy.items, isEmpty);
      expect(copy.nextOffset, 0);
    });
  });
}
