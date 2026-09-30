// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_species_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PokemonSpeciesModel _$PokemonSpeciesModelFromJson(
  Map<String, dynamic> json,
) => PokemonSpeciesModel(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  order: (json['order'] as num).toInt(),
  genderRate: (json['gender_rate'] as num).toInt(),
  captureRate: (json['capture_rate'] as num).toInt(),
  baseHappiness: (json['base_happiness'] as num).toInt(),
  isBaby: json['is_baby'] as bool,
  isLegendary: json['is_legendary'] as bool,
  isMythical: json['is_mythical'] as bool,
  hatchCounter: (json['hatch_counter'] as num).toInt(),
  hasGenderDifferences: json['has_gender_differences'] as bool,
  formsSwitchable: json['forms_switchable'] as bool,
  growthRate: json['growth_rate'] == null
      ? null
      : NamedApiResourceModel.fromJson(
          json['growth_rate'] as Map<String, dynamic>,
        ),
  color: json['color'] == null
      ? null
      : NamedApiResourceModel.fromJson(json['color'] as Map<String, dynamic>),
  shape: json['shape'] == null
      ? null
      : NamedApiResourceModel.fromJson(json['shape'] as Map<String, dynamic>),
  habitat: json['habitat'] == null
      ? null
      : NamedApiResourceModel.fromJson(json['habitat'] as Map<String, dynamic>),
  generation: json['generation'] == null
      ? null
      : NamedApiResourceModel.fromJson(
          json['generation'] as Map<String, dynamic>,
        ),
  evolvesFromSpecies: json['evolves_from_species'] == null
      ? null
      : NamedApiResourceModel.fromJson(
          json['evolves_from_species'] as Map<String, dynamic>,
        ),
  evolutionChain: json['evolution_chain'] == null
      ? null
      : ApiResourceModel.fromJson(
          json['evolution_chain'] as Map<String, dynamic>,
        ),
  eggGroups:
      (json['egg_groups'] as List<dynamic>?)
          ?.map(
            (e) => NamedApiResourceModel.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const [],
  pokedexNumbers:
      (json['pokedex_numbers'] as List<dynamic>?)
          ?.map((e) => PokedexNumberModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  varieties:
      (json['varieties'] as List<dynamic>?)
          ?.map((e) => SpeciesVarietyModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  names:
      (json['names'] as List<dynamic>?)
          ?.map((e) => LocalizedNameModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  genera:
      (json['genera'] as List<dynamic>?)
          ?.map((e) => GenusModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  flavorTextEntries:
      (json['flavor_text_entries'] as List<dynamic>?)
          ?.map((e) => FlavorTextModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$PokemonSpeciesModelToJson(
  PokemonSpeciesModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'order': instance.order,
  'gender_rate': instance.genderRate,
  'capture_rate': instance.captureRate,
  'base_happiness': instance.baseHappiness,
  'is_baby': instance.isBaby,
  'is_legendary': instance.isLegendary,
  'is_mythical': instance.isMythical,
  'hatch_counter': instance.hatchCounter,
  'has_gender_differences': instance.hasGenderDifferences,
  'forms_switchable': instance.formsSwitchable,
  'growth_rate': instance.growthRate?.toJson(),
  'color': instance.color?.toJson(),
  'shape': instance.shape?.toJson(),
  'habitat': instance.habitat?.toJson(),
  'generation': instance.generation?.toJson(),
  'evolves_from_species': instance.evolvesFromSpecies?.toJson(),
  'evolution_chain': instance.evolutionChain?.toJson(),
  'egg_groups': instance.eggGroups.map((e) => e.toJson()).toList(),
  'pokedex_numbers': instance.pokedexNumbers.map((e) => e.toJson()).toList(),
  'varieties': instance.varieties.map((e) => e.toJson()).toList(),
  'names': instance.names.map((e) => e.toJson()).toList(),
  'genera': instance.genera.map((e) => e.toJson()).toList(),
  'flavor_text_entries': instance.flavorTextEntries
      .map((e) => e.toJson())
      .toList(),
};

PokedexNumberModel _$PokedexNumberModelFromJson(Map<String, dynamic> json) =>
    PokedexNumberModel(
      entryNumber: (json['entry_number'] as num).toInt(),
      pokedex: NamedApiResourceModel.fromJson(
        json['pokedex'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$PokedexNumberModelToJson(PokedexNumberModel instance) =>
    <String, dynamic>{
      'entry_number': instance.entryNumber,
      'pokedex': instance.pokedex.toJson(),
    };

SpeciesVarietyModel _$SpeciesVarietyModelFromJson(Map<String, dynamic> json) =>
    SpeciesVarietyModel(
      pokemon: NamedApiResourceModel.fromJson(
        json['pokemon'] as Map<String, dynamic>,
      ),
      isDefault: json['is_default'] as bool,
    );

Map<String, dynamic> _$SpeciesVarietyModelToJson(
  SpeciesVarietyModel instance,
) => <String, dynamic>{
  'pokemon': instance.pokemon.toJson(),
  'is_default': instance.isDefault,
};
