import 'package:core/core.dart';

import 'package:feature_pokemon/src/domain/entities/nature.dart';

// A single-method contract is intentional: it mirrors the repository pattern
// used across this feature and keeps the domain boundary explicit.
// ignore: one_member_abstracts
abstract interface class NatureRepository {
  ResultFuture<Nature> getNature(String idOrName);
}
