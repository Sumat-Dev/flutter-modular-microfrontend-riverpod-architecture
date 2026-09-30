import 'package:core/core.dart';
import 'package:feature_pokemon/src/data/models/common/named_api_resource_model.dart';
import 'package:feature_pokemon/src/domain/entities/stat.dart';
import 'package:json_annotation/json_annotation.dart';

part 'stat_model.g.dart';

@JsonSerializable(explicitToJson: true)
class StatModel {
  const StatModel({
    required this.id,
    required this.name,
    required this.gameIndex,
    required this.isBattleOnly,
    this.moveDamageClass,
    this.names = const [],
  });

  factory StatModel.fromJson(DataMap json) => _$StatModelFromJson(json);

  final int id;
  final String name;

  @JsonKey(name: 'game_index')
  final int gameIndex;

  @JsonKey(name: 'is_battle_only')
  final bool isBattleOnly;

  @JsonKey(name: 'move_damage_class')
  final NamedApiResourceModel? moveDamageClass;

  final List<LocalizedNameModel> names;

  DataMap toJson() => _$StatModelToJson(this);

  Stat toEntity() => Stat(
    id: id,
    name: name,
    gameIndex: gameIndex,
    isBattleOnly: isBattleOnly,
    displayName: pickEnglishName(names),
    moveDamageClass: moveDamageClass?.toEntity(),
  );
}
