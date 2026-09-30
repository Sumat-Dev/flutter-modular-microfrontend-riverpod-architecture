import 'package:core/core.dart';
import 'package:feature_pokemon/src/data/datasources/pokemon_remote_data_source.dart';
import 'package:feature_pokemon/src/domain/entities/pokemon.dart';
import 'package:feature_pokemon/src/domain/entities/pokemon_detail.dart';
import 'package:feature_pokemon/src/domain/repositories/pokemon_repository.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  const PokemonRepositoryImpl({required PokemonRemoteDataSource remote})
    : _remote = remote;

  final PokemonRemoteDataSource _remote;

  @override
  ResultFuture<PaginatedResult<Pokemon>> getPokemonList(
    PageRequest page,
  ) async {
    try {
      final res = await _remote.fetchPokemonList(
        offset: page.offset,
        limit: page.limit,
      );
      return Right(
        PaginatedResult<Pokemon>(
          count: res.count,
          next: res.next,
          previous: res.previous,
          items: res.items.map((m) => m.toEntity()).toList(),
        ),
      );
    } on AppException catch (e) {
      return Left(Failure.fromException(e));
    } on Object catch (e) {
      return Left(UnexpectedFailure(message: '$e'));
    }
  }

  @override
  ResultFuture<PokemonDetail> getPokemon(String name) async {
    try {
      final model = await _remote.fetchPokemon(name);
      return Right(model.toEntity());
    } on AppException catch (e) {
      return Left(Failure.fromException(e));
    } on Object catch (e) {
      return Left(UnexpectedFailure(message: '$e'));
    }
  }
}
