import 'package:core/core.dart';
import 'package:feature_pokemon/src/domain/entities/pokemon_detail.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pokemon_detail_model.g.dart';

@JsonSerializable(explicitToJson: true)
class PokemonDetailModel {
  const PokemonDetailModel({
    required this.id,
    required this.name,
    required this.height,
    required this.weight,
    required this.types,
    required this.stats,
  });

  factory PokemonDetailModel.fromJson(DataMap json) =>
      _$PokemonDetailModelFromJson(json);

  final int id;
  final String name;
  final int height;
  final int weight;

  @JsonKey(fromJson: _typesFromJson, toJson: _typesToJson)
  final List<String> types;

  final List<PokemonStatModel> stats;

  DataMap toJson() => _$PokemonDetailModelToJson(this);

  PokemonDetail toEntity() => PokemonDetail(
    id: id,
    name: name,
    height: height,
    weight: weight,
    types: types,
    stats: stats.map((s) => s.toEntity()).toList(),
  );

  static List<String> _typesFromJson(List<dynamic>? raw) => (raw ?? [])
      .map((dynamic t) => (t as DataMap)['type'] as DataMap)
      .map((DataMap t) => t['name'] as String)
      .toList();

  static List<Map<String, dynamic>> _typesToJson(List<String> types) => types
      .map(
        (t) => {
          'type': {'name': t},
        },
      )
      .toList();
}

@JsonSerializable()
class PokemonStatModel {
  const PokemonStatModel({required this.name, required this.baseValue});

  factory PokemonStatModel.fromJson(DataMap json) =>
      _$PokemonStatModelFromJson(json);

  @JsonKey(name: 'stat', fromJson: _nameFromStat, toJson: _nameToStat)
  final String name;

  @JsonKey(name: 'base_stat')
  final int baseValue;

  DataMap toJson() => _$PokemonStatModelToJson(this);

  PokemonStat toEntity() => PokemonStat(name: name, baseValue: baseValue);

  static String _nameFromStat(DataMap stat) => stat['name'] as String;

  static Map<String, dynamic> _nameToStat(String name) => {'name': name};
}
