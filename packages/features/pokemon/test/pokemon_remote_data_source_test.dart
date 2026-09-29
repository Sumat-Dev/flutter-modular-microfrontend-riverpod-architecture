import 'package:core/core.dart';
import 'package:feature_pokemon/src/data/datasources/pokemon_remote_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network/network.dart';

class _MockApiClient extends Mock implements ApiClient {}

void main() {
  late _MockApiClient client;
  late PokemonRemoteDataSourceImpl ds;

  setUp(() {
    client = _MockApiClient();
    ds = PokemonRemoteDataSourceImpl(client);
  });

  group('fetchPokemonList', () {
    test('parses paging metadata and maps items', () async {
      when(
        () => client.get<DataMap>('pokemon', queryParameters: any(named: 'queryParameters')),
      ).thenAnswer(
        (_) async => {
          'count': 2,
          'next': 'next-url',
          'previous': null,
          'results': [
            {'name': 'bulbasaur', 'url': 'https://pokeapi.co/api/v2/pokemon/1/'},
            {'name': 'ivysaur', 'url': 'https://pokeapi.co/api/v2/pokemon/2/'},
          ],
        },
      );

      final result = await ds.fetchPokemonList(offset: 0, limit: 20);

      expect(result.count, 2);
      expect(result.next, 'next-url');
      expect(result.previous, isNull);
      expect(result.items.map((e) => e.name), ['bulbasaur', 'ivysaur']);
      expect(result.items.first.id, 1);
    });

    test('throws ParsingException on malformed payload', () async {
      when(
        () => client.get<DataMap>('pokemon', queryParameters: any(named: 'queryParameters')),
      ).thenAnswer(
        (_) async => {
          'count': 'not-an-int',
          'results': <dynamic>[],
        },
      );

      expect(
        () => ds.fetchPokemonList(offset: 0, limit: 20),
        throwsA(isA<ParsingException>()),
      );
    });

    test('propagates transport exceptions from client', () async {
      when(
        () => client.get<DataMap>('pokemon', queryParameters: any(named: 'queryParameters')),
      ).thenThrow(const NetworkException(message: 'offline'));

      expect(
        () => ds.fetchPokemonList(offset: 0, limit: 20),
        throwsA(isA<NetworkException>()),
      );
    });
  });

  group('fetchPokemon', () {
    test('parses detail json into model', () async {
      when(() => client.get<DataMap>('pokemon/pikachu')).thenAnswer(
        (_) async => const {
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
        },
      );

      final model = await ds.fetchPokemon('pikachu');

      expect(model.id, 25);
      expect(model.name, 'pikachu');
      expect(model.types, ['electric']);
      expect(model.stats.single.baseValue, 35);
    });

    test('throws ParsingException on malformed detail json', () async {
      when(
        () => client.get<DataMap>('pokemon/bad'),
      ).thenAnswer((_) async => const {'name': 'bad'});

      expect(
        () => ds.fetchPokemon('bad'),
        throwsA(isA<ParsingException>()),
      );
    });

    test('propagates server exception from client', () async {
      when(
        () => client.get<DataMap>('pokemon/pikachu'),
      ).thenThrow(const ServerException(message: '500', statusCode: 500));

      expect(
        () => ds.fetchPokemon('pikachu'),
        throwsA(isA<ServerException>()),
      );
    });
  });
}
