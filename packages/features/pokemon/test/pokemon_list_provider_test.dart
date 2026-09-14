import 'package:core/core.dart';
import 'package:feature_pokemon/feature_pokemon.dart';
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

    await expectLater(
      container.read(pokemonListProvider.future),
      throwsA(isA<NetworkFailure>()),
    );
  });
}
