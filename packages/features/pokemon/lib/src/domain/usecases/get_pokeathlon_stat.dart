import 'package:core/core.dart';

import 'package:feature_pokemon/src/domain/entities/pokeathlon_stat.dart';
import 'package:feature_pokemon/src/domain/repositories/pokeathlon_stat_repository.dart';

class GetPokeathlonStat implements UseCaseWithParams<PokeathlonStat, String> {
  const GetPokeathlonStat(this._repository);

  final PokeathlonStatRepository _repository;

  @override
  ResultFuture<PokeathlonStat> call(String params) =>
      _repository.getPokeathlonStat(params);
}
