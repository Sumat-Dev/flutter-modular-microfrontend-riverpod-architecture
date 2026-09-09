import 'package:library_core/library_core.dart';

import '../../domain/entities/pokemon.dart';

/// DTO for a list entry from `/pokemon?offset=&limit=`.
/// PokeAPI returns `{name, url}`; the id is parsed from the url.
class PokemonModel {
  const PokemonModel({required this.id, required this.name});

  factory PokemonModel.fromListJson(JsonMap json) {
    final name = json['name'] as String;
    final url = json['url'] as String;
    return PokemonModel(id: _idFromUrl(url), name: name);
  }

  final int id;
  final String name;

  Pokemon toEntity() => Pokemon(id: id, name: name);

  JsonMap toJson() => {'id': id, 'name': name};

  factory PokemonModel.fromCacheJson(JsonMap json) =>
      PokemonModel(id: json['id'] as int, name: json['name'] as String);

  /// Extracts the trailing numeric id from a resource url like
  /// `.../pokemon/25/`.
  static int _idFromUrl(String url) {
    final segments = url.split('/').where((s) => s.isNotEmpty).toList();
    final last = segments.isNotEmpty ? segments.last : '';
    return int.tryParse(last) ?? 0;
  }
}
