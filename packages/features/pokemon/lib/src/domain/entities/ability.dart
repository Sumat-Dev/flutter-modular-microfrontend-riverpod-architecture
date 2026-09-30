import 'package:equatable/equatable.dart';

import 'package:feature_pokemon/src/domain/entities/common/named_api_resource.dart';

/// `/ability/{id or name}`.
class Ability extends Equatable {
  const Ability({
    required this.id,
    required this.name,
    required this.isMainSeries,
    this.generation,
    this.displayName,
    this.effect,
    this.shortEffect,
    this.pokemon = const [],
  });

  final int id;
  final String name;
  final bool isMainSeries;
  final NamedApiResource? generation;
  final String? displayName;
  final String? effect;
  final String? shortEffect;
  final List<AbilityPokemon> pokemon;

  @override
  List<Object?> get props => [
    id,
    name,
    isMainSeries,
    generation,
    displayName,
    effect,
    shortEffect,
    pokemon,
  ];
}

/// A Pokémon that can have an ability, with slot/hidden metadata.
class AbilityPokemon extends Equatable {
  const AbilityPokemon({
    required this.pokemon,
    required this.isHidden,
    required this.slot,
  });

  final NamedApiResource pokemon;
  final bool isHidden;
  final int slot;

  @override
  List<Object?> get props => [pokemon, isHidden, slot];
}
