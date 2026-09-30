import 'package:equatable/equatable.dart';

import 'package:feature_pokemon/src/domain/entities/common/named_api_resource.dart';
import 'package:feature_pokemon/src/domain/entities/pokemon.dart';

class PokemonDetail extends Equatable {
  const PokemonDetail({
    required this.id,
    required this.name,
    required this.height,
    required this.weight,
    required this.types,
    required this.stats,
    this.baseExperience,
    this.order,
    this.isDefault,
    this.abilities = const [],
    this.forms = const [],
    this.heldItems = const [],
    this.gameIndices = const [],
    this.moves = const [],
    this.species,
    this.spriteUrl,
    this.locationAreaEncounters,
  });

  final int id;
  final String name;
  final int height;
  final int weight;
  final List<String> types;
  final List<PokemonStat> stats;

  // --- Enriched fields (all optional to preserve backward compatibility). ---

  final int? baseExperience;
  final int? order;
  final bool? isDefault;
  final List<PokemonAbility> abilities;
  final List<NamedApiResource> forms;
  final List<PokemonHeldItem> heldItems;
  final List<PokemonGameIndex> gameIndices;
  final List<PokemonMove> moves;
  final NamedApiResource? species;

  /// `sprites.front_default` (kept flat; UI already prefers official artwork).
  final String? spriteUrl;

  /// URL to the `/pokemon/{id}/encounters` endpoint.
  final String? locationAreaEncounters;

  Pokemon get summary => Pokemon(id: id, name: name);

  String get imageUrl => summary.imageUrl;

  @override
  List<Object?> get props => [
    id,
    name,
    height,
    weight,
    types,
    stats,
    baseExperience,
    order,
    isDefault,
    abilities,
    forms,
    heldItems,
    gameIndices,
    moves,
    species,
    spriteUrl,
    locationAreaEncounters,
  ];
}

class PokemonStat extends Equatable {
  const PokemonStat({required this.name, required this.baseValue});

  final String name;
  final int baseValue;

  @override
  List<Object?> get props => [name, baseValue];
}

class PokemonAbility extends Equatable {
  const PokemonAbility({
    required this.ability,
    required this.isHidden,
    required this.slot,
  });

  final NamedApiResource ability;
  final bool isHidden;
  final int slot;

  @override
  List<Object?> get props => [ability, isHidden, slot];
}

class PokemonHeldItem extends Equatable {
  const PokemonHeldItem({required this.item});

  final NamedApiResource item;

  @override
  List<Object?> get props => [item];
}

class PokemonGameIndex extends Equatable {
  const PokemonGameIndex({required this.gameIndex, required this.version});

  final int gameIndex;
  final NamedApiResource version;

  @override
  List<Object?> get props => [gameIndex, version];
}

class PokemonMove extends Equatable {
  const PokemonMove({required this.move});

  final NamedApiResource move;

  @override
  List<Object?> get props => [move];
}
