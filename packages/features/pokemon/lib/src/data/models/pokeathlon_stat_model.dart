import 'package:core/core.dart';
import 'package:feature_pokemon/src/data/models/common/named_api_resource_model.dart';
import 'package:feature_pokemon/src/domain/entities/pokeathlon_stat.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pokeathlon_stat_model.g.dart';

@JsonSerializable(explicitToJson: true)
class PokeathlonStatModel {
  const PokeathlonStatModel({
    required this.id,
    required this.name,
    this.names = const [],
  });

  factory PokeathlonStatModel.fromJson(DataMap json) =>
      _$PokeathlonStatModelFromJson(json);

  final int id;
  final String name;
  final List<LocalizedNameModel> names;

  DataMap toJson() => _$PokeathlonStatModelToJson(this);

  PokeathlonStat toEntity() => PokeathlonStat(
    id: id,
    name: name,
    displayName: pickEnglishName(names),
  );
}
