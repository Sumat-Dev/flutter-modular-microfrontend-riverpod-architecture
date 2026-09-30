import 'package:core/core.dart';
import 'package:feature_pokemon/src/data/models/common/named_api_resource_model.dart';
import 'package:feature_pokemon/src/domain/entities/pokemon_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pokemon_type_model.g.dart';

@JsonSerializable(explicitToJson: true)
class PokemonTypeModel {
  const PokemonTypeModel({
    required this.id,
    required this.name,
    required this.damageRelations,
    this.generation,
    this.moveDamageClass,
    this.names = const [],
    this.pokemon = const [],
  });

  factory PokemonTypeModel.fromJson(DataMap json) =>
      _$PokemonTypeModelFromJson(json);

  final int id;
  final String name;

  @JsonKey(name: 'damage_relations')
  final TypeDamageRelationsModel damageRelations;

  final NamedApiResourceModel? generation;

  @JsonKey(name: 'move_damage_class')
  final NamedApiResourceModel? moveDamageClass;

  final List<LocalizedNameModel> names;
  final List<TypePokemonModel> pokemon;

  DataMap toJson() => _$PokemonTypeModelToJson(this);

  PokemonType toEntity() => PokemonType(
    id: id,
    name: name,
    damageRelations: damageRelations.toEntity(),
    displayName: pickEnglishName(names),
    generation: generation?.toEntity(),
    moveDamageClass: moveDamageClass?.toEntity(),
    pokemon: pokemon.map((e) => e.pokemon.toEntity()).toList(),
  );
}

@JsonSerializable(explicitToJson: true)
class TypeDamageRelationsModel {
  const TypeDamageRelationsModel({
    this.noDamageTo = const [],
    this.halfDamageTo = const [],
    this.doubleDamageTo = const [],
    this.noDamageFrom = const [],
    this.halfDamageFrom = const [],
    this.doubleDamageFrom = const [],
  });

  factory TypeDamageRelationsModel.fromJson(DataMap json) =>
      _$TypeDamageRelationsModelFromJson(json);

  @JsonKey(name: 'no_damage_to')
  final List<NamedApiResourceModel> noDamageTo;

  @JsonKey(name: 'half_damage_to')
  final List<NamedApiResourceModel> halfDamageTo;

  @JsonKey(name: 'double_damage_to')
  final List<NamedApiResourceModel> doubleDamageTo;

  @JsonKey(name: 'no_damage_from')
  final List<NamedApiResourceModel> noDamageFrom;

  @JsonKey(name: 'half_damage_from')
  final List<NamedApiResourceModel> halfDamageFrom;

  @JsonKey(name: 'double_damage_from')
  final List<NamedApiResourceModel> doubleDamageFrom;

  DataMap toJson() => _$TypeDamageRelationsModelToJson(this);

  TypeDamageRelations toEntity() => TypeDamageRelations(
    noDamageTo: noDamageTo.map((e) => e.toEntity()).toList(),
    halfDamageTo: halfDamageTo.map((e) => e.toEntity()).toList(),
    doubleDamageTo: doubleDamageTo.map((e) => e.toEntity()).toList(),
    noDamageFrom: noDamageFrom.map((e) => e.toEntity()).toList(),
    halfDamageFrom: halfDamageFrom.map((e) => e.toEntity()).toList(),
    doubleDamageFrom: doubleDamageFrom.map((e) => e.toEntity()).toList(),
  );
}

@JsonSerializable(explicitToJson: true)
class TypePokemonModel {
  const TypePokemonModel({required this.slot, required this.pokemon});

  factory TypePokemonModel.fromJson(DataMap json) =>
      _$TypePokemonModelFromJson(json);

  final int slot;
  final NamedApiResourceModel pokemon;

  DataMap toJson() => _$TypePokemonModelToJson(this);
}
