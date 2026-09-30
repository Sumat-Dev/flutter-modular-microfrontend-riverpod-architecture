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

    test('parses enriched fields when present', () {
      final model = PokemonDetailModel.fromJson(const {
        'id': 1,
        'name': 'bulbasaur',
        'base_experience': 64,
        'order': 1,
        'is_default': true,
        'height': 7,
        'weight': 69,
        'abilities': [
          {
            'is_hidden': false,
            'slot': 1,
            'ability': {
              'name': 'overgrow',
              'url': 'https://pokeapi.co/api/v2/ability/65/',
            },
          },
        ],
        'forms': [
          {
            'name': 'bulbasaur',
            'url': 'https://pokeapi.co/api/v2/pokemon-form/1/',
          },
        ],
        'game_indices': [
          {
            'game_index': 153,
            'version': {
              'name': 'red',
              'url': 'https://pokeapi.co/api/v2/version/1/',
            },
          },
        ],
        'held_items': [
          {
            'item': {
              'name': 'oran-berry',
              'url': 'https://pokeapi.co/api/v2/item/132/',
            },
          },
        ],
        'moves': [
          {
            'move': {
              'name': 'razor-wind',
              'url': 'https://pokeapi.co/api/v2/move/13/',
            },
          },
        ],
        'species': {
          'name': 'bulbasaur',
          'url': 'https://pokeapi.co/api/v2/pokemon-species/1/',
        },
        'sprites': {
          'front_default': 'https://example.com/1.png',
        },
        'location_area_encounters':
            'https://pokeapi.co/api/v2/pokemon/1/encounters',
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
      final entity = model.toEntity();
      expect(entity.baseExperience, 64);
      expect(entity.order, 1);
      expect(entity.isDefault, isTrue);
      expect(entity.abilities.single.ability.name, 'overgrow');
      expect(entity.abilities.single.isHidden, isFalse);
      expect(entity.forms.single.name, 'bulbasaur');
      expect(entity.gameIndices.single.gameIndex, 153);
      expect(entity.heldItems.single.item.name, 'oran-berry');
      expect(entity.moves.single.move.name, 'razor-wind');
      expect(entity.species?.name, 'bulbasaur');
      expect(entity.species?.id, 1);
      expect(entity.spriteUrl, 'https://example.com/1.png');
      expect(
        entity.locationAreaEncounters,
        'https://pokeapi.co/api/v2/pokemon/1/encounters',
      );
    });

    test('defaults enriched fields when absent (backward compatible)', () {
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
      expect(entity.baseExperience, isNull);
      expect(entity.order, isNull);
      expect(entity.abilities, isEmpty);
      expect(entity.forms, isEmpty);
      expect(entity.gameIndices, isEmpty);
      expect(entity.heldItems, isEmpty);
      expect(entity.moves, isEmpty);
      expect(entity.species, isNull);
      expect(entity.spriteUrl, isNull);
      expect(entity.locationAreaEncounters, isNull);
    });
  });
}
