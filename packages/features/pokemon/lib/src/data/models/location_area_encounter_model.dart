import 'package:core/core.dart';
import 'package:feature_pokemon/src/data/models/common/named_api_resource_model.dart';
import 'package:feature_pokemon/src/domain/entities/location_area_encounter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'location_area_encounter_model.g.dart';

@JsonSerializable(explicitToJson: true)
class LocationAreaEncounterModel {
  const LocationAreaEncounterModel({
    required this.locationArea,
    this.versionDetails = const [],
  });

  factory LocationAreaEncounterModel.fromJson(DataMap json) =>
      _$LocationAreaEncounterModelFromJson(json);

  @JsonKey(name: 'location_area')
  final NamedApiResourceModel locationArea;

  @JsonKey(name: 'version_details')
  final List<EncounterVersionDetailModel> versionDetails;

  DataMap toJson() => _$LocationAreaEncounterModelToJson(this);

  LocationAreaEncounter toEntity() => LocationAreaEncounter(
    locationArea: locationArea.toEntity(),
    versionDetails: versionDetails.map((v) => v.toEntity()).toList(),
  );
}

@JsonSerializable(explicitToJson: true)
class EncounterVersionDetailModel {
  const EncounterVersionDetailModel({
    required this.version,
    required this.maxChance,
    this.encounterDetails = const [],
  });

  factory EncounterVersionDetailModel.fromJson(DataMap json) =>
      _$EncounterVersionDetailModelFromJson(json);

  final NamedApiResourceModel version;

  @JsonKey(name: 'max_chance')
  final int maxChance;

  @JsonKey(name: 'encounter_details')
  final List<EncounterDetailModel> encounterDetails;

  DataMap toJson() => _$EncounterVersionDetailModelToJson(this);

  EncounterVersionDetail toEntity() => EncounterVersionDetail(
    version: version.toEntity(),
    maxChance: maxChance,
    encounterDetails: encounterDetails.map((e) => e.toEntity()).toList(),
  );
}

@JsonSerializable(explicitToJson: true)
class EncounterDetailModel {
  const EncounterDetailModel({
    required this.chance,
    required this.maxLevel,
    required this.minLevel,
    required this.method,
    this.conditionValues = const [],
  });

  factory EncounterDetailModel.fromJson(DataMap json) =>
      _$EncounterDetailModelFromJson(json);

  final int chance;

  @JsonKey(name: 'max_level')
  final int maxLevel;

  @JsonKey(name: 'min_level')
  final int minLevel;

  final NamedApiResourceModel method;

  @JsonKey(name: 'condition_values')
  final List<NamedApiResourceModel> conditionValues;

  DataMap toJson() => _$EncounterDetailModelToJson(this);

  EncounterDetail toEntity() => EncounterDetail(
    chance: chance,
    maxLevel: maxLevel,
    minLevel: minLevel,
    method: method.toEntity(),
    conditionValues: conditionValues.map((c) => c.toEntity()).toList(),
  );
}
