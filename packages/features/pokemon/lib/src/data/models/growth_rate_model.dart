import 'package:core/core.dart';
import 'package:feature_pokemon/src/data/models/common/named_api_resource_model.dart';
import 'package:feature_pokemon/src/domain/entities/growth_rate.dart';
import 'package:json_annotation/json_annotation.dart';

part 'growth_rate_model.g.dart';

@JsonSerializable(explicitToJson: true)
class GrowthRateModel {
  const GrowthRateModel({
    required this.id,
    required this.name,
    required this.formula,
    this.descriptions = const [],
    this.levels = const [],
    this.pokemonSpecies = const [],
  });

  factory GrowthRateModel.fromJson(DataMap json) =>
      _$GrowthRateModelFromJson(json);

  final int id;
  final String name;
  final String formula;
  final List<LocalizedDescriptionModel> descriptions;
  final List<GrowthRateLevelModel> levels;

  @JsonKey(name: 'pokemon_species')
  final List<NamedApiResourceModel> pokemonSpecies;

  DataMap toJson() => _$GrowthRateModelToJson(this);

  GrowthRate toEntity() => GrowthRate(
    id: id,
    name: name,
    formula: formula,
    description: _pickEnglishDescription(),
    levels: levels.map((e) => e.toEntity()).toList(),
    pokemonSpecies: pokemonSpecies.map((e) => e.toEntity()).toList(),
  );

  String? _pickEnglishDescription() {
    if (descriptions.isEmpty) {
      return null;
    }
    return descriptions
        .firstWhere(
          (d) => d.language.name == 'en',
          orElse: () => descriptions.first,
        )
        .description;
  }
}

@JsonSerializable(explicitToJson: true)
class GrowthRateLevelModel {
  const GrowthRateLevelModel({
    required this.level,
    required this.experience,
  });

  factory GrowthRateLevelModel.fromJson(DataMap json) =>
      _$GrowthRateLevelModelFromJson(json);

  final int level;
  final int experience;

  DataMap toJson() => _$GrowthRateLevelModelToJson(this);

  GrowthRateLevel toEntity() =>
      GrowthRateLevel(level: level, experience: experience);
}
