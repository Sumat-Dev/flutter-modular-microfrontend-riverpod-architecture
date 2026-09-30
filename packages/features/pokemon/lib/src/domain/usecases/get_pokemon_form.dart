import 'package:core/core.dart';

import 'package:feature_pokemon/src/domain/entities/pokemon_form.dart';
import 'package:feature_pokemon/src/domain/repositories/pokemon_form_repository.dart';

class GetPokemonForm implements UseCaseWithParams<PokemonForm, String> {
  const GetPokemonForm(this._repository);

  final PokemonFormRepository _repository;

  @override
  ResultFuture<PokemonForm> call(String params) =>
      _repository.getPokemonForm(params);
}
