import 'package:feature_items/src/data/models/item_detail_model.dart';
import 'package:feature_items/src/data/models/item_model.dart';
import 'package:feature_items/src/domain/entities/item.dart';
import 'package:feature_items/src/domain/entities/item_detail.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ItemModel', () {
    test('fromListJson derives id from url and keeps name', () {
      final model = ItemModel.fromListJson(const {
        'name': 'master-ball',
        'url': 'https://pokeapi.co/api/v2/item/1/',
      });

      expect(model.id, 1);
      expect(model.name, 'master-ball');
    });

    test('fromListJson falls back to id 0 on malformed url', () {
      final model = ItemModel.fromListJson(const {
        'name': 'master-ball',
        'url': 'https://pokeapi.co/api/v2/item/x/',
      });

      expect(model.id, 0);
    });

    test('fromJson / toJson round-trips', () {
      final model = ItemModel.fromJson(const {'id': 4, 'name': 'potion'});

      expect(model.id, 4);
      expect(model.name, 'potion');
      expect(model.toJson(), {'id': 4, 'name': 'potion'});
    });

    test('fromCacheJson behaves like fromJson', () {
      final model = ItemModel.fromCacheJson(const {'id': 7, 'name': 'elixir'});
      expect(model.toEntity(), const Item(id: 7, name: 'elixir'));
    });
  });

  group('ItemDetailModel', () {
    final detailJson = <String, dynamic>{
      'id': 1,
      'name': 'master-ball',
      'cost': 0,
      'category': {'name': 'standard-balls'},
      'attributes': [
        {'name': 'holdable'},
        {'name': 'countable'},
      ],
      'effect_entries': [
        {
          'short_effect': 'Catches a Pokémon every time.',
          'effect': 'long effect',
          'language': {'name': 'en'},
        },
      ],
      'fling_power': 10,
      'sprites': {'default': 'https://img/master-ball.png'},
    };

    test('fromJson parses category, attributes, english effect, sprite', () {
      final model = ItemDetailModel.fromJson(detailJson);

      expect(model.id, 1);
      expect(model.name, 'master-ball');
      expect(model.cost, 0);
      expect(model.category, 'standard-balls');
      expect(model.attributes, ['holdable', 'countable']);
      expect(model.effect, 'Catches a Pokémon every time.');
      expect(model.flingPower, 10);
      expect(model.spriteUrl, 'https://img/master-ball.png');
    });

    test('effect falls back to empty when no entries', () {
      final json = Map<String, dynamic>.from(detailJson)
        ..['effect_entries'] = <dynamic>[];
      final model = ItemDetailModel.fromJson(json);
      expect(model.effect, '');
    });

    test(
      'toJson serialises category and attributes back to resource shape',
      () {
        final model = ItemDetailModel.fromJson(detailJson);
        final json = model.toJson();

        expect(json['category'], {'name': 'standard-balls'});
        expect(json['attributes'], [
          {'name': 'holdable'},
          {'name': 'countable'},
        ]);
        expect(json['sprites'], {'default': 'https://img/master-ball.png'});
      },
    );

    test('toEntity maps to ItemDetail', () {
      final entity = ItemDetailModel.fromJson(detailJson).toEntity();

      expect(
        entity,
        const ItemDetail(
          id: 1,
          name: 'master-ball',
          cost: 0,
          category: 'standard-balls',
          attributes: ['holdable', 'countable'],
          effect: 'Catches a Pokémon every time.',
          flingPower: 10,
          spriteUrl: 'https://img/master-ball.png',
        ),
      );
    });
  });
}
