import 'package:core/core.dart';

import 'package:feature_pokemon/src/domain/entities/gender.dart';
import 'package:feature_pokemon/src/domain/repositories/gender_repository.dart';

class GetGender implements UseCaseWithParams<Gender, String> {
  const GetGender(this._repository);

  final GenderRepository _repository;

  @override
  ResultFuture<Gender> call(String params) => _repository.getGender(params);
}
