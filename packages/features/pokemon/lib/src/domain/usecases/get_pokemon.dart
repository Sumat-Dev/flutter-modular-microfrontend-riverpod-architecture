import 'package:library_core/library_core.dart';

import '../entities/pokemon_detail.dart';
import '../repositories/pokemon_repository.dart';

/// Fetches a single Pokemon's full detail by name.
class GetPokemon implements UseCase<PokemonDetail, String> {
  const GetPokemon(this._repository);

  final PokemonRepository _repository;

  @override
  FutureResult<PokemonDetail> call(String params) =>
      _repository.getPokemon(params);
}
