import 'package:core/core.dart';

import 'package:feature_pokemon/src/domain/entities/location_area_encounter.dart';

// A single-method contract is intentional: it mirrors the repository pattern
// used across this feature and keeps the domain boundary explicit.
// ignore: one_member_abstracts
abstract interface class EncounterRepository {
  ResultFuture<List<LocationAreaEncounter>> getEncounters(String idOrName);
}
