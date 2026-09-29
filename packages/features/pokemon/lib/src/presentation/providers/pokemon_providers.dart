import 'package:feature_pokemon/src/data/datasources/pokemon_local_data_source.dart';
import 'package:feature_pokemon/src/data/datasources/pokemon_remote_data_source.dart';
import 'package:feature_pokemon/src/data/repositories/pokemon_repository_impl.dart';
import 'package:feature_pokemon/src/domain/repositories/pokemon_repository.dart';
import 'package:feature_pokemon/src/domain/usecases/get_pokemon.dart';
import 'package:feature_pokemon/src/domain/usecases/get_pokemon_list.dart';
import 'package:network/network.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:storage/storage.dart';

part 'pokemon_providers.g.dart';

@Riverpod(keepAlive: true)
ApiClient apiClient(Ref ref) => DioApiClient();

@Riverpod(keepAlive: true)
KeyValueStore keyValueStore(Ref ref) => InMemoryKeyValueStore();

@Riverpod(keepAlive: true)
PokemonRemoteDataSource pokemonRemoteDataSource(Ref ref) =>
    PokemonRemoteDataSourceImpl(ref.watch(apiClientProvider));

@Riverpod(keepAlive: true)
PokemonLocalDataSource pokemonLocalDataSource(Ref ref) =>
    PokemonLocalDataSourceImpl(ref.watch(keyValueStoreProvider));

@Riverpod(keepAlive: true)
PokemonRepository pokemonRepository(Ref ref) => PokemonRepositoryImpl(
  remote: ref.watch(pokemonRemoteDataSourceProvider),
  local: ref.watch(pokemonLocalDataSourceProvider),
);

@Riverpod(keepAlive: true)
GetPokemonList getPokemonList(Ref ref) =>
    GetPokemonList(ref.watch(pokemonRepositoryProvider));

@Riverpod(keepAlive: true)
GetPokemon getPokemon(Ref ref) =>
    GetPokemon(ref.watch(pokemonRepositoryProvider));
