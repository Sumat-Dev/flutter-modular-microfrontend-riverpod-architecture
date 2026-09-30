import 'package:feature_berries/src/data/models/berry_detail_model.dart';
import 'package:feature_berries/src/data/models/berry_model.dart';
import 'package:feature_berries/src/domain/entities/berry.dart';
import 'package:feature_berries/src/domain/entities/berry_detail.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('BerryModel', () {
    test('fromListJson derives id from url and keeps name', () {
      final model = BerryModel.fromListJson(const {
        'name': 'cheri',
        'url': 'https://pokeapi.co/api/v2/berry/1/',
      });

      expect(model.id, 1);
      expect(model.name, 'cheri');
    });

    test('fromListJson falls back to id 0 on malformed url', () {
      final model = BerryModel.fromListJson(const {
        'name': 'cheri',
        'url': 'https://pokeapi.co/api/v2/berry/not-a-number/',
      });

      expect(model.id, 0);
    });

    test('fromJson / toJson round-trips', () {
      final model = BerryModel.fromJson(const {'id': 5, 'name': 'pecha'});

      expect(model.id, 5);
      expect(model.name, 'pecha');
      expect(model.toJson(), {'id': 5, 'name': 'pecha'});
    });

    test('toEntity maps to Berry', () {
      const model = BerryModel(id: 2, name: 'chesto');

      expect(model.toEntity(), const Berry(id: 2, name: 'chesto'));
    });
  });

  group('BerryDetailModel', () {
    final detailJson = <String, dynamic>{
      'id': 1,
      'name': 'cheri',
      'growth_time': 3,
      'max_harvest': 5,
      'natural_gift_power': 60,
      'size': 20,
      'smoothness': 25,
      'soil_dryness': 15,
      'firmness': {'name': 'soft'},
      'natural_gift_type': {'name': 'fire'},
      'flavors': [
        {
          'flavor': {'name': 'spicy'},
          'potency': 10,
        },
      ],
    };

    test('fromJson parses nested resource names', () {
      final model = BerryDetailModel.fromJson(detailJson);

      expect(model.id, 1);
      expect(model.name, 'cheri');
      expect(model.growthTime, 3);
      expect(model.maxHarvest, 5);
      expect(model.naturalGiftPower, 60);
      expect(model.firmness, 'soft');
      expect(model.naturalGiftType, 'fire');
      expect(model.flavors.single.flavor, 'spicy');
      expect(model.flavors.single.potency, 10);
    });

    test('toJson serialises resource names back to {name: ...}', () {
      final model = BerryDetailModel.fromJson(detailJson);
      final json = model.toJson();

      expect(json['firmness'], {'name': 'soft'});
      expect(json['natural_gift_type'], {'name': 'fire'});
      expect((json['flavors'] as List).first, {
        'flavor': {'name': 'spicy'},
        'potency': 10,
      });
    });

    test('toEntity maps to BerryDetail with flavors', () {
      final model = BerryDetailModel.fromJson(detailJson);
      final entity = model.toEntity();

      expect(entity.id, 1);
      expect(entity.name, 'cheri');
      expect(entity.firmness, 'soft');
      expect(entity.naturalGiftType, 'fire');
      expect(
        entity.flavors,
        const [BerryFlavor(flavor: 'spicy', potency: 10)],
      );
    });
  });
}
