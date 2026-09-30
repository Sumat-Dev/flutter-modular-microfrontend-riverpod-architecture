import 'package:core/core.dart';

import 'package:feature_pokemon/src/domain/entities/pokemon_shape.dart';
import 'package:feature_pokemon/src/domain/repositories/pokemon_shape_repository.dart';

class GetPokemonShape implements UseCaseWithParams<PokemonShape, String> {
  const GetPokemonShape(this._repository);

  final PokemonShapeRepository _repository;

  @override
  ResultFuture<PokemonShape> call(String params) =>
      _repository.getPokemonShape(params);
}
