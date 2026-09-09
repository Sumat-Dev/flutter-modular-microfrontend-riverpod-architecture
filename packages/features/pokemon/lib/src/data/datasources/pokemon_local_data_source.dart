import 'package:library_core/library_core.dart';
import 'package:library_storage/library_storage.dart';

import '../models/pokemon_detail_model.dart';

/// Caches Pokemon detail via the shared [KeyValueStore] abstraction.
abstract interface class PokemonLocalDataSource {
  Future<PokemonDetailModel?> readPokemon(String name);

  Future<void> writePokemon(PokemonDetailModel model);
}

class PokemonLocalDataSourceImpl implements PokemonLocalDataSource {
  const PokemonLocalDataSourceImpl(this._store);

  final KeyValueStore _store;

  static String _key(String name) => 'pokemon_detail_$name';

  @override
  Future<PokemonDetailModel?> readPokemon(String name) async {
    final json = await _store.read(_key(name));
    if (json == null) {
      return null;
    }
    try {
      return PokemonDetailModel.fromJson(json);
    } on Object catch (e) {
      throw CacheException('Corrupt cache for "$name": $e');
    }
  }

  @override
  Future<void> writePokemon(PokemonDetailModel model) =>
      _store.write(_key(model.name), model.toJson());
}
