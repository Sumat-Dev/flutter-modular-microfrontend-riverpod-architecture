import 'package:core/core.dart';
import 'package:feature_pokemon/src/data/datasources/resource_list_remote_data_source.dart';
import 'package:feature_pokemon/src/data/models/stat_model.dart';
import 'package:feature_pokemon/src/domain/entities/stat.dart';
import 'package:feature_pokemon/src/domain/repositories/stat_repository.dart';

class StatRepositoryImpl implements StatRepository {
  const StatRepositoryImpl(this._remote);

  final ResourceListRemoteDataSource _remote;

  @override
  ResultFuture<Stat> getStat(String idOrName) async {
    try {
      final json = await _remote.fetchDetail(
        path: 'stat',
        idOrName: idOrName,
      );
      try {
        return Right(StatModel.fromJson(json).toEntity());
      } on Object catch (e) {
        return Left(UnexpectedFailure(message: 'Parse stat failed: $e'));
      }
    } on AppException catch (e) {
      return Left(Failure.fromException(e));
    } on Object catch (e) {
      return Left(UnexpectedFailure(message: '$e'));
    }
  }
}
