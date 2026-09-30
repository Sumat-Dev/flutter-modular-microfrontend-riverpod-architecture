// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'egg_group_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EggGroupModel _$EggGroupModelFromJson(Map<String, dynamic> json) =>
    EggGroupModel(
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

Map<String, dynamic> _$EggGroupModelToJson(
  EggGroupModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'names': instance.names.map((e) => e.toJson()).toList(),
  'pokemon_species': instance.pokemonSpecies.map((e) => e.toJson()).toList(),
};
