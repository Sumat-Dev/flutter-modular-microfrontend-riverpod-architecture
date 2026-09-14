import 'package:core/core.dart';

import 'package:feature_pokemon/src/domain/entities/pokemon_detail.dart';
import 'package:feature_pokemon/src/domain/repositories/pokemon_repository.dart';

/// Fetches a single Pokemon's full detail by name.
class GetPokemon implements UseCaseWithParams<PokemonDetail, String> {
  const GetPokemon(this._repository);

  final PokemonRepository _repository;

  @override
  ResultFuture<PokemonDetail> call(String params) =>
      _repository.getPokemon(params);
}
