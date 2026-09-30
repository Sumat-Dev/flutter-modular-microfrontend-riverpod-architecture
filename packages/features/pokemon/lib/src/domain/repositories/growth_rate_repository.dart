import 'package:core/core.dart';

import 'package:feature_pokemon/src/domain/entities/growth_rate.dart';

// A single-method contract is intentional: it mirrors the repository pattern
// used across this feature and keeps the domain boundary explicit.
// ignore: one_member_abstracts
abstract interface class GrowthRateRepository {
  ResultFuture<GrowthRate> getGrowthRate(String idOrName);
}
