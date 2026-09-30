import 'package:core/core.dart';
import 'package:feature_pokemon/src/data/datasources/resource_list_remote_data_source.dart';
import 'package:feature_pokemon/src/data/models/growth_rate_model.dart';
import 'package:feature_pokemon/src/domain/entities/growth_rate.dart';
import 'package:feature_pokemon/src/domain/repositories/growth_rate_repository.dart';

class GrowthRateRepositoryImpl implements GrowthRateRepository {
  const GrowthRateRepositoryImpl(this._remote);

  final ResourceListRemoteDataSource _remote;

  @override
  ResultFuture<GrowthRate> getGrowthRate(String idOrName) async {
    try {
      final json = await _remote.fetchDetail(
        path: 'growth-rate',
        idOrName: idOrName,
      );
      try {
        return Right(GrowthRateModel.fromJson(json).toEntity());
      } on Object catch (e) {
        return Left(UnexpectedFailure(message: 'Parse growth rate failed: $e'));
      }
    } on AppException catch (e) {
      return Left(Failure.fromException(e));
    } on Object catch (e) {
      return Left(UnexpectedFailure(message: '$e'));
    }
  }
}
