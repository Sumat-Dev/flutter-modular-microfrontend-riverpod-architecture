// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nature_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NatureModel _$NatureModelFromJson(Map<String, dynamic> json) => NatureModel(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  decreasedStat: json['decreased_stat'] == null
      ? null
      : NamedApiResourceModel.fromJson(
          json['decreased_stat'] as Map<String, dynamic>,
        ),
  increasedStat: json['increased_stat'] == null
      ? null
      : NamedApiResourceModel.fromJson(
          json['increased_stat'] as Map<String, dynamic>,
        ),
  hatesFlavor: json['hates_flavor'] == null
      ? null
      : NamedApiResourceModel.fromJson(
          json['hates_flavor'] as Map<String, dynamic>,
        ),
  likesFlavor: json['likes_flavor'] == null
      ? null
      : NamedApiResourceModel.fromJson(
          json['likes_flavor'] as Map<String, dynamic>,
        ),
  names:
      (json['names'] as List<dynamic>?)
          ?.map((e) => LocalizedNameModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  pokeathlonStatChanges:
      (json['pokeathlon_stat_changes'] as List<dynamic>?)
          ?.map(
            (e) => NaturePokeathlonStatChangeModel.fromJson(
              e as Map<String, dynamic>,
            ),
          )
          .toList() ??
      const [],
);

Map<String, dynamic> _$NatureModelToJson(NatureModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'decreased_stat': instance.decreasedStat?.toJson(),
      'increased_stat': instance.increasedStat?.toJson(),
      'hates_flavor': instance.hatesFlavor?.toJson(),
      'likes_flavor': instance.likesFlavor?.toJson(),
      'names': instance.names.map((e) => e.toJson()).toList(),
      'pokeathlon_stat_changes': instance.pokeathlonStatChanges
          .map((e) => e.toJson())
          .toList(),
    };

NaturePokeathlonStatChangeModel _$NaturePokeathlonStatChangeModelFromJson(
  Map<String, dynamic> json,
) => NaturePokeathlonStatChangeModel(
  maxChange: (json['max_change'] as num).toInt(),
  pokeathlonStat: NamedApiResourceModel.fromJson(
    json['pokeathlon_stat'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$NaturePokeathlonStatChangeModelToJson(
  NaturePokeathlonStatChangeModel instance,
) => <String, dynamic>{
  'max_change': instance.maxChange,
  'pokeathlon_stat': instance.pokeathlonStat.toJson(),
};
