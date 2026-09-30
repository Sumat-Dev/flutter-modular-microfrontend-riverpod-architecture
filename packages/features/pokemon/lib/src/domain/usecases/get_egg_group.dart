import 'package:core/core.dart';

import 'package:feature_pokemon/src/domain/entities/egg_group.dart';
import 'package:feature_pokemon/src/domain/repositories/egg_group_repository.dart';

class GetEggGroup implements UseCaseWithParams<EggGroup, String> {
  const GetEggGroup(this._repository);

  final EggGroupRepository _repository;

  @override
  ResultFuture<EggGroup> call(String params) => _repository.getEggGroup(params);
}
