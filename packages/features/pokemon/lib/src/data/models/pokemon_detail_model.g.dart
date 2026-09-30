// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PokemonDetailModel _$PokemonDetailModelFromJson(
  Map<String, dynamic> json,
) => PokemonDetailModel(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  height: (json['height'] as num).toInt(),
  weight: (json['weight'] as num).toInt(),
  types: PokemonDetailModel._typesFromJson(json['types'] as List?),
  stats: (json['stats'] as List<dynamic>)
      .map((e) => PokemonStatModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  baseExperience: (json['base_experience'] as num?)?.toInt(),
  order: (json['order'] as num?)?.toInt(),
  isDefault: json['is_default'] as bool?,
  abilities:
      (json['abilities'] as List<dynamic>?)
          ?.map((e) => PokemonAbilityModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  forms:
      (json['forms'] as List<dynamic>?)
          ?.map(
            (e) => NamedApiResourceModel.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const [],
  heldItems:
      (json['held_items'] as List<dynamic>?)
          ?.map((e) => PokemonHeldItemModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  gameIndices:
      (json['game_indices'] as List<dynamic>?)
          ?.map(
            (e) => PokemonGameIndexModel.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const [],
  moves:
      (json['moves'] as List<dynamic>?)
          ?.map((e) => PokemonMoveModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  species: json['species'] == null
      ? null
      : NamedApiResourceModel.fromJson(json['species'] as Map<String, dynamic>),
  spriteUrl: PokemonDetailModel._spriteFromJson(
    json['sprites'] as Map<String, dynamic>?,
  ),
  locationAreaEncounters: json['location_area_encounters'] as String?,
);

Map<String, dynamic> _$PokemonDetailModelToJson(PokemonDetailModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'height': instance.height,
      'weight': instance.weight,
      'types': PokemonDetailModel._typesToJson(instance.types),
      'stats': instance.stats.map((e) => e.toJson()).toList(),
      'base_experience': instance.baseExperience,
      'order': instance.order,
      'is_default': instance.isDefault,
      'abilities': instance.abilities.map((e) => e.toJson()).toList(),
      'forms': instance.forms.map((e) => e.toJson()).toList(),
      'held_items': instance.heldItems.map((e) => e.toJson()).toList(),
      'game_indices': instance.gameIndices.map((e) => e.toJson()).toList(),
      'moves': instance.moves.map((e) => e.toJson()).toList(),
      'species': instance.species?.toJson(),
      'sprites': PokemonDetailModel._spriteToJson(instance.spriteUrl),
      'location_area_encounters': instance.locationAreaEncounters,
    };

PokemonStatModel _$PokemonStatModelFromJson(Map<String, dynamic> json) =>
    PokemonStatModel(
      name: PokemonStatModel._nameFromStat(
        json['stat'] as Map<String, dynamic>,
      ),
      baseValue: (json['base_stat'] as num).toInt(),
    );

Map<String, dynamic> _$PokemonStatModelToJson(PokemonStatModel instance) =>
    <String, dynamic>{
      'stat': PokemonStatModel._nameToStat(instance.name),
      'base_stat': instance.baseValue,
    };

PokemonAbilityModel _$PokemonAbilityModelFromJson(Map<String, dynamic> json) =>
    PokemonAbilityModel(
      ability: NamedApiResourceModel.fromJson(
        json['ability'] as Map<String, dynamic>,
      ),
      isHidden: json['is_hidden'] as bool,
      slot: (json['slot'] as num).toInt(),
    );

Map<String, dynamic> _$PokemonAbilityModelToJson(
  PokemonAbilityModel instance,
) => <String, dynamic>{
  'ability': instance.ability.toJson(),
  'is_hidden': instance.isHidden,
  'slot': instance.slot,
};

PokemonHeldItemModel _$PokemonHeldItemModelFromJson(
  Map<String, dynamic> json,
) => PokemonHeldItemModel(
  item: NamedApiResourceModel.fromJson(json['item'] as Map<String, dynamic>),
);

Map<String, dynamic> _$PokemonHeldItemModelToJson(
  PokemonHeldItemModel instance,
) => <String, dynamic>{'item': instance.item.toJson()};

PokemonGameIndexModel _$PokemonGameIndexModelFromJson(
  Map<String, dynamic> json,
) => PokemonGameIndexModel(
  gameIndex: (json['game_index'] as num).toInt(),
  version: NamedApiResourceModel.fromJson(
    json['version'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$PokemonGameIndexModelToJson(
  PokemonGameIndexModel instance,
) => <String, dynamic>{
  'game_index': instance.gameIndex,
  'version': instance.version.toJson(),
};

PokemonMoveModel _$PokemonMoveModelFromJson(Map<String, dynamic> json) =>
    PokemonMoveModel(
      move: NamedApiResourceModel.fromJson(
        json['move'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$PokemonMoveModelToJson(PokemonMoveModel instance) =>
    <String, dynamic>{'move': instance.move.toJson()};
