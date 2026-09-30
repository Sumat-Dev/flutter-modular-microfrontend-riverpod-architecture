import 'package:core/core.dart';

import 'package:feature_pokemon/src/domain/entities/ability.dart';
import 'package:feature_pokemon/src/domain/repositories/ability_repository.dart';

class GetAbility implements UseCaseWithParams<Ability, String> {
  const GetAbility(this._repository);

  final AbilityRepository _repository;

  @override
  ResultFuture<Ability> call(String params) => _repository.getAbility(params);
}
