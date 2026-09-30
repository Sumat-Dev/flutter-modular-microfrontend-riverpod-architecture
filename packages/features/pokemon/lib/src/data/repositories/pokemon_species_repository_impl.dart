import 'package:core/core.dart';
import 'package:feature_pokemon/src/data/datasources/resource_list_remote_data_source.dart';
import 'package:feature_pokemon/src/data/models/pokemon_species_model.dart';
import 'package:feature_pokemon/src/domain/entities/pokemon_species.dart';
import 'package:feature_pokemon/src/domain/repositories/pokemon_species_repository.dart';

class PokemonSpeciesRepositoryImpl implements PokemonSpeciesRepository {
  const PokemonSpeciesRepositoryImpl(this._remote);

  final ResourceListRemoteDataSource _remote;

  @override
  ResultFuture<PokemonSpecies> getPokemonSpecies(String idOrName) async {
    try {
      final json = await _remote.fetchDetail(
        path: 'pokemon-species',
        idOrName: idOrName,
      );
      try {
        return Right(PokemonSpeciesModel.fromJson(json).toEntity());
      } on Object catch (e) {
        return Left(UnexpectedFailure(message: 'Parse species failed: $e'));
      }
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
