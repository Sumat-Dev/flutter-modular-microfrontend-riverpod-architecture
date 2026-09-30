import 'package:core/core.dart';

import 'package:feature_pokemon/src/domain/entities/pokemon_species.dart';
import 'package:feature_pokemon/src/domain/repositories/pokemon_species_repository.dart';

class GetPokemonSpecies implements UseCaseWithParams<PokemonSpecies, String> {
  const GetPokemonSpecies(this._repository);

  final PokemonSpeciesRepository _repository;

  @override
  ResultFuture<PokemonSpecies> call(String params) =>
      _repository.getPokemonSpecies(params);
}
