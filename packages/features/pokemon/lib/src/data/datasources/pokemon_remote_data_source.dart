import 'package:library_core/library_core.dart';
import 'package:library_network/library_network.dart';

import '../models/pokemon_detail_model.dart';
import '../models/pokemon_model.dart';

/// Talks to PokeAPI via the shared [ApiClient] abstraction (never Dio directly).
abstract interface class PokemonRemoteDataSource {
  Future<
    ({int count, String? next, String? previous, List<PokemonModel> items})
  >
  fetchPokemonList({required int offset, required int limit});

  Future<PokemonDetailModel> fetchPokemon(String name);
}

class PokemonRemoteDataSourceImpl implements PokemonRemoteDataSource {
  const PokemonRemoteDataSourceImpl(this._client);

  final ApiClient _client;

  @override
  Future<
    ({int count, String? next, String? previous, List<PokemonModel> items})
  >
  fetchPokemonList({required int offset, required int limit}) async {
    final json = await _client.get<JsonMap>(
      'pokemon',
      queryParameters: {'offset': offset, 'limit': limit},
    );
    try {
      final results = (json['results'] as List<dynamic>)
          .map((dynamic e) => PokemonModel.fromListJson(e as JsonMap))
          .toList();
      return (
        count: json['count'] as int,
        next: json['next'] as String?,
        previous: json['previous'] as String?,
        items: results,
      );
    } on Object catch (e) {
      throw ParsingException('Failed to parse Pokemon list: $e');
    }
  }

  @override
  Future<PokemonDetailModel> fetchPokemon(String name) async {
    final json = await _client.get<JsonMap>('pokemon/$name');
    try {
      return PokemonDetailModel.fromJson(json);
    } on Object catch (e) {
      throw ParsingException('Failed to parse Pokemon "$name": $e');
    }
  }
}
