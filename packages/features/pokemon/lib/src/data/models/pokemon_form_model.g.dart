// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_form_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PokemonFormModel _$PokemonFormModelFromJson(Map<String, dynamic> json) =>
    PokemonFormModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      order: (json['order'] as num).toInt(),
      formOrder: (json['form_order'] as num).toInt(),
      isDefault: json['is_default'] as bool,
      isBattleOnly: json['is_battle_only'] as bool,
      isMega: json['is_mega'] as bool,
      formName: json['form_name'] as String,
      pokemon: json['pokemon'] == null
          ? null
          : NamedApiResourceModel.fromJson(
              json['pokemon'] as Map<String, dynamic>,
            ),
      types: json['types'] == null
          ? const []
          : PokemonFormModel._typesFromJson(json['types'] as List?),
      spriteUrl: PokemonFormModel._spriteFromJson(
        json['sprites'] as Map<String, dynamic>?,
      ),
    );

Map<String, dynamic> _$PokemonFormModelToJson(PokemonFormModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'order': instance.order,
      'form_order': instance.formOrder,
      'is_default': instance.isDefault,
      'is_battle_only': instance.isBattleOnly,
      'is_mega': instance.isMega,
      'form_name': instance.formName,
      'pokemon': instance.pokemon?.toJson(),
      'types': PokemonFormModel._typesToJson(instance.types),
      'sprites': PokemonFormModel._spriteToJson(instance.spriteUrl),
    };
