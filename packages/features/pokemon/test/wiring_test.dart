import 'package:feature_pokemon/src/data/datasources/pokemon_local_data_source.dart';
import 'package:feature_pokemon/src/data/datasources/pokemon_remote_data_source.dart';
import 'package:feature_pokemon/src/data/models/pokemon_model.dart';
import 'package:feature_pokemon/src/domain/repositories/pokemon_repository.dart';
import 'package:feature_pokemon/src/domain/usecases/get_pokemon.dart';
import 'package:feature_pokemon/src/domain/usecases/get_pokemon_list.dart';
import 'package:feature_pokemon/src/presentation/providers/pokemon_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network/network.dart';
import 'package:storage/storage.dart';

void main() {
  group('default provider wiring', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() => container.dispose());

    test('constructs the whole default dependency graph', () {
      expect(container.read(apiClientProvider), isA<ApiClient>());
      expect(container.read(keyValueStoreProvider), isA<KeyValueStore>());
      expect(
        container.read(pokemonRemoteDataSourceProvider),
        isA<PokemonRemoteDataSource>(),
      );
      expect(
        container.read(pokemonLocalDataSourceProvider),
        isA<PokemonLocalDataSource>(),
      );
      expect(container.read(pokemonRepositoryProvider), isA<PokemonRepository>());
      expect(container.read(getPokemonListProvider), isA<GetPokemonList>());
      expect(container.read(getPokemonProvider), isA<GetPokemon>());
    });
  });

  group('PokemonModel.fromListJson id parsing edge cases', () {
    test('parses id from a trailing-slash resource url', () {
      final model = PokemonModel.fromListJson({
        'name': 'pikachu',
        'url': 'https://pokeapi.co/api/v2/pokemon/25/',
      });
      expect(model.id, 25);
    });

    test('falls back to 0 when url has no numeric segment', () {
      final model = PokemonModel.fromListJson({
        'name': 'mystery',
        'url': 'https://pokeapi.co/api/v2/pokemon/',
      });
      expect(model.id, 0);
    });

    test('falls back to 0 when last segment is non-numeric', () {
      final model = PokemonModel.fromListJson({
        'name': 'mystery',
        'url': 'https://example.com/foo/bar',
      });
      expect(model.id, 0);
    });

    test('toJson / fromJson / fromCacheJson round-trip', () {
      const model = PokemonModel(id: 7, name: 'squirtle');
      final json = model.toJson();
      expect(PokemonModel.fromJson(json).name, 'squirtle');
      expect(PokemonModel.fromCacheJson(json).id, 7);
      expect(model.toEntity().id, 7);
    });
  });
}
