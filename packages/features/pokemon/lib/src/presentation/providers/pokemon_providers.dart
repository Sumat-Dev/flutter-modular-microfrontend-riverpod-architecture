import 'package:feature_pokemon/src/data/datasources/pokemon_local_data_source.dart';
import 'package:feature_pokemon/src/data/datasources/pokemon_remote_data_source.dart';
import 'package:feature_pokemon/src/data/repositories/pokemon_repository_impl.dart';
import 'package:feature_pokemon/src/domain/repositories/pokemon_repository.dart';
import 'package:feature_pokemon/src/domain/usecases/get_pokemon.dart';
import 'package:feature_pokemon/src/domain/usecases/get_pokemon_list.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:network/network.dart';
import 'package:storage/storage.dart';

/// Dependency graph for the Pokemon feature (plan §7).
///
/// DioClient → RemoteDataSource → Repository → UseCases → (state notifiers).
/// These are overridable in tests and at composition time.

final apiClientProvider = Provider<ApiClient>((ref) => DioApiClient());

final keyValueStoreProvider = Provider<KeyValueStore>(
  (ref) => InMemoryKeyValueStore(),
);

final pokemonRemoteDataSourceProvider = Provider<PokemonRemoteDataSource>(
  (ref) => PokemonRemoteDataSourceImpl(ref.watch(apiClientProvider)),
);

final pokemonLocalDataSourceProvider = Provider<PokemonLocalDataSource>(
  (ref) => PokemonLocalDataSourceImpl(ref.watch(keyValueStoreProvider)),
);

final pokemonRepositoryProvider = Provider<PokemonRepository>(
  (ref) => PokemonRepositoryImpl(
    remote: ref.watch(pokemonRemoteDataSourceProvider),
    local: ref.watch(pokemonLocalDataSourceProvider),
  ),
);

final getPokemonListProvider = Provider<GetPokemonList>(
  (ref) => GetPokemonList(ref.watch(pokemonRepositoryProvider)),
);

final getPokemonProvider = Provider<GetPokemon>(
  (ref) => GetPokemon(ref.watch(pokemonRepositoryProvider)),
);
