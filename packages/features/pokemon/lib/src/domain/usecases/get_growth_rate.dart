import 'package:core/core.dart';

import 'package:feature_pokemon/src/domain/entities/growth_rate.dart';
import 'package:feature_pokemon/src/domain/repositories/growth_rate_repository.dart';

class GetGrowthRate implements UseCaseWithParams<GrowthRate, String> {
  const GetGrowthRate(this._repository);

  final GrowthRateRepository _repository;

  @override
  ResultFuture<GrowthRate> call(String params) =>
      _repository.getGrowthRate(params);
}
