import 'package:core/core.dart';

import 'package:feature_pokemon/src/domain/entities/location_area_encounter.dart';
import 'package:feature_pokemon/src/domain/repositories/encounter_repository.dart';

class GetEncounters
    implements UseCaseWithParams<List<LocationAreaEncounter>, String> {
  const GetEncounters(this._repository);

  final EncounterRepository _repository;

  @override
  ResultFuture<List<LocationAreaEncounter>> call(String params) =>
      _repository.getEncounters(params);
}
