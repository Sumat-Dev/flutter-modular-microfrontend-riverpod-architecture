import 'package:core/core.dart';
import 'package:feature_pokemon/src/data/datasources/resource_list_remote_data_source.dart';
import 'package:feature_pokemon/src/data/models/ability_model.dart';
import 'package:feature_pokemon/src/domain/entities/ability.dart';
import 'package:feature_pokemon/src/domain/repositories/ability_repository.dart';

class AbilityRepositoryImpl implements AbilityRepository {
  const AbilityRepositoryImpl(this._remote);

  final ResourceListRemoteDataSource _remote;

  @override
  ResultFuture<Ability> getAbility(String idOrName) async {
    try {
      final json = await _remote.fetchDetail(
        path: 'ability',
        idOrName: idOrName,
      );
      try {
        return Right(AbilityModel.fromJson(json).toEntity());
      } on Object catch (e) {
        return Left(UnexpectedFailure(message: 'Parse ability failed: $e'));
      }
    } on AppException catch (e) {
      return Left(Failure.fromException(e));
    } on Object catch (e) {
      return Left(UnexpectedFailure(message: '$e'));
    }
  }
}
