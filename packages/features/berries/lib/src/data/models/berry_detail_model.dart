import 'package:core/core.dart';
import 'package:feature_berries/src/domain/entities/berry_detail.dart';
import 'package:json_annotation/json_annotation.dart';

part 'berry_detail_model.g.dart';

@JsonSerializable(explicitToJson: true)
class BerryDetailModel {
  const BerryDetailModel({
    required this.id,
    required this.name,
    required this.growthTime,
    required this.maxHarvest,
    required this.naturalGiftPower,
    required this.size,
    required this.smoothness,
    required this.soilDryness,
    required this.firmness,
    required this.naturalGiftType,
    required this.flavors,
  });

  factory BerryDetailModel.fromJson(DataMap json) =>
      _$BerryDetailModelFromJson(json);

  final int id;
  final String name;

  @JsonKey(name: 'growth_time')
  final int growthTime;

  @JsonKey(name: 'max_harvest')
  final int maxHarvest;

  @JsonKey(name: 'natural_gift_power')
  final int naturalGiftPower;

  final int size;
  final int smoothness;

  @JsonKey(name: 'soil_dryness')
  final int soilDryness;

  @JsonKey(fromJson: _nameFromResource, toJson: _nameToResource)
  final String firmness;

  @JsonKey(
    name: 'natural_gift_type',
    fromJson: _nameFromResource,
    toJson: _nameToResource,
  )
  final String naturalGiftType;

  final List<BerryFlavorModel> flavors;

  DataMap toJson() => _$BerryDetailModelToJson(this);

  BerryDetail toEntity() => BerryDetail(
    id: id,
    name: name,
    growthTime: growthTime,
    maxHarvest: maxHarvest,
    naturalGiftPower: naturalGiftPower,
    size: size,
    smoothness: smoothness,
    soilDryness: soilDryness,
    firmness: firmness,
    naturalGiftType: naturalGiftType,
    flavors: flavors.map((f) => f.toEntity()).toList(),
  );

  static String _nameFromResource(DataMap resource) =>
      resource['name'] as String;

  static Map<String, dynamic> _nameToResource(String name) => {'name': name};
}

@JsonSerializable()
class BerryFlavorModel {
  const BerryFlavorModel({required this.flavor, required this.potency});

  factory BerryFlavorModel.fromJson(DataMap json) =>
      _$BerryFlavorModelFromJson(json);

  @JsonKey(fromJson: _nameFromResource, toJson: _nameToResource)
  final String flavor;

  final int potency;

  DataMap toJson() => _$BerryFlavorModelToJson(this);

  BerryFlavor toEntity() => BerryFlavor(flavor: flavor, potency: potency);

  static String _nameFromResource(DataMap resource) =>
      resource['name'] as String;

  static Map<String, dynamic> _nameToResource(String name) => {'name': name};
}
