import 'package:core/core.dart';

import 'package:feature_pokemon/src/domain/entities/stat.dart';
import 'package:feature_pokemon/src/domain/repositories/stat_repository.dart';

class GetStat implements UseCaseWithParams<Stat, String> {
  const GetStat(this._repository);

  final StatRepository _repository;

  @override
  ResultFuture<Stat> call(String params) => _repository.getStat(params);
}
