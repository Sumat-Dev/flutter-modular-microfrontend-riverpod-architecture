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
      return Left(Failure.fromException(e));
    } on Object catch (e) {
      return Left(UnexpectedFailure(message: '$e'));
    }
  }
}
