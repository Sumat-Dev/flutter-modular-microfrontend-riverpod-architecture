// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_type_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PokemonTypeModel _$PokemonTypeModelFromJson(Map<String, dynamic> json) =>
    PokemonTypeModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      damageRelations: TypeDamageRelationsModel.fromJson(
        json['damage_relations'] as Map<String, dynamic>,
      ),
      generation: json['generation'] == null
          ? null
          : NamedApiResourceModel.fromJson(
              json['generation'] as Map<String, dynamic>,
            ),
      moveDamageClass: json['move_damage_class'] == null
          ? null
          : NamedApiResourceModel.fromJson(
              json['move_damage_class'] as Map<String, dynamic>,
            ),
      names:
          (json['names'] as List<dynamic>?)
              ?.map(
                (e) => LocalizedNameModel.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
      pokemon:
          (json['pokemon'] as List<dynamic>?)
              ?.map((e) => TypePokemonModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$PokemonTypeModelToJson(PokemonTypeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'damage_relations': instance.damageRelations.toJson(),
      'generation': instance.generation?.toJson(),
      'move_damage_class': instance.moveDamageClass?.toJson(),
      'names': instance.names.map((e) => e.toJson()).toList(),
      'pokemon': instance.pokemon.map((e) => e.toJson()).toList(),
    };

TypeDamageRelationsModel _$TypeDamageRelationsModelFromJson(
  Map<String, dynamic> json,
) => TypeDamageRelationsModel(
  noDamageTo:
      (json['no_damage_to'] as List<dynamic>?)
          ?.map(
            (e) => NamedApiResourceModel.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const [],
  halfDamageTo:
      (json['half_damage_to'] as List<dynamic>?)
          ?.map(
            (e) => NamedApiResourceModel.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const [],
  doubleDamageTo:
      (json['double_damage_to'] as List<dynamic>?)
          ?.map(
            (e) => NamedApiResourceModel.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const [],
  noDamageFrom:
      (json['no_damage_from'] as List<dynamic>?)
          ?.map(
            (e) => NamedApiResourceModel.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const [],
  halfDamageFrom:
      (json['half_damage_from'] as List<dynamic>?)
          ?.map(
            (e) => NamedApiResourceModel.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const [],
  doubleDamageFrom:
      (json['double_damage_from'] as List<dynamic>?)
          ?.map(
            (e) => NamedApiResourceModel.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const [],
);

Map<String, dynamic> _$TypeDamageRelationsModelToJson(
  TypeDamageRelationsModel instance,
) => <String, dynamic>{
  'no_damage_to': instance.noDamageTo.map((e) => e.toJson()).toList(),
  'half_damage_to': instance.halfDamageTo.map((e) => e.toJson()).toList(),
  'double_damage_to': instance.doubleDamageTo.map((e) => e.toJson()).toList(),
  'no_damage_from': instance.noDamageFrom.map((e) => e.toJson()).toList(),
  'half_damage_from': instance.halfDamageFrom.map((e) => e.toJson()).toList(),
  'double_damage_from': instance.doubleDamageFrom
      .map((e) => e.toJson())
      .toList(),
};

TypePokemonModel _$TypePokemonModelFromJson(Map<String, dynamic> json) =>
    TypePokemonModel(
      slot: (json['slot'] as num).toInt(),
      pokemon: NamedApiResourceModel.fromJson(
        json['pokemon'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$TypePokemonModelToJson(TypePokemonModel instance) =>
    <String, dynamic>{
      'slot': instance.slot,
      'pokemon': instance.pokemon.toJson(),
    };
