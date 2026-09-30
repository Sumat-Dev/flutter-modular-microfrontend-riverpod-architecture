import 'package:equatable/equatable.dart';

import 'package:feature_pokemon/src/domain/entities/common/named_api_resource.dart';

/// `/pokemon-shape/{id or name}`.
class PokemonShape extends Equatable {
  const PokemonShape({
    required this.id,
    required this.name,
    this.displayName,
    this.awesomeNames = const [],
    this.pokemonSpecies = const [],
  });

  final int id;
  final String name;
  final String? displayName;
  final List<ShapeAwesomeName> awesomeNames;
  final List<NamedApiResource> pokemonSpecies;

  @override
  List<Object?> get props => [
    id,
    name,
    displayName,
    awesomeNames,
    pokemonSpecies,
  ];
}

/// The "scientific" name for this shape in a given language.
class ShapeAwesomeName extends Equatable {
  const ShapeAwesomeName({
    required this.awesomeName,
    required this.language,
  });

  final String awesomeName;
  final NamedApiResource language;

  @override
  List<Object?> get props => [awesomeName, language];
}
