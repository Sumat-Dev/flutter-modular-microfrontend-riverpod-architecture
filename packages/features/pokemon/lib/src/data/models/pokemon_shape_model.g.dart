// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_shape_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PokemonShapeModel _$PokemonShapeModelFromJson(Map<String, dynamic> json) =>
    PokemonShapeModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      names:
          (json['names'] as List<dynamic>?)
              ?.map(
                (e) => LocalizedNameModel.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
      awesomeNames:
          (json['awesome_names'] as List<dynamic>?)
              ?.map(
                (e) =>
                    ShapeAwesomeNameModel.fromJson(e as Map<String, dynamic>),
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

Map<String, dynamic> _$PokemonShapeModelToJson(
  PokemonShapeModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'names': instance.names.map((e) => e.toJson()).toList(),
  'awesome_names': instance.awesomeNames.map((e) => e.toJson()).toList(),
  'pokemon_species': instance.pokemonSpecies.map((e) => e.toJson()).toList(),
};

ShapeAwesomeNameModel _$ShapeAwesomeNameModelFromJson(
  Map<String, dynamic> json,
) => ShapeAwesomeNameModel(
  awesomeName: json['awesome_name'] as String,
  language: NamedApiResourceModel.fromJson(
    json['language'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$ShapeAwesomeNameModelToJson(
  ShapeAwesomeNameModel instance,
) => <String, dynamic>{
  'awesome_name': instance.awesomeName,
  'language': instance.language.toJson(),
};
