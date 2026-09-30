import 'package:equatable/equatable.dart';

import 'package:feature_pokemon/src/domain/entities/common/named_api_resource.dart';

/// `/pokemon-habitat/{id or name}`.
class PokemonHabitat extends Equatable {
  const PokemonHabitat({
    required this.id,
    required this.name,
    this.displayName,
    this.pokemonSpecies = const [],
  });

  final int id;
  final String name;
  final String? displayName;
  final List<NamedApiResource> pokemonSpecies;

  @override
  List<Object?> get props => [id, name, displayName, pokemonSpecies];
}
