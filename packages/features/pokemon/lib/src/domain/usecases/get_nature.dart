import 'package:core/core.dart';

import 'package:feature_pokemon/src/domain/entities/nature.dart';
import 'package:feature_pokemon/src/domain/repositories/nature_repository.dart';

class GetNature implements UseCaseWithParams<Nature, String> {
  const GetNature(this._repository);

  final NatureRepository _repository;

  @override
  ResultFuture<Nature> call(String params) => _repository.getNature(params);
}
