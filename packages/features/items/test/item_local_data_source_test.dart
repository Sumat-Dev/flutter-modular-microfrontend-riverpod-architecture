import 'package:core/core.dart';
import 'package:feature_items/src/data/datasources/item_local_data_source.dart';
import 'package:feature_items/src/data/models/item_detail_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:storage/storage.dart';

class _MockStore extends Mock implements KeyValueStore {}

DataMap _detailJson() => const {
  'id': 1,
  'name': 'master-ball',
  'cost': 0,
  'category': {'name': 'standard-balls'},
  'attributes': [
    {'name': 'holdable'},
  ],
  'effect_entries': [
    {
      'short_effect': 'Always catches.',
      'language': {'name': 'en'},
    },
  ],
  'sprites': {'default': 'https://img/mb.png'},
};

void main() {
  late _MockStore store;
  late ItemLocalDataSourceImpl ds;

  setUp(() {
    store = _MockStore();
    ds = ItemLocalDataSourceImpl(store);
  });

  group('readItem', () {
    test('returns null on cache miss', () async {
      when(
        () => store.read('item_detail_master-ball'),
      ).thenAnswer((_) async => null);

      expect(await ds.readItem('master-ball'), isNull);
    });

    test('returns model on cache hit', () async {
      when(
        () => store.read('item_detail_master-ball'),
      ).thenAnswer((_) async => _detailJson());

      final model = await ds.readItem('master-ball');

      expect(model, isNotNull);
      expect(model!.name, 'master-ball');
      expect(model.category, 'standard-balls');
    });

    test('throws CacheException on corrupt cache', () async {
      when(
        () => store.read('item_detail_master-ball'),
      ).thenAnswer((_) async => const {'name': 'master-ball'});

      expect(
        () => ds.readItem('master-ball'),
        throwsA(isA<CacheException>()),
      );
    });
  });

  group('writeItem', () {
    test('writes model json under keyed name', () async {
      when(() => store.write(any(), any())).thenAnswer((_) async {});
      final model = ItemDetailModel.fromJson(_detailJson());

      await ds.writeItem(model);

      verify(
        () => store.write('item_detail_master-ball', model.toJson()),
      ).called(1);
    });
  });
}
