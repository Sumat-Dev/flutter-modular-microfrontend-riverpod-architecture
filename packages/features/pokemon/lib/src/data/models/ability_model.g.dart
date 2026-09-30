// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ability_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AbilityModel _$AbilityModelFromJson(Map<String, dynamic> json) => AbilityModel(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  isMainSeries: json['is_main_series'] as bool,
  generation: json['generation'] == null
      ? null
      : NamedApiResourceModel.fromJson(
          json['generation'] as Map<String, dynamic>,
        ),
  names:
      (json['names'] as List<dynamic>?)
          ?.map((e) => LocalizedNameModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  effectEntries:
      (json['effect_entries'] as List<dynamic>?)
          ?.map((e) => AbilityEffectModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  pokemon:
      (json['pokemon'] as List<dynamic>?)
          ?.map((e) => AbilityPokemonModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$AbilityModelToJson(AbilityModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'is_main_series': instance.isMainSeries,
      'generation': instance.generation?.toJson(),
      'names': instance.names.map((e) => e.toJson()).toList(),
      'effect_entries': instance.effectEntries.map((e) => e.toJson()).toList(),
      'pokemon': instance.pokemon.map((e) => e.toJson()).toList(),
    };

AbilityEffectModel _$AbilityEffectModelFromJson(Map<String, dynamic> json) =>
    AbilityEffectModel(
      effect: json['effect'] as String,
      shortEffect: json['short_effect'] as String,
      language: NamedApiResourceModel.fromJson(
        json['language'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$AbilityEffectModelToJson(AbilityEffectModel instance) =>
    <String, dynamic>{
      'effect': instance.effect,
      'short_effect': instance.shortEffect,
      'language': instance.language.toJson(),
    };

AbilityPokemonModel _$AbilityPokemonModelFromJson(Map<String, dynamic> json) =>
    AbilityPokemonModel(
      pokemon: NamedApiResourceModel.fromJson(
        json['pokemon'] as Map<String, dynamic>,
      ),
      isHidden: json['is_hidden'] as bool,
      slot: (json['slot'] as num).toInt(),
    );

Map<String, dynamic> _$AbilityPokemonModelToJson(
  AbilityPokemonModel instance,
) => <String, dynamic>{
  'pokemon': instance.pokemon.toJson(),
  'is_hidden': instance.isHidden,
  'slot': instance.slot,
};
