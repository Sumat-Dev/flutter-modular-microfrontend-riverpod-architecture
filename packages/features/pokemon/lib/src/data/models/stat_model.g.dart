// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stat_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StatModel _$StatModelFromJson(Map<String, dynamic> json) => StatModel(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  gameIndex: (json['game_index'] as num).toInt(),
  isBattleOnly: json['is_battle_only'] as bool,
  moveDamageClass: json['move_damage_class'] == null
      ? null
      : NamedApiResourceModel.fromJson(
          json['move_damage_class'] as Map<String, dynamic>,
        ),
  names:
      (json['names'] as List<dynamic>?)
          ?.map((e) => LocalizedNameModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$StatModelToJson(StatModel instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'game_index': instance.gameIndex,
  'is_battle_only': instance.isBattleOnly,
  'move_damage_class': instance.moveDamageClass?.toJson(),
  'names': instance.names.map((e) => e.toJson()).toList(),
};
