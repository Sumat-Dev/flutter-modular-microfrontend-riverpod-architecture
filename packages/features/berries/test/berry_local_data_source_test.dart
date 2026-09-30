import 'package:core/core.dart';
import 'package:feature_berries/src/data/datasources/berry_local_data_source.dart';
import 'package:feature_berries/src/data/models/berry_detail_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:storage/storage.dart';

class _MockStore extends Mock implements KeyValueStore {}

DataMap _detailJson() => const {
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

void main() {
  late _MockStore store;
  late BerryLocalDataSourceImpl ds;

  setUp(() {
    store = _MockStore();
    ds = BerryLocalDataSourceImpl(store);
  });

  group('readBerry', () {
    test('returns null on cache miss', () async {
      when(
        () => store.read('berry_detail_cheri'),
      ).thenAnswer((_) async => null);

      expect(await ds.readBerry('cheri'), isNull);
    });

    test('returns model on cache hit', () async {
      when(
        () => store.read('berry_detail_cheri'),
      ).thenAnswer((_) async => _detailJson());

      final model = await ds.readBerry('cheri');

      expect(model, isNotNull);
      expect(model!.name, 'cheri');
      expect(model.firmness, 'soft');
    });

    test('throws CacheException on corrupt cache', () async {
      when(
        () => store.read('berry_detail_cheri'),
      ).thenAnswer((_) async => const {'name': 'cheri'});

      expect(
        () => ds.readBerry('cheri'),
        throwsA(isA<CacheException>()),
      );
    });
  });

  group('writeBerry', () {
    test('writes model json under keyed name', () async {
      when(() => store.write(any(), any())).thenAnswer((_) async {});
      final model = BerryDetailModel.fromJson(_detailJson());

      await ds.writeBerry(model);

      verify(
        () => store.write('berry_detail_cheri', model.toJson()),
      ).called(1);
    });
  });
}
