// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemDetailModel _$ItemDetailModelFromJson(Map<String, dynamic> json) =>
    ItemDetailModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      cost: (json['cost'] as num).toInt(),
      category: ItemDetailModel._nameFromResource(
        json['category'] as Map<String, dynamic>,
      ),
      attributes: ItemDetailModel._attributesFromJson(
        json['attributes'] as List?,
      ),
      effect: ItemDetailModel._effectFromJson(json['effect_entries'] as List?),
      flingPower: (json['fling_power'] as num?)?.toInt(),
      spriteUrl: ItemDetailModel._spriteFromJson(
        json['sprites'] as Map<String, dynamic>?,
      ),
    );

Map<String, dynamic> _$ItemDetailModelToJson(ItemDetailModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'cost': instance.cost,
      'category': ItemDetailModel._nameToResource(instance.category),
      'attributes': ItemDetailModel._attributesToJson(instance.attributes),
      'effect_entries': ItemDetailModel._effectToJson(instance.effect),
      'fling_power': instance.flingPower,
      'sprites': ItemDetailModel._spriteToJson(instance.spriteUrl),
    };
