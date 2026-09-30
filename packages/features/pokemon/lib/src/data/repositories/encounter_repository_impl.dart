import 'package:core/core.dart';
import 'package:feature_pokemon/src/data/datasources/encounter_remote_data_source.dart';
import 'package:feature_pokemon/src/domain/entities/location_area_encounter.dart';
import 'package:feature_pokemon/src/domain/repositories/encounter_repository.dart';

class EncounterRepositoryImpl implements EncounterRepository {
  const EncounterRepositoryImpl(this._remote);

  final EncounterRemoteDataSource _remote;

  @override
  ResultFuture<List<LocationAreaEncounter>> getEncounters(
    String idOrName,
  ) async {
    try {
      final models = await _remote.fetchEncounters(idOrName);
      return Right(models.map((m) => m.toEntity()).toList());
    } on AppException catch (e) {
      return Left(Failure.fromException(e));
    } on Object catch (e) {
      return Left(UnexpectedFailure(message: '$e'));
    }
  }
}
