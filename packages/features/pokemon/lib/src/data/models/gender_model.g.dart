// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gender_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GenderModel _$GenderModelFromJson(Map<String, dynamic> json) => GenderModel(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  pokemonSpeciesDetails:
      (json['pokemon_species_details'] as List<dynamic>?)
          ?.map(
            (e) => GenderSpeciesDetailModel.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const [],
  requiredForEvolution:
      (json['required_for_evolution'] as List<dynamic>?)
          ?.map(
            (e) => NamedApiResourceModel.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const [],
);

Map<String, dynamic> _$GenderModelToJson(GenderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'pokemon_species_details': instance.pokemonSpeciesDetails
          .map((e) => e.toJson())
          .toList(),
      'required_for_evolution': instance.requiredForEvolution
          .map((e) => e.toJson())
          .toList(),
    };

GenderSpeciesDetailModel _$GenderSpeciesDetailModelFromJson(
  Map<String, dynamic> json,
) => GenderSpeciesDetailModel(
  rate: (json['rate'] as num).toInt(),
  pokemonSpecies: NamedApiResourceModel.fromJson(
    json['pokemon_species'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$GenderSpeciesDetailModelToJson(
  GenderSpeciesDetailModel instance,
) => <String, dynamic>{
  'rate': instance.rate,
  'pokemon_species': instance.pokemonSpecies.toJson(),
};
