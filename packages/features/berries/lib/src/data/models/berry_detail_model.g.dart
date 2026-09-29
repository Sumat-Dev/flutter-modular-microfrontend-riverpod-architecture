// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'berry_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BerryDetailModel _$BerryDetailModelFromJson(Map<String, dynamic> json) =>
    BerryDetailModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      growthTime: (json['growth_time'] as num).toInt(),
      maxHarvest: (json['max_harvest'] as num).toInt(),
      naturalGiftPower: (json['natural_gift_power'] as num).toInt(),
      size: (json['size'] as num).toInt(),
      smoothness: (json['smoothness'] as num).toInt(),
      soilDryness: (json['soil_dryness'] as num).toInt(),
      firmness: BerryDetailModel._nameFromResource(
        json['firmness'] as Map<String, dynamic>,
      ),
      naturalGiftType: BerryDetailModel._nameFromResource(
        json['natural_gift_type'] as Map<String, dynamic>,
      ),
      flavors: (json['flavors'] as List<dynamic>)
          .map((e) => BerryFlavorModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BerryDetailModelToJson(BerryDetailModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'growth_time': instance.growthTime,
      'max_harvest': instance.maxHarvest,
      'natural_gift_power': instance.naturalGiftPower,
      'size': instance.size,
      'smoothness': instance.smoothness,
      'soil_dryness': instance.soilDryness,
      'firmness': BerryDetailModel._nameToResource(instance.firmness),
      'natural_gift_type': BerryDetailModel._nameToResource(
        instance.naturalGiftType,
      ),
      'flavors': instance.flavors.map((e) => e.toJson()).toList(),
    };

BerryFlavorModel _$BerryFlavorModelFromJson(Map<String, dynamic> json) =>
    BerryFlavorModel(
      flavor: BerryFlavorModel._nameFromResource(
        json['flavor'] as Map<String, dynamic>,
      ),
      potency: (json['potency'] as num).toInt(),
    );

Map<String, dynamic> _$BerryFlavorModelToJson(BerryFlavorModel instance) =>
    <String, dynamic>{
      'flavor': BerryFlavorModel._nameToResource(instance.flavor),
      'potency': instance.potency,
    };
