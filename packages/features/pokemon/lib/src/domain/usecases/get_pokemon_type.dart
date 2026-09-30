import 'package:core/core.dart';

import 'package:feature_pokemon/src/domain/entities/pokemon_type.dart';
import 'package:feature_pokemon/src/domain/repositories/pokemon_type_repository.dart';

class GetPokemonType implements UseCaseWithParams<PokemonType, String> {
  const GetPokemonType(this._repository);

  final PokemonTypeRepository _repository;

  @override
  ResultFuture<PokemonType> call(String params) =>
      _repository.getPokemonType(params);
}
