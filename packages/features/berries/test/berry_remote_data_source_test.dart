import 'package:core/core.dart';
import 'package:feature_berries/src/data/datasources/berry_remote_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network/network.dart';

class _MockApiClient extends Mock implements ApiClient {}

void main() {
  late _MockApiClient client;
  late BerryRemoteDataSourceImpl ds;

  setUp(() {
    client = _MockApiClient();
    ds = BerryRemoteDataSourceImpl(client);
  });

  group('fetchBerryList', () {
    test('parses paging metadata and maps items', () async {
      when(
        () => client.get<DataMap>(
          'berry',
          queryParameters: any(named: 'queryParameters'),
        ),
      ).thenAnswer(
        (_) async => {
          'count': 2,
          'next': 'next-url',
          'previous': null,
          'results': [
            {'name': 'cheri', 'url': 'https://pokeapi.co/api/v2/berry/1/'},
            {'name': 'chesto', 'url': 'https://pokeapi.co/api/v2/berry/2/'},
          ],
        },
      );

      final result = await ds.fetchBerryList(offset: 0, limit: 20);

      expect(result.count, 2);
      expect(result.next, 'next-url');
      expect(result.previous, isNull);
      expect(result.items.map((e) => e.name), ['cheri', 'chesto']);
      expect(result.items.first.id, 1);
    });

    test('throws ParsingException on malformed payload', () async {
      when(
        () => client.get<DataMap>(
          'berry',
          queryParameters: any(named: 'queryParameters'),
        ),
      ).thenAnswer(
        (_) async => {
          'count': 'not-an-int',
          'results': <dynamic>[],
        },
      );

      expect(
        () => ds.fetchBerryList(offset: 0, limit: 20),
        throwsA(isA<ParsingException>()),
      );
    });

    test('propagates transport exceptions from client', () async {
      when(
        () => client.get<DataMap>(
          'berry',
          queryParameters: any(named: 'queryParameters'),
        ),
      ).thenThrow(const NetworkException(message: 'offline'));

      expect(
        () => ds.fetchBerryList(offset: 0, limit: 20),
        throwsA(isA<NetworkException>()),
      );
    });
  });

  group('fetchBerry', () {
    test('parses detail json into model', () async {
      when(() => client.get<DataMap>('berry/cheri')).thenAnswer(
        (_) async => const {
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
        },
      );

      final model = await ds.fetchBerry('cheri');

      expect(model.id, 1);
      expect(model.name, 'cheri');
      expect(model.firmness, 'soft');
      expect(model.flavors.single.flavor, 'spicy');
    });

    test('throws ParsingException on malformed detail json', () async {
      when(
        () => client.get<DataMap>('berry/bad'),
      ).thenAnswer((_) async => const {'name': 'bad'});

      expect(
        () => ds.fetchBerry('bad'),
        throwsA(isA<ParsingException>()),
      );
    });

    test('propagates server exception from client', () async {
      when(
        () => client.get<DataMap>('berry/cheri'),
      ).thenThrow(const ServerException(message: '500', statusCode: 500));

      expect(
        () => ds.fetchBerry('cheri'),
        throwsA(isA<ServerException>()),
      );
    });
  });
}
