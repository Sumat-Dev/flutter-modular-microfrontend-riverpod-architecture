// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'growth_rate_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GrowthRateModel _$GrowthRateModelFromJson(
  Map<String, dynamic> json,
) => GrowthRateModel(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  formula: json['formula'] as String,
  descriptions:
      (json['descriptions'] as List<dynamic>?)
          ?.map(
            (e) =>
                LocalizedDescriptionModel.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const [],
  levels:
      (json['levels'] as List<dynamic>?)
          ?.map((e) => GrowthRateLevelModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  pokemonSpecies:
      (json['pokemon_species'] as List<dynamic>?)
          ?.map(
            (e) => NamedApiResourceModel.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const [],
);

Map<String, dynamic> _$GrowthRateModelToJson(
  GrowthRateModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'formula': instance.formula,
  'descriptions': instance.descriptions.map((e) => e.toJson()).toList(),
  'levels': instance.levels.map((e) => e.toJson()).toList(),
  'pokemon_species': instance.pokemonSpecies.map((e) => e.toJson()).toList(),
};

GrowthRateLevelModel _$GrowthRateLevelModelFromJson(
  Map<String, dynamic> json,
) => GrowthRateLevelModel(
  level: (json['level'] as num).toInt(),
  experience: (json['experience'] as num).toInt(),
);

Map<String, dynamic> _$GrowthRateLevelModelToJson(
  GrowthRateLevelModel instance,
) => <String, dynamic>{
  'level': instance.level,
  'experience': instance.experience,
};
