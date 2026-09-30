// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'characteristic_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CharacteristicModel _$CharacteristicModelFromJson(Map<String, dynamic> json) =>
    CharacteristicModel(
      id: (json['id'] as num).toInt(),
      geneModulo: (json['gene_modulo'] as num).toInt(),
      possibleValues: (json['possible_values'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      highestStat: NamedApiResourceModel.fromJson(
        json['highest_stat'] as Map<String, dynamic>,
      ),
      descriptions:
          (json['descriptions'] as List<dynamic>?)
              ?.map(
                (e) => LocalizedDescriptionModel.fromJson(
                  e as Map<String, dynamic>,
                ),
              )
              .toList() ??
          const [],
    );

Map<String, dynamic> _$CharacteristicModelToJson(
  CharacteristicModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'gene_modulo': instance.geneModulo,
  'possible_values': instance.possibleValues,
  'highest_stat': instance.highestStat.toJson(),
  'descriptions': instance.descriptions.map((e) => e.toJson()).toList(),
};
