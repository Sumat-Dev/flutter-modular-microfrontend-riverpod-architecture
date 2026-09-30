import 'package:equatable/equatable.dart';

import 'package:feature_pokemon/src/domain/entities/common/named_api_resource.dart';

/// `/pokemon-species/{id or name}`.
class PokemonSpecies extends Equatable {
  const PokemonSpecies({
    required this.id,
    required this.name,
    required this.order,
    required this.genderRate,
    required this.captureRate,
    required this.baseHappiness,
    required this.isBaby,
    required this.isLegendary,
    required this.isMythical,
    required this.hatchCounter,
    required this.hasGenderDifferences,
    required this.formsSwitchable,
    this.displayName,
    this.growthRate,
    this.color,
    this.shape,
    this.habitat,
    this.generation,
    this.evolvesFromSpecies,
    this.evolutionChain,
    this.eggGroups = const [],
    this.pokedexNumbers = const [],
    this.varieties = const [],
    this.genera = const [],
    this.flavorText,
  });

  final int id;
  final String name;
  final int order;
  final int genderRate;
  final int captureRate;
  final int baseHappiness;
  final bool isBaby;
  final bool isLegendary;
  final bool isMythical;
  final int hatchCounter;
  final bool hasGenderDifferences;
  final bool formsSwitchable;

  final String? displayName;
  final NamedApiResource? growthRate;
  final NamedApiResource? color;
  final NamedApiResource? shape;
  final NamedApiResource? habitat;
  final NamedApiResource? generation;
  final NamedApiResource? evolvesFromSpecies;

  /// `evolution_chain` is a url-only reference.
  final ApiResource? evolutionChain;

  final List<NamedApiResource> eggGroups;
  final List<PokedexNumber> pokedexNumbers;
  final List<SpeciesVariety> varieties;

  /// English genera, e.g. "Seed Pokémon".
  final List<String> genera;

  /// First English flavor-text entry, if any.
  final String? flavorText;

  @override
  List<Object?> get props => [
    id,
    name,
    order,
    genderRate,
    captureRate,
    baseHappiness,
    isBaby,
    isLegendary,
    isMythical,
    hatchCounter,
    hasGenderDifferences,
    formsSwitchable,
    displayName,
    growthRate,
    color,
    shape,
    habitat,
    generation,
    evolvesFromSpecies,
    evolutionChain,
    eggGroups,
    pokedexNumbers,
    varieties,
    genera,
    flavorText,
  ];
}

/// A pokédex entry number for a given pokédex.
class PokedexNumber extends Equatable {
  const PokedexNumber({required this.entryNumber, required this.pokedex});

  final int entryNumber;
  final NamedApiResource pokedex;

  @override
  List<Object?> get props => [entryNumber, pokedex];
}

/// A species variety reference with its default flag.
class SpeciesVariety extends Equatable {
  const SpeciesVariety({required this.pokemon, required this.isDefault});

  final NamedApiResource pokemon;
  final bool isDefault;

  @override
  List<Object?> get props => [pokemon, isDefault];
}
