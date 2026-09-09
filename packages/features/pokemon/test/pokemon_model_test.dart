import 'package:feature_pokemon/src/data/models/pokemon_detail_model.dart';
import 'package:feature_pokemon/src/data/models/pokemon_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PokemonModel.fromListJson', () {
    test('parses id from resource url', () {
      final model = PokemonModel.fromListJson({
        'name': 'pikachu',
        'url': 'https://pokeapi.co/api/v2/pokemon/25/',
      });
      expect(model.id, 25);
      expect(model.name, 'pikachu');
      expect(model.toEntity().imageUrl, contains('25.png'));
    });
  });

  group('PokemonDetailModel', () {
    test('parses types and stats then maps to entity', () {
      final model = PokemonDetailModel.fromJson(const {
        'id': 25,
        'name': 'pikachu',
        'height': 4,
        'weight': 60,
        'types': [
          {
            'type': {'name': 'electric'},
          },
        ],
        'stats': [
          {
            'base_stat': 35,
            'stat': {'name': 'hp'},
          },
        ],
      });
      final entity = model.toEntity();
      expect(entity.types, ['electric']);
      expect(entity.stats.single.name, 'hp');
      expect(entity.stats.single.baseValue, 35);
    });

    test('toJson/fromJson round-trips', () {
      final model = PokemonDetailModel.fromJson(const {
        'id': 1,
        'name': 'bulbasaur',
        'height': 7,
        'weight': 69,
        'types': [
          {
            'type': {'name': 'grass'},
          },
        ],
        'stats': [
          {
            'base_stat': 45,
            'stat': {'name': 'hp'},
          },
        ],
      });
      final restored = PokemonDetailModel.fromJson(model.toJson());
      expect(restored.name, 'bulbasaur');
      expect(restored.types, ['grass']);
      expect(restored.stats.single.baseValue, 45);
    });
  });
}
