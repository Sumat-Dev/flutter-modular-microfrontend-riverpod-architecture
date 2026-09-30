import 'package:core/core.dart';

import 'package:feature_pokemon/src/domain/entities/pokemon_color.dart';
import 'package:feature_pokemon/src/domain/repositories/pokemon_color_repository.dart';

class GetPokemonColor implements UseCaseWithParams<PokemonColor, String> {
  const GetPokemonColor(this._repository);

  final PokemonColorRepository _repository;

  @override
  ResultFuture<PokemonColor> call(String params) =>
      _repository.getPokemonColor(params);
}
