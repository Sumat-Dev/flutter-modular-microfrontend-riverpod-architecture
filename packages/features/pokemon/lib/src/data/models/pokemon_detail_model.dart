import 'package:core/core.dart';
import 'package:feature_pokemon/src/data/models/common/named_api_resource_model.dart';
import 'package:feature_pokemon/src/domain/entities/pokemon_detail.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pokemon_detail_model.g.dart';

@JsonSerializable(explicitToJson: true)
class PokemonDetailModel {
  const PokemonDetailModel({
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

  factory PokemonDetailModel.fromJson(DataMap json) =>
      _$PokemonDetailModelFromJson(json);

  final int id;
  final String name;
  final int height;
  final int weight;

  @JsonKey(fromJson: _typesFromJson, toJson: _typesToJson)
  final List<String> types;

  final List<PokemonStatModel> stats;

  // --- Enriched fields (all optional; minimal JSON still parses). ---

  @JsonKey(name: 'base_experience')
  final int? baseExperience;

  final int? order;

  @JsonKey(name: 'is_default')
  final bool? isDefault;

  final List<PokemonAbilityModel> abilities;
  final List<NamedApiResourceModel> forms;

  @JsonKey(name: 'held_items')
  final List<PokemonHeldItemModel> heldItems;

  @JsonKey(name: 'game_indices')
  final List<PokemonGameIndexModel> gameIndices;

  final List<PokemonMoveModel> moves;
  final NamedApiResourceModel? species;

  @JsonKey(name: 'sprites', fromJson: _spriteFromJson, toJson: _spriteToJson)
  final String? spriteUrl;

  @JsonKey(name: 'location_area_encounters')
  final String? locationAreaEncounters;

  DataMap toJson() => _$PokemonDetailModelToJson(this);

  PokemonDetail toEntity() => PokemonDetail(
    id: id,
    name: name,
    height: height,
    weight: weight,
    types: types,
    stats: stats.map((s) => s.toEntity()).toList(),
    baseExperience: baseExperience,
    order: order,
    isDefault: isDefault,
    abilities: abilities.map((a) => a.toEntity()).toList(),
    forms: forms.map((f) => f.toEntity()).toList(),
    heldItems: heldItems.map((h) => h.toEntity()).toList(),
    gameIndices: gameIndices.map((g) => g.toEntity()).toList(),
    moves: moves.map((m) => m.toEntity()).toList(),
    species: species?.toEntity(),
    spriteUrl: spriteUrl,
    locationAreaEncounters: locationAreaEncounters,
  );

  static List<String> _typesFromJson(List<dynamic>? raw) => (raw ?? [])
      .map((dynamic t) => (t as DataMap)['type'] as DataMap)
      .map((DataMap t) => t['name'] as String)
      .toList();

  static List<Map<String, dynamic>> _typesToJson(List<String> types) => types
      .map(
        (t) => {
          'type': {'name': t},
        },
      )
      .toList();

  static String? _spriteFromJson(DataMap? sprites) =>
      sprites?['front_default'] as String?;

  static Map<String, dynamic> _spriteToJson(String? url) => {
    'front_default': url,
  };
}

@JsonSerializable()
class PokemonStatModel {
  const PokemonStatModel({required this.name, required this.baseValue});

  factory PokemonStatModel.fromJson(DataMap json) =>
      _$PokemonStatModelFromJson(json);

  @JsonKey(name: 'stat', fromJson: _nameFromStat, toJson: _nameToStat)
  final String name;

  @JsonKey(name: 'base_stat')
  final int baseValue;

  DataMap toJson() => _$PokemonStatModelToJson(this);

  PokemonStat toEntity() => PokemonStat(name: name, baseValue: baseValue);

  static String _nameFromStat(DataMap stat) => stat['name'] as String;

  static Map<String, dynamic> _nameToStat(String name) => {'name': name};
}

@JsonSerializable(explicitToJson: true)
class PokemonAbilityModel {
  const PokemonAbilityModel({
    required this.ability,
    required this.isHidden,
    required this.slot,
  });

  factory PokemonAbilityModel.fromJson(DataMap json) =>
      _$PokemonAbilityModelFromJson(json);

  final NamedApiResourceModel ability;

  @JsonKey(name: 'is_hidden')
  final bool isHidden;

  final int slot;

  DataMap toJson() => _$PokemonAbilityModelToJson(this);

  PokemonAbility toEntity() => PokemonAbility(
    ability: ability.toEntity(),
    isHidden: isHidden,
    slot: slot,
  );
}

@JsonSerializable(explicitToJson: true)
class PokemonHeldItemModel {
  const PokemonHeldItemModel({required this.item});

  factory PokemonHeldItemModel.fromJson(DataMap json) =>
      _$PokemonHeldItemModelFromJson(json);

  final NamedApiResourceModel item;

  DataMap toJson() => _$PokemonHeldItemModelToJson(this);

  PokemonHeldItem toEntity() => PokemonHeldItem(item: item.toEntity());
}

@JsonSerializable(explicitToJson: true)
class PokemonGameIndexModel {
  const PokemonGameIndexModel({
    required this.gameIndex,
    required this.version,
  });

  factory PokemonGameIndexModel.fromJson(DataMap json) =>
      _$PokemonGameIndexModelFromJson(json);

  @JsonKey(name: 'game_index')
  final int gameIndex;

  final NamedApiResourceModel version;

  DataMap toJson() => _$PokemonGameIndexModelToJson(this);

  PokemonGameIndex toEntity() =>
      PokemonGameIndex(gameIndex: gameIndex, version: version.toEntity());
}

@JsonSerializable(explicitToJson: true)
class PokemonMoveModel {
  const PokemonMoveModel({required this.move});

  factory PokemonMoveModel.fromJson(DataMap json) =>
      _$PokemonMoveModelFromJson(json);

  final NamedApiResourceModel move;

  DataMap toJson() => _$PokemonMoveModelToJson(this);

  PokemonMove toEntity() => PokemonMove(move: move.toEntity());
}
