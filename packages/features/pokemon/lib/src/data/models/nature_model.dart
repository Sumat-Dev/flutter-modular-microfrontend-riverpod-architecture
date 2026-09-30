import 'package:core/core.dart';
import 'package:feature_pokemon/src/data/models/common/named_api_resource_model.dart';
import 'package:feature_pokemon/src/domain/entities/nature.dart';
import 'package:json_annotation/json_annotation.dart';

part 'nature_model.g.dart';

@JsonSerializable(explicitToJson: true)
class NatureModel {
  const NatureModel({
    required this.id,
    required this.name,
    this.decreasedStat,
    this.increasedStat,
    this.hatesFlavor,
    this.likesFlavor,
    this.names = const [],
    this.pokeathlonStatChanges = const [],
  });

  factory NatureModel.fromJson(DataMap json) => _$NatureModelFromJson(json);

  final int id;
  final String name;

  @JsonKey(name: 'decreased_stat')
  final NamedApiResourceModel? decreasedStat;

  @JsonKey(name: 'increased_stat')
  final NamedApiResourceModel? increasedStat;

  @JsonKey(name: 'hates_flavor')
  final NamedApiResourceModel? hatesFlavor;

  @JsonKey(name: 'likes_flavor')
  final NamedApiResourceModel? likesFlavor;

  final List<LocalizedNameModel> names;

  @JsonKey(name: 'pokeathlon_stat_changes')
  final List<NaturePokeathlonStatChangeModel> pokeathlonStatChanges;

  DataMap toJson() => _$NatureModelToJson(this);

  Nature toEntity() => Nature(
    id: id,
    name: name,
    displayName: pickEnglishName(names),
    decreasedStat: decreasedStat?.toEntity(),
    increasedStat: increasedStat?.toEntity(),
    hatesFlavor: hatesFlavor?.toEntity(),
    likesFlavor: likesFlavor?.toEntity(),
    pokeathlonStatChanges: pokeathlonStatChanges
        .map((e) => e.toEntity())
        .toList(),
  );
}

@JsonSerializable(explicitToJson: true)
class NaturePokeathlonStatChangeModel {
  const NaturePokeathlonStatChangeModel({
    required this.maxChange,
    required this.pokeathlonStat,
  });

  factory NaturePokeathlonStatChangeModel.fromJson(DataMap json) =>
      _$NaturePokeathlonStatChangeModelFromJson(json);

  @JsonKey(name: 'max_change')
  final int maxChange;

  @JsonKey(name: 'pokeathlon_stat')
  final NamedApiResourceModel pokeathlonStat;

  DataMap toJson() => _$NaturePokeathlonStatChangeModelToJson(this);

  NaturePokeathlonStatChange toEntity() => NaturePokeathlonStatChange(
    maxChange: maxChange,
    pokeathlonStat: pokeathlonStat.toEntity(),
  );
}
