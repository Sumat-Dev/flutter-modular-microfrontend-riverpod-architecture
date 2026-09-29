import 'package:core/core.dart';
import 'package:feature_pokemon/src/domain/entities/pokemon.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pokemon_model.g.dart';

@JsonSerializable()
class PokemonModel {
  const PokemonModel({required this.id, required this.name});

  factory PokemonModel.fromJson(DataMap json) => _$PokemonModelFromJson(json);

  factory PokemonModel.fromCacheJson(DataMap json) =>
      PokemonModel.fromJson(json);

  factory PokemonModel.fromListJson(DataMap json) {
    final name = json['name'] as String;
    final url = json['url'] as String;
    return PokemonModel(id: _idFromUrl(url), name: name);
  }

  final int id;
  final String name;

  Pokemon toEntity() => Pokemon(id: id, name: name);

  DataMap toJson() => _$PokemonModelToJson(this);

  static int _idFromUrl(String url) {
    final segments = url.split('/').where((s) => s.isNotEmpty).toList();
    final last = segments.isNotEmpty ? segments.last : '';
    return int.tryParse(last) ?? 0;
  }
}
