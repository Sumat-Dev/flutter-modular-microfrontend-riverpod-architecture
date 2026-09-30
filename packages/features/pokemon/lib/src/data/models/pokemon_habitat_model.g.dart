// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_habitat_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PokemonHabitatModel _$PokemonHabitatModelFromJson(Map<String, dynamic> json) =>
    PokemonHabitatModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      names:
          (json['names'] as List<dynamic>?)
              ?.map(
                (e) => LocalizedNameModel.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
      pokemonSpecies:
          (json['pokemon_species'] as List<dynamic>?)
              ?.map(
                (e) =>
                    NamedApiResourceModel.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
    );

Map<String, dynamic> _$PokemonHabitatModelToJson(
  PokemonHabitatModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'names': instance.names.map((e) => e.toJson()).toList(),
  'pokemon_species': instance.pokemonSpecies.map((e) => e.toJson()).toList(),
};
