import 'package:core/core.dart';
import 'package:feature_pokemon/src/data/datasources/resource_list_remote_data_source.dart';
import 'package:feature_pokemon/src/data/models/egg_group_model.dart';
import 'package:feature_pokemon/src/domain/entities/egg_group.dart';
import 'package:feature_pokemon/src/domain/repositories/egg_group_repository.dart';

class EggGroupRepositoryImpl implements EggGroupRepository {
  const EggGroupRepositoryImpl(this._remote);

  final ResourceListRemoteDataSource _remote;

  @override
  ResultFuture<EggGroup> getEggGroup(String idOrName) async {
    try {
      final json = await _remote.fetchDetail(
        path: 'egg-group',
        idOrName: idOrName,
      );
      try {
        return Right(EggGroupModel.fromJson(json).toEntity());
      } on Object catch (e) {
        return Left(UnexpectedFailure(message: 'Parse egg group failed: $e'));
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
