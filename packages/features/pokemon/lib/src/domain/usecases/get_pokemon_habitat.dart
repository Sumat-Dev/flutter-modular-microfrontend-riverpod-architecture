import 'package:core/core.dart';

import 'package:feature_pokemon/src/domain/entities/pokemon_habitat.dart';
import 'package:feature_pokemon/src/domain/repositories/pokemon_habitat_repository.dart';

class GetPokemonHabitat implements UseCaseWithParams<PokemonHabitat, String> {
  const GetPokemonHabitat(this._repository);

  final PokemonHabitatRepository _repository;

  @override
  ResultFuture<PokemonHabitat> call(String params) =>
      _repository.getPokemonHabitat(params);
}
