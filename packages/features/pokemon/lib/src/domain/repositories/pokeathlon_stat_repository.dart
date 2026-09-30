import 'package:core/core.dart';

import 'package:feature_pokemon/src/domain/entities/pokeathlon_stat.dart';

// A single-method contract is intentional: it mirrors the repository pattern
// used across this feature and keeps the domain boundary explicit.
// ignore: one_member_abstracts
abstract interface class PokeathlonStatRepository {
  ResultFuture<PokeathlonStat> getPokeathlonStat(String idOrName);
}
