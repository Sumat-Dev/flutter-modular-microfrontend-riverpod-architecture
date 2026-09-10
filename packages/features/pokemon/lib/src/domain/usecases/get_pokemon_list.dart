import 'package:core/core.dart';

import 'package:feature_pokemon/src/domain/entities/pokemon.dart';
import 'package:feature_pokemon/src/domain/repositories/pokemon_repository.dart';

/// Fetches a page of Pokemon.
class GetPokemonList
    implements UseCaseWithParams<PaginatedResult<Pokemon>, PageRequest> {
  const GetPokemonList(this._repository);

  final PokemonRepository _repository;

  @override
  ResultFuture<PaginatedResult<Pokemon>> call(PageRequest params) =>
      _repository.getPokemonList(params);
}
