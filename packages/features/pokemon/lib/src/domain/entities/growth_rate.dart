import 'package:equatable/equatable.dart';

import 'package:feature_pokemon/src/domain/entities/common/named_api_resource.dart';

/// `/growth-rate/{id or name}`.
class GrowthRate extends Equatable {
  const GrowthRate({
    required this.id,
    required this.name,
    required this.formula,
    this.description,
    this.levels = const [],
    this.pokemonSpecies = const [],
  });

  final int id;
  final String name;
  final String formula;
  final String? description;
  final List<GrowthRateLevel> levels;
  final List<NamedApiResource> pokemonSpecies;

  @override
  List<Object?> get props => [
    id,
    name,
    formula,
    description,
    levels,
    pokemonSpecies,
  ];
}

/// The experience required to reach a given level for this growth rate.
class GrowthRateLevel extends Equatable {
  const GrowthRateLevel({
    required this.level,
    required this.experience,
  });

  final int level;
  final int experience;

  @override
  List<Object?> get props => [level, experience];
}
