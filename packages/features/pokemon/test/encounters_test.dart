import 'package:core/core.dart';
import 'package:feature_pokemon/src/data/datasources/encounter_remote_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network/network.dart';

class _MockApiClient extends Mock implements ApiClient {}

void main() {
  late _MockApiClient client;
  late EncounterRemoteDataSourceImpl ds;

  setUp(() {
    client = _MockApiClient();
    ds = EncounterRemoteDataSourceImpl(client);
  });

  test('parses bare encounters array into models', () async {
    when(
      () => client.get<List<dynamic>>('pokemon/pikachu/encounters'),
    ).thenAnswer(
      (_) async => [
        {
          'location_area': {
            'name': 'cerulean-city-area',
            'url': 'https://pokeapi.co/api/v2/location-area/281/',
          },
          'version_details': [
            {
              'max_chance': 100,
              'version': {
                'name': 'yellow',
                'url': 'https://pokeapi.co/api/v2/version/3/',
              },
              'encounter_details': [
                {
                  'chance': 100,
                  'max_level': 10,
                  'min_level': 10,
                  'condition_values': <dynamic>[],
                  'method': {
                    'name': 'gift',
                    'url': 'https://pokeapi.co/api/v2/encounter-method/18/',
                  },
                },
              ],
            },
          ],
        },
      ],
    );

    final models = await ds.fetchEncounters('pikachu');

    expect(models, hasLength(1));
    final entity = models.single.toEntity();
    expect(entity.locationArea.name, 'cerulean-city-area');
    expect(entity.versionDetails.single.version.name, 'yellow');
    expect(entity.versionDetails.single.maxChance, 100);
    expect(entity.versionDetails.single.encounterDetails.single.chance, 100);
    expect(
      entity.versionDetails.single.encounterDetails.single.method.name,
      'gift',
    );
  });

  test('throws ParsingException on malformed payload', () async {
    when(
      () => client.get<List<dynamic>>('pokemon/bad/encounters'),
    ).thenAnswer((_) async => [<String, dynamic>{}]);

    expect(
      () => ds.fetchEncounters('bad'),
      throwsA(isA<ParsingException>()),
    );
  });
}
