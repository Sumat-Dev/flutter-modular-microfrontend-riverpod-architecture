import 'package:core/core.dart';
import 'package:feature_pokemon/pokemon_module.dart';
import 'package:feature_pokemon/src/domain/repositories/pokemon_repository.dart';
import 'package:feature_pokemon/src/presentation/providers/pokemon_list_provider.dart';
import 'package:feature_pokemon/src/presentation/providers/pokemon_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeRepo implements PokemonRepository {
  _FakeRepo({this.fail = false});
  final bool fail;

  @override
  ResultFuture<PaginatedResult<Pokemon>> getPokemonList(
    PageRequest page,
  ) async {
    if (fail) {
      return const Left(NetworkFailure(message: 'offline'));
    }
    return const Right(
      PaginatedResult<Pokemon>(
        count: 1,
        items: [Pokemon(id: 1, name: 'bulbasaur')],
      ),
    );
  }

  @override
  ResultFuture<PokemonDetail> getPokemon(String name) async =>
      const Left(UnexpectedFailure(message: 'unused'));
}

void main() {
  test('pokemonListProvider emits data on success', () async {
    final container = ProviderContainer(
      overrides: [pokemonRepositoryProvider.overrideWithValue(_FakeRepo())],
    );
    addTearDown(container.dispose);
    // Keep the provider mounted while its async build runs. Under Riverpod 3.x
    // an unlistened provider read via `.future` may be disposed mid-build.
    container.listen(pokemonListProvider, (_, _) {});

    final state = await container.read(pokemonListProvider.future);
    expect(state.items.single.name, 'bulbasaur');
    expect(state.hasMore, isFalse);
  });

  test('pokemonListProvider surfaces failure as AsyncError', () async {
    final container = ProviderContainer(
      overrides: [
        pokemonRepositoryProvider.overrideWithValue(_FakeRepo(fail: true)),
      ],
    );
    addTearDown(container.dispose);

    // In Riverpod 3.x, `provider.future` skips intermediate error states, so we
    // assert on the AsyncValue itself: the build's thrown domain Failure must
    // surface as an AsyncError carrying the NetworkFailure.
    final sub = container.listen(pokemonListProvider, (_, _) {});
    await container.pump();

    final state = sub.read();
    expect(state.hasError, isTrue);
    expect(state.error, isA<NetworkFailure>());
  });
}
