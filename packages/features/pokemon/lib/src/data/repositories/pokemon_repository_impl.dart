import 'package:core/core.dart';
import 'package:feature_pokemon/src/data/datasources/pokemon_local_data_source.dart';
import 'package:feature_pokemon/src/data/datasources/pokemon_remote_data_source.dart';
import 'package:feature_pokemon/src/domain/entities/pokemon.dart';
import 'package:feature_pokemon/src/domain/entities/pokemon_detail.dart';
import 'package:feature_pokemon/src/domain/repositories/pokemon_repository.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  const PokemonRepositoryImpl({
    required PokemonRemoteDataSource remote,
    required PokemonLocalDataSource local,
  }) : _remote = remote,
       _local = local;

  final PokemonRemoteDataSource _remote;
  final PokemonLocalDataSource _local;

  @override
  ResultFuture<PaginatedResult<Pokemon>> getPokemonList(
    PageRequest page,
  ) async {
    try {
      final res = await _remote.fetchPokemonList(
        offset: page.offset,
        limit: page.limit,
      );
      final result = PaginatedResult<Pokemon>(
        count: res.count,
        next: res.next,
        previous: res.previous,
        items: res.items.map((m) => m.toEntity()).toList(),
      );
      return Right(result);
    } on AppException catch (e) {
      return Left(_mapException(e));
    } on Object catch (e) {
      return Left(UnexpectedFailure(message: '$e'));
    }
  }

  @override
  ResultFuture<PokemonDetail> getPokemon(String name) async {
    // 1. Try cache. A cache failure must not break the feature (§11).
    try {
      final cached = await _local.readPokemon(name);
      if (cached != null) {
        return Right(cached.toEntity());
      }
    } on CacheException {
      // Ignore and fall through to remote.
    }

    // 2. Cache miss → remote → save → entity.
    try {
      final model = await _remote.fetchPokemon(name);
      try {
        await _local.writePokemon(model);
      } on CacheException {
        // Persisting is best-effort; ignore write failures.
      }
      return Right(model.toEntity());
    } on AppException catch (e) {
      return Left(_mapException(e));
    } on Object catch (e) {
      return Left(UnexpectedFailure(message: '$e'));
    }
  }

  Failure _mapException(AppException e) => switch (e) {
    NetworkException() => NetworkFailure.fromException(e),
    ServerException() => ServerFailure.fromException(e),
    CacheException() => CacheFailure.fromException(e),
    ParsingException() => UnexpectedFailure(message: e.message),
  };
}
