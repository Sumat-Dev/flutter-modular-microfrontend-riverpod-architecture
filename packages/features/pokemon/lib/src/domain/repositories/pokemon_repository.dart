import 'package:library_core/library_core.dart';

import '../entities/pokemon.dart';
import '../entities/pokemon_detail.dart';

/// Domain contract. The data layer provides the implementation (plan §10).
abstract interface class PokemonRepository {
  FutureResult<PaginatedResult<Pokemon>> getPokemonList(PageRequest page);

  FutureResult<PokemonDetail> getPokemon(String name);
}
