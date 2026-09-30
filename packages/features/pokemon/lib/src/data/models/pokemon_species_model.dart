import 'package:core/core.dart';
import 'package:feature_pokemon/src/data/models/common/named_api_resource_model.dart';
import 'package:feature_pokemon/src/domain/entities/pokemon_species.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pokemon_species_model.g.dart';

@JsonSerializable(explicitToJson: true)
class PokemonSpeciesModel {
  const PokemonSpeciesModel({
    required this.id,
    required this.name,
    required this.order,
    required this.genderRate,
    required this.captureRate,
    required this.baseHappiness,
    required this.isBaby,
    required this.isLegendary,
    required this.isMythical,
    required this.hatchCounter,
    required this.hasGenderDifferences,
    required this.formsSwitchable,
    this.growthRate,
    this.color,
    this.shape,
    this.habitat,
    this.generation,
    this.evolvesFromSpecies,
    this.evolutionChain,
    this.eggGroups = const [],
    this.pokedexNumbers = const [],
    this.varieties = const [],
    this.names = const [],
    this.genera = const [],
    this.flavorTextEntries = const [],
  });

  factory PokemonSpeciesModel.fromJson(DataMap json) =>
      _$PokemonSpeciesModelFromJson(json);

  final int id;
  final String name;
  final int order;

  @JsonKey(name: 'gender_rate')
  final int genderRate;

  @JsonKey(name: 'capture_rate')
  final int captureRate;

  @JsonKey(name: 'base_happiness')
  final int baseHappiness;

  @JsonKey(name: 'is_baby')
  final bool isBaby;

  @JsonKey(name: 'is_legendary')
  final bool isLegendary;

  @JsonKey(name: 'is_mythical')
  final bool isMythical;

  @JsonKey(name: 'hatch_counter')
  final int hatchCounter;

  @JsonKey(name: 'has_gender_differences')
  final bool hasGenderDifferences;

  @JsonKey(name: 'forms_switchable')
  final bool formsSwitchable;

  @JsonKey(name: 'growth_rate')
  final NamedApiResourceModel? growthRate;

  final NamedApiResourceModel? color;
  final NamedApiResourceModel? shape;
  final NamedApiResourceModel? habitat;
  final NamedApiResourceModel? generation;

  @JsonKey(name: 'evolves_from_species')
  final NamedApiResourceModel? evolvesFromSpecies;

  @JsonKey(name: 'evolution_chain')
  final ApiResourceModel? evolutionChain;

  @JsonKey(name: 'egg_groups')
  final List<NamedApiResourceModel> eggGroups;

  @JsonKey(name: 'pokedex_numbers')
  final List<PokedexNumberModel> pokedexNumbers;

  final List<SpeciesVarietyModel> varieties;
  final List<LocalizedNameModel> names;
  final List<GenusModel> genera;

  @JsonKey(name: 'flavor_text_entries')
  final List<FlavorTextModel> flavorTextEntries;

  DataMap toJson() => _$PokemonSpeciesModelToJson(this);

  PokemonSpecies toEntity() => PokemonSpecies(
    id: id,
    name: name,
    order: order,
    genderRate: genderRate,
    captureRate: captureRate,
    baseHappiness: baseHappiness,
    isBaby: isBaby,
    isLegendary: isLegendary,
    isMythical: isMythical,
    hatchCounter: hatchCounter,
    hasGenderDifferences: hasGenderDifferences,
    formsSwitchable: formsSwitchable,
    displayName: pickEnglishName(names),
    growthRate: growthRate?.toEntity(),
    color: color?.toEntity(),
    shape: shape?.toEntity(),
    habitat: habitat?.toEntity(),
    generation: generation?.toEntity(),
    evolvesFromSpecies: evolvesFromSpecies?.toEntity(),
    evolutionChain: evolutionChain?.toEntity(),
    eggGroups: eggGroups.map((e) => e.toEntity()).toList(),
    pokedexNumbers: pokedexNumbers.map((p) => p.toEntity()).toList(),
    varieties: varieties.map((v) => v.toEntity()).toList(),
    genera: _englishGenera(),
    flavorText: _englishFlavorText(),
  );

  List<String> _englishGenera() =>
      genera.where((g) => g.language.name == 'en').map((g) => g.genus).toList();

  String? _englishFlavorText() {
    if (flavorTextEntries.isEmpty) {
      return null;
    }
    return flavorTextEntries
        .firstWhere(
          (f) => f.language.name == 'en',
          orElse: () => flavorTextEntries.first,
        )
        .text;
  }
}

@JsonSerializable(explicitToJson: true)
class PokedexNumberModel {
  const PokedexNumberModel({
    required this.entryNumber,
    required this.pokedex,
  });

  factory PokedexNumberModel.fromJson(DataMap json) =>
      _$PokedexNumberModelFromJson(json);

  @JsonKey(name: 'entry_number')
  final int entryNumber;

  final NamedApiResourceModel pokedex;

  DataMap toJson() => _$PokedexNumberModelToJson(this);

  PokedexNumber toEntity() =>
      PokedexNumber(entryNumber: entryNumber, pokedex: pokedex.toEntity());
}

@JsonSerializable(explicitToJson: true)
class SpeciesVarietyModel {
  const SpeciesVarietyModel({required this.pokemon, required this.isDefault});

  factory SpeciesVarietyModel.fromJson(DataMap json) =>
      _$SpeciesVarietyModelFromJson(json);

  final NamedApiResourceModel pokemon;

  @JsonKey(name: 'is_default')
  final bool isDefault;

  DataMap toJson() => _$SpeciesVarietyModelToJson(this);

  SpeciesVariety toEntity() =>
      SpeciesVariety(pokemon: pokemon.toEntity(), isDefault: isDefault);
}
