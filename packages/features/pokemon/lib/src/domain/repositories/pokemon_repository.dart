import 'package:core/core.dart';

import '../entities/pokemon.dart';
import '../entities/pokemon_detail.dart';

/// Domain contract. The data layer provides the implementation (plan §10).
abstract interface class PokemonRepository {
  ResultFuture<PaginatedResult<Pokemon>> getPokemonList(PageRequest page);

  ResultFuture<PokemonDetail> getPokemon(String name);
}
