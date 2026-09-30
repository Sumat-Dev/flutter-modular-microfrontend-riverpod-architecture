import 'package:equatable/equatable.dart';

import 'package:feature_pokemon/src/domain/entities/common/named_api_resource.dart';

/// One entry of `GET /pokemon/{id or name}/encounters` (a bare JSON array).
class LocationAreaEncounter extends Equatable {
  const LocationAreaEncounter({
    required this.locationArea,
    this.versionDetails = const [],
  });

  final NamedApiResource locationArea;
  final List<EncounterVersionDetail> versionDetails;

  @override
  List<Object?> get props => [locationArea, versionDetails];
}

/// Encounter chance/details for one game version.
class EncounterVersionDetail extends Equatable {
  const EncounterVersionDetail({
    required this.version,
    required this.maxChance,
    this.encounterDetails = const [],
  });

  final NamedApiResource version;
  final int maxChance;
  final List<EncounterDetail> encounterDetails;

  @override
  List<Object?> get props => [version, maxChance, encounterDetails];
}

/// A single encounter method/level/chance record.
class EncounterDetail extends Equatable {
  const EncounterDetail({
    required this.chance,
    required this.maxLevel,
    required this.minLevel,
    required this.method,
    this.conditionValues = const [],
  });

  final int chance;
  final int maxLevel;
  final int minLevel;
  final NamedApiResource method;
  final List<NamedApiResource> conditionValues;

  @override
  List<Object?> get props => [
    chance,
    maxLevel,
    minLevel,
    method,
    conditionValues,
  ];
}
