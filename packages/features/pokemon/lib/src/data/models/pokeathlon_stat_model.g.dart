// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokeathlon_stat_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PokeathlonStatModel _$PokeathlonStatModelFromJson(Map<String, dynamic> json) =>
    PokeathlonStatModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      names:
          (json['names'] as List<dynamic>?)
              ?.map(
                (e) => LocalizedNameModel.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
    );

Map<String, dynamic> _$PokeathlonStatModelToJson(
  PokeathlonStatModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'names': instance.names.map((e) => e.toJson()).toList(),
};
