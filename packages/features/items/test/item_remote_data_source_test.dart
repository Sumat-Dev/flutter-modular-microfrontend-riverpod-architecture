import 'package:core/core.dart';
import 'package:feature_items/src/data/datasources/item_remote_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network/network.dart';

class _MockApiClient extends Mock implements ApiClient {}

void main() {
  late _MockApiClient client;
  late ItemRemoteDataSourceImpl ds;

  setUp(() {
    client = _MockApiClient();
    ds = ItemRemoteDataSourceImpl(client);
  });

  group('fetchItemList', () {
    test('parses paging metadata and maps items', () async {
      when(
        () => client.get<DataMap>(
          'item',
          queryParameters: any(named: 'queryParameters'),
        ),
      ).thenAnswer(
        (_) async => {
          'count': 2,
          'next': 'next-url',
          'previous': null,
          'results': [
            {'name': 'master-ball', 'url': 'https://pokeapi.co/api/v2/item/1/'},
            {'name': 'potion', 'url': 'https://pokeapi.co/api/v2/item/17/'},
          ],
        },
      );

      final result = await ds.fetchItemList(offset: 0, limit: 20);

      expect(result.count, 2);
      expect(result.next, 'next-url');
      expect(result.previous, isNull);
      expect(result.items.map((e) => e.name), ['master-ball', 'potion']);
      expect(result.items.first.id, 1);
    });

    test('throws ParsingException on malformed payload', () async {
      when(
        () => client.get<DataMap>(
          'item',
          queryParameters: any(named: 'queryParameters'),
        ),
      ).thenAnswer(
        (_) async => {
          'count': 'not-an-int',
          'results': <dynamic>[],
        },
      );

      expect(
        () => ds.fetchItemList(offset: 0, limit: 20),
        throwsA(isA<ParsingException>()),
      );
    });

    test('propagates transport exceptions from client', () async {
      when(
        () => client.get<DataMap>(
          'item',
          queryParameters: any(named: 'queryParameters'),
        ),
      ).thenThrow(const NetworkException(message: 'offline'));

      expect(
        () => ds.fetchItemList(offset: 0, limit: 20),
        throwsA(isA<NetworkException>()),
      );
    });
  });

  group('fetchItem', () {
    test('parses detail json into model', () async {
      when(() => client.get<DataMap>('item/master-ball')).thenAnswer(
        (_) async => const {
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
          'fling_power': null,
          'sprites': {'default': 'https://img/mb.png'},
        },
      );

      final model = await ds.fetchItem('master-ball');

      expect(model.id, 1);
      expect(model.name, 'master-ball');
      expect(model.category, 'standard-balls');
      expect(model.effect, 'Always catches.');
    });

    test('throws ParsingException on malformed detail json', () async {
      when(
        () => client.get<DataMap>('item/bad'),
      ).thenAnswer((_) async => const {'name': 'bad'});

      expect(
        () => ds.fetchItem('bad'),
        throwsA(isA<ParsingException>()),
      );
    });

    test('propagates server exception from client', () async {
      when(
        () => client.get<DataMap>('item/master-ball'),
      ).thenThrow(const ServerException(message: '500', statusCode: 500));

      expect(
        () => ds.fetchItem('master-ball'),
        throwsA(isA<ServerException>()),
      );
    });
  });
}
