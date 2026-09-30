import 'package:core/core.dart';
import 'package:feature_pokemon/src/data/models/common/named_api_resource_model.dart';
import 'package:feature_pokemon/src/domain/entities/ability.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ability_model.g.dart';

@JsonSerializable(explicitToJson: true)
class AbilityModel {
  const AbilityModel({
    required this.id,
    required this.name,
    required this.isMainSeries,
    this.generation,
    this.names = const [],
    this.effectEntries = const [],
    this.pokemon = const [],
  });

  factory AbilityModel.fromJson(DataMap json) => _$AbilityModelFromJson(json);

  final int id;
  final String name;

  @JsonKey(name: 'is_main_series')
  final bool isMainSeries;

  final NamedApiResourceModel? generation;
  final List<LocalizedNameModel> names;

  @JsonKey(name: 'effect_entries')
  final List<AbilityEffectModel> effectEntries;

  final List<AbilityPokemonModel> pokemon;

  DataMap toJson() => _$AbilityModelToJson(this);

  Ability toEntity() {
    final english = effectEntries.firstWhere(
      (e) => e.language.name == 'en',
      orElse: () => effectEntries.isNotEmpty
          ? effectEntries.first
          : const AbilityEffectModel(
              effect: '',
              shortEffect: '',
              language: NamedApiResourceModel(name: '', url: ''),
            ),
    );
    return Ability(
      id: id,
      name: name,
      isMainSeries: isMainSeries,
      generation: generation?.toEntity(),
      displayName: pickEnglishName(names),
      effect: effectEntries.isEmpty ? null : english.effect,
      shortEffect: effectEntries.isEmpty ? null : english.shortEffect,
      pokemon: pokemon.map((p) => p.toEntity()).toList(),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class AbilityEffectModel {
  const AbilityEffectModel({
    required this.effect,
    required this.shortEffect,
    required this.language,
  });

  factory AbilityEffectModel.fromJson(DataMap json) =>
      _$AbilityEffectModelFromJson(json);

  final String effect;

  @JsonKey(name: 'short_effect')
  final String shortEffect;

  final NamedApiResourceModel language;

  DataMap toJson() => _$AbilityEffectModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class AbilityPokemonModel {
  const AbilityPokemonModel({
    required this.pokemon,
    required this.isHidden,
    required this.slot,
  });

  factory AbilityPokemonModel.fromJson(DataMap json) =>
      _$AbilityPokemonModelFromJson(json);

  final NamedApiResourceModel pokemon;

  @JsonKey(name: 'is_hidden')
  final bool isHidden;

  final int slot;

  DataMap toJson() => _$AbilityPokemonModelToJson(this);

  AbilityPokemon toEntity() => AbilityPokemon(
    pokemon: pokemon.toEntity(),
    isHidden: isHidden,
    slot: slot,
  );
}
