import 'package:library_core/library_core.dart';

import '../../domain/entities/pokemon_detail.dart';

/// DTO for `/pokemon/{name}`.
class PokemonDetailModel {
  const PokemonDetailModel({
    required this.id,
    required this.name,
    required this.height,
    required this.weight,
    required this.types,
    required this.stats,
  });

  final int id;
  final String name;
  final int height;
  final int weight;
  final List<String> types;
  final List<PokemonStatModel> stats;

  factory PokemonDetailModel.fromJson(JsonMap json) {
    final typeList = (json['types'] as List<dynamic>? ?? [])
        .map((dynamic t) => (t as JsonMap)['type'] as JsonMap)
        .map((JsonMap t) => t['name'] as String)
        .toList();

    final statList = (json['stats'] as List<dynamic>? ?? [])
        .map((dynamic s) => PokemonStatModel.fromJson(s as JsonMap))
        .toList();

    return PokemonDetailModel(
      id: json['id'] as int,
      name: json['name'] as String,
      height: json['height'] as int,
      weight: json['weight'] as int,
      types: typeList,
      stats: statList,
    );
  }

  JsonMap toJson() => {
    'id': id,
    'name': name,
    'height': height,
    'weight': weight,
    'types': types
        .map(
          (t) => {
            'type': {'name': t},
          },
        )
        .toList(),
    'stats': stats.map((s) => s.toJson()).toList(),
  };

  PokemonDetail toEntity() => PokemonDetail(
    id: id,
    name: name,
    height: height,
    weight: weight,
    types: types,
    stats: stats.map((s) => s.toEntity()).toList(),
  );
}

class PokemonStatModel {
  const PokemonStatModel({required this.name, required this.baseValue});

  final String name;
  final int baseValue;

  factory PokemonStatModel.fromJson(JsonMap json) => PokemonStatModel(
    name: (json['stat'] as JsonMap)['name'] as String,
    baseValue: json['base_stat'] as int,
  );

  JsonMap toJson() => {
    'base_stat': baseValue,
    'stat': {'name': name},
  };

  PokemonStat toEntity() => PokemonStat(name: name, baseValue: baseValue);
}
