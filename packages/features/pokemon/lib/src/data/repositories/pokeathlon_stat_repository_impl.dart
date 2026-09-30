import 'package:core/core.dart';
import 'package:feature_pokemon/src/data/datasources/resource_list_remote_data_source.dart';
import 'package:feature_pokemon/src/data/models/pokeathlon_stat_model.dart';
import 'package:feature_pokemon/src/domain/entities/pokeathlon_stat.dart';
import 'package:feature_pokemon/src/domain/repositories/pokeathlon_stat_repository.dart';

class PokeathlonStatRepositoryImpl implements PokeathlonStatRepository {
  const PokeathlonStatRepositoryImpl(this._remote);

  final ResourceListRemoteDataSource _remote;

  @override
  ResultFuture<PokeathlonStat> getPokeathlonStat(String idOrName) async {
    try {
      final json = await _remote.fetchDetail(
        path: 'pokeathlon-stat',
        idOrName: idOrName,
      );
      try {
        return Right(PokeathlonStatModel.fromJson(json).toEntity());
      } on Object catch (e) {
        return Left(
          UnexpectedFailure(message: 'Parse pokeathlon stat failed: $e'),
        );
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
