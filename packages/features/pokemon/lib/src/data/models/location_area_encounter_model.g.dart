// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_area_encounter_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationAreaEncounterModel _$LocationAreaEncounterModelFromJson(
  Map<String, dynamic> json,
) => LocationAreaEncounterModel(
  locationArea: NamedApiResourceModel.fromJson(
    json['location_area'] as Map<String, dynamic>,
  ),
  versionDetails:
      (json['version_details'] as List<dynamic>?)
          ?.map(
            (e) =>
                EncounterVersionDetailModel.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const [],
);

Map<String, dynamic> _$LocationAreaEncounterModelToJson(
  LocationAreaEncounterModel instance,
) => <String, dynamic>{
  'location_area': instance.locationArea.toJson(),
  'version_details': instance.versionDetails.map((e) => e.toJson()).toList(),
};

EncounterVersionDetailModel _$EncounterVersionDetailModelFromJson(
  Map<String, dynamic> json,
) => EncounterVersionDetailModel(
  version: NamedApiResourceModel.fromJson(
    json['version'] as Map<String, dynamic>,
  ),
  maxChance: (json['max_chance'] as num).toInt(),
  encounterDetails:
      (json['encounter_details'] as List<dynamic>?)
          ?.map((e) => EncounterDetailModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$EncounterVersionDetailModelToJson(
  EncounterVersionDetailModel instance,
) => <String, dynamic>{
  'version': instance.version.toJson(),
  'max_chance': instance.maxChance,
  'encounter_details': instance.encounterDetails
      .map((e) => e.toJson())
      .toList(),
};

EncounterDetailModel _$EncounterDetailModelFromJson(
  Map<String, dynamic> json,
) => EncounterDetailModel(
  chance: (json['chance'] as num).toInt(),
  maxLevel: (json['max_level'] as num).toInt(),
  minLevel: (json['min_level'] as num).toInt(),
  method: NamedApiResourceModel.fromJson(
    json['method'] as Map<String, dynamic>,
  ),
  conditionValues:
      (json['condition_values'] as List<dynamic>?)
          ?.map(
            (e) => NamedApiResourceModel.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const [],
);

Map<String, dynamic> _$EncounterDetailModelToJson(
  EncounterDetailModel instance,
) => <String, dynamic>{
  'chance': instance.chance,
  'max_level': instance.maxLevel,
  'min_level': instance.minLevel,
  'method': instance.method.toJson(),
  'condition_values': instance.conditionValues.map((e) => e.toJson()).toList(),
};
