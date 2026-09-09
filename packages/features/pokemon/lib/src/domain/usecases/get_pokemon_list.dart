import 'package:library_core/library_core.dart';

import '../entities/pokemon.dart';
import '../repositories/pokemon_repository.dart';

/// Fetches a page of Pokemon.
class GetPokemonList implements UseCase<PaginatedResult<Pokemon>, PageRequest> {
  const GetPokemonList(this._repository);

  final PokemonRepository _repository;

  @override
  FutureResult<PaginatedResult<Pokemon>> call(PageRequest params) =>
      _repository.getPokemonList(params);
}
