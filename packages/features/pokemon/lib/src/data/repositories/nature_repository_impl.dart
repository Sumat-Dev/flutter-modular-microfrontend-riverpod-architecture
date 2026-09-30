import 'package:core/core.dart';
import 'package:feature_pokemon/src/data/datasources/resource_list_remote_data_source.dart';
import 'package:feature_pokemon/src/data/models/nature_model.dart';
import 'package:feature_pokemon/src/domain/entities/nature.dart';
import 'package:feature_pokemon/src/domain/repositories/nature_repository.dart';

class NatureRepositoryImpl implements NatureRepository {
  const NatureRepositoryImpl(this._remote);

  final ResourceListRemoteDataSource _remote;

  @override
  ResultFuture<Nature> getNature(String idOrName) async {
    try {
      final json = await _remote.fetchDetail(
        path: 'nature',
        idOrName: idOrName,
      );
      try {
        return Right(NatureModel.fromJson(json).toEntity());
      } on Object catch (e) {
        return Left(UnexpectedFailure(message: 'Parse nature failed: $e'));
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
