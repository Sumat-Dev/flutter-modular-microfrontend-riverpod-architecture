import 'package:library_core/library_core.dart';

import '../../domain/entities/pokemon.dart';
import '../../domain/entities/pokemon_detail.dart';
import '../../domain/repositories/pokemon_repository.dart';
import '../datasources/pokemon_local_data_source.dart';
import '../datasources/pokemon_remote_data_source.dart';

/// Implements [PokemonRepository]. Applies the cache strategy from plan §11
/// (cache hit → entity; miss → remote → save → entity) and maps data-layer
/// exceptions to domain failures per §12.
class PokemonRepositoryImpl implements PokemonRepository {
  const PokemonRepositoryImpl({
    required PokemonRemoteDataSource remote,
    required PokemonLocalDataSource local,
  }) : _remote = remote,
       _local = local;

  final PokemonRemoteDataSource _remote;
  final PokemonLocalDataSource _local;

  @override
  FutureResult<PaginatedResult<Pokemon>> getPokemonList(
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
      return Result.success(result);
    } on AppException catch (e) {
      return Result.failure(_mapException(e));
    } on Object catch (e) {
      return Result.failure(UnexpectedFailure('$e'));
    }
  }

  @override
  FutureResult<PokemonDetail> getPokemon(String name) async {
    // 1. Try cache. A cache failure must not break the feature (§11).
    try {
      final cached = await _local.readPokemon(name);
      if (cached != null) {
        return Result.success(cached.toEntity());
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
      return Result.success(model.toEntity());
    } on AppException catch (e) {
      return Result.failure(_mapException(e));
    } on Object catch (e) {
      return Result.failure(UnexpectedFailure('$e'));
    }
  }

  Failure _mapException(AppException e) => switch (e) {
    NetworkException() => NetworkFailure(e.message, statusCode: e.statusCode),
    ServerException() => ServerFailure(e.message, statusCode: e.statusCode),
    CacheException() => CacheFailure(e.message),
    ParsingException() => UnexpectedFailure(e.message),
  };
}
