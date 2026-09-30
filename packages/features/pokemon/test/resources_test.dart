import 'package:core/core.dart';
import 'package:feature_pokemon/src/data/datasources/resource_list_remote_data_source.dart';
import 'package:feature_pokemon/src/data/models/ability_model.dart';
import 'package:feature_pokemon/src/data/models/common/named_api_resource_model.dart';
import 'package:feature_pokemon/src/data/models/pokemon_species_model.dart';
import 'package:feature_pokemon/src/data/repositories/ability_repository_impl.dart';
import 'package:feature_pokemon/src/data/repositories/resource_list_repository_impl.dart';
import 'package:feature_pokemon/src/domain/entities/ability.dart';
import 'package:feature_pokemon/src/domain/entities/common/named_api_resource.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network/network.dart';

class _MockApiClient extends Mock implements ApiClient {}

void main() {
  group('NamedApiResourceModel', () {
    test('parses and derives id from url', () {
      final model = NamedApiResourceModel.fromJson(const {
        'name': 'stench',
        'url': 'https://pokeapi.co/api/v2/ability/1/',
      });
      final entity = model.toEntity();
      expect(entity.name, 'stench');
      expect(entity.id, 1);
    });
  });

  group('AbilityModel', () {
    test('parses names/effects/pokemon and maps to entity', () {
      final model = AbilityModel.fromJson(const {
        'id': 1,
        'name': 'stench',
        'is_main_series': true,
        'generation': {
          'name': 'generation-iii',
          'url': 'https://pokeapi.co/api/v2/generation/3/',
        },
        'names': [
          {
            'name': 'Stench',
            'language': {
              'name': 'en',
              'url': 'https://pokeapi.co/api/v2/language/9/',
            },
          },
        ],
        'effect_entries': [
          {
            'effect': 'long effect',
            'short_effect': 'short effect',
            'language': {
              'name': 'en',
              'url': 'https://pokeapi.co/api/v2/language/9/',
            },
          },
        ],
        'pokemon': [
          {
            'is_hidden': true,
            'slot': 3,
            'pokemon': {
              'name': 'gloom',
              'url': 'https://pokeapi.co/api/v2/pokemon/44/',
            },
          },
        ],
      });
      final entity = model.toEntity();
      expect(entity.displayName, 'Stench');
      expect(entity.isMainSeries, isTrue);
      expect(entity.generation?.name, 'generation-iii');
      expect(entity.shortEffect, 'short effect');
      expect(entity.pokemon.single.pokemon.name, 'gloom');
      expect(entity.pokemon.single.isHidden, isTrue);
    });
  });

  group('PokemonSpeciesModel', () {
    test('parses rich fields, English genera and flavor text', () {
      final model = PokemonSpeciesModel.fromJson(const {
        'id': 1,
        'name': 'bulbasaur',
        'order': 1,
        'gender_rate': 1,
        'capture_rate': 45,
        'base_happiness': 70,
        'is_baby': false,
        'is_legendary': false,
        'is_mythical': false,
        'hatch_counter': 20,
        'has_gender_differences': false,
        'forms_switchable': false,
        'growth_rate': {
          'name': 'medium-slow',
          'url': 'https://pokeapi.co/api/v2/growth-rate/4/',
        },
        'egg_groups': [
          {
            'name': 'monster',
            'url': 'https://pokeapi.co/api/v2/egg-group/1/',
          },
        ],
        'evolution_chain': {
          'url': 'https://pokeapi.co/api/v2/evolution-chain/1/',
        },
        'genera': [
          {
            'genus': 'Seed Pokémon',
            'language': {
              'name': 'en',
              'url': 'https://pokeapi.co/api/v2/language/9/',
            },
          },
          {
            'genus': 'たねポケモン',
            'language': {
              'name': 'ja',
              'url': 'https://pokeapi.co/api/v2/language/11/',
            },
          },
        ],
        'flavor_text_entries': [
          {
            'flavor_text': 'A strange seed was planted on its back.',
            'language': {
              'name': 'en',
              'url': 'https://pokeapi.co/api/v2/language/9/',
            },
          },
        ],
      });
      final entity = model.toEntity();
      expect(entity.captureRate, 45);
      expect(entity.growthRate?.name, 'medium-slow');
      expect(entity.evolutionChain?.id, 1);
      expect(entity.eggGroups.single.name, 'monster');
      expect(entity.genera, ['Seed Pokémon']);
      expect(entity.flavorText, contains('strange seed'));
    });
  });

  group('ResourceListRepositoryImpl', () {
    late _MockApiClient client;
    late ResourceListRepositoryImpl repo;

    setUp(() {
      client = _MockApiClient();
      repo = ResourceListRepositoryImpl(ResourceListRemoteDataSource(client));
    });

    test('maps standard list into PaginatedResult<NamedApiResource>', () async {
      when(
        () => client.get<DataMap>(
          'ability',
          queryParameters: any(named: 'queryParameters'),
        ),
      ).thenAnswer(
        (_) async => {
          'count': 2,
          'next': 'next-url',
          'previous': null,
          'results': [
            {
              'name': 'stench',
              'url': 'https://pokeapi.co/api/v2/ability/1/',
            },
            {
              'name': 'drizzle',
              'url': 'https://pokeapi.co/api/v2/ability/2/',
            },
          ],
        },
      );

      final result = await repo.getList(
        path: 'ability',
        page: const PageRequest(),
      );

      expect(result.isRight(), isTrue);
      final page = (result as Right).value as PaginatedResult<NamedApiResource>;
      expect(page.count, 2);
      expect(page.items.first.name, 'stench');
      expect(page.items.first.id, 1);
    });

    test(
      'returns NetworkFailure when client throws NetworkException',
      () async {
        when(
          () => client.get<DataMap>(
            'ability',
            queryParameters: any(named: 'queryParameters'),
          ),
        ).thenThrow(const NetworkException(message: 'offline'));

        final result = await repo.getList(
          path: 'ability',
          page: const PageRequest(),
        );

        expect(result.isLeft(), isTrue);
        expect((result as Left).value, isA<NetworkFailure>());
      },
    );
  });

  group('AbilityRepositoryImpl', () {
    late _MockApiClient client;
    late AbilityRepositoryImpl repo;

    setUp(() {
      client = _MockApiClient();
      repo = AbilityRepositoryImpl(ResourceListRemoteDataSource(client));
    });

    test('fetches detail and maps to entity', () async {
      when(() => client.get<DataMap>('ability/stench')).thenAnswer(
        (_) async => const {
          'id': 1,
          'name': 'stench',
          'is_main_series': true,
          'names': <dynamic>[],
          'effect_entries': <dynamic>[],
          'pokemon': <dynamic>[],
        },
      );

      final result = await repo.getAbility('stench');

      expect(result.isRight(), isTrue);
      expect(((result as Right).value as Ability).name, 'stench');
    });

    test('returns ServerFailure on server exception', () async {
      when(
        () => client.get<DataMap>('ability/stench'),
      ).thenThrow(const ServerException(message: '500', statusCode: 500));

      final result = await repo.getAbility('stench');

      expect(result.isLeft(), isTrue);
      expect((result as Left).value, isA<ServerFailure>());
    });
  });
}
