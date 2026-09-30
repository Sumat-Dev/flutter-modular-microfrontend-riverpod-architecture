import 'package:core/core.dart';
import 'package:feature_pokemon/src/data/datasources/resource_list_remote_data_source.dart';
import 'package:feature_pokemon/src/data/models/common/named_api_resource_model.dart';
import 'package:feature_pokemon/src/data/repositories/ability_repository_impl.dart';
import 'package:feature_pokemon/src/data/repositories/characteristic_repository_impl.dart';
import 'package:feature_pokemon/src/data/repositories/egg_group_repository_impl.dart';
import 'package:feature_pokemon/src/data/repositories/gender_repository_impl.dart';
import 'package:feature_pokemon/src/data/repositories/growth_rate_repository_impl.dart';
import 'package:feature_pokemon/src/data/repositories/nature_repository_impl.dart';
import 'package:feature_pokemon/src/data/repositories/pokeathlon_stat_repository_impl.dart';
import 'package:feature_pokemon/src/data/repositories/pokemon_color_repository_impl.dart';
import 'package:feature_pokemon/src/data/repositories/pokemon_form_repository_impl.dart';
import 'package:feature_pokemon/src/data/repositories/pokemon_habitat_repository_impl.dart';
import 'package:feature_pokemon/src/data/repositories/pokemon_shape_repository_impl.dart';
import 'package:feature_pokemon/src/data/repositories/pokemon_species_repository_impl.dart';
import 'package:feature_pokemon/src/data/repositories/pokemon_type_repository_impl.dart';
import 'package:feature_pokemon/src/data/repositories/resource_list_repository_impl.dart';
import 'package:feature_pokemon/src/data/repositories/stat_repository_impl.dart';
import 'package:feature_pokemon/src/domain/entities/ability.dart';
import 'package:feature_pokemon/src/domain/entities/characteristic.dart';
import 'package:feature_pokemon/src/domain/entities/common/named_api_resource.dart';
import 'package:feature_pokemon/src/domain/entities/egg_group.dart';
import 'package:feature_pokemon/src/domain/entities/gender.dart';
import 'package:feature_pokemon/src/domain/entities/growth_rate.dart';
import 'package:feature_pokemon/src/domain/entities/nature.dart';
import 'package:feature_pokemon/src/domain/entities/pokeathlon_stat.dart';
import 'package:feature_pokemon/src/domain/entities/pokemon_color.dart';
import 'package:feature_pokemon/src/domain/entities/pokemon_form.dart';
import 'package:feature_pokemon/src/domain/entities/pokemon_habitat.dart';
import 'package:feature_pokemon/src/domain/entities/pokemon_shape.dart';
import 'package:feature_pokemon/src/domain/entities/pokemon_species.dart';
import 'package:feature_pokemon/src/domain/entities/pokemon_type.dart';
import 'package:feature_pokemon/src/domain/entities/stat.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockRemote extends Mock implements ResourceListRemoteDataSource {}

/// A `{name, language:{name}}` localized entry (English by default).
DataMap _localizedName(String name, {String lang = 'en'}) => {
  'name': name,
  'language': {'name': lang, 'url': ''},
};

DataMap _namedRef(String name) => {'name': name, 'url': 'https://x/$name/1/'};

void main() {
  late _MockRemote remote;

  setUp(() {
    remote = _MockRemote();
  });

  /// Stubs a successful detail fetch for [path]/[idOrName] returning [json].
  void stubDetail(String path, String idOrName, DataMap json) {
    when(
      () => remote.fetchDetail(path: path, idOrName: idOrName),
    ).thenAnswer((_) async => json);
  }

  /// Stubs a detail fetch that throws [error].
  void stubDetailThrows(String path, String idOrName, Object error) {
    when(
      () => remote.fetchDetail(path: path, idOrName: idOrName),
    ).thenThrow(error);
  }

  group('NatureRepositoryImpl', () {
    NatureRepositoryImpl repo() => NatureRepositoryImpl(remote);

    test('maps detail json to entity', () async {
      stubDetail('nature', 'adamant', {
        'id': 3,
        'name': 'adamant',
        'decreased_stat': _namedRef('special-attack'),
        'increased_stat': _namedRef('attack'),
        'hates_flavor': _namedRef('dry'),
        'likes_flavor': _namedRef('spicy'),
        'names': [_localizedName('Adamant')],
        'pokeathlon_stat_changes': [
          {'max_change': 2, 'pokeathlon_stat': _namedRef('power')},
        ],
      });

      final result = await repo().getNature('adamant');

      expect(result.isRight(), isTrue);
      final nature = (result as Right).value as Nature;
      expect(nature.name, 'adamant');
      expect(nature.displayName, 'Adamant');
      expect(nature.increasedStat?.name, 'attack');
      expect(nature.pokeathlonStatChanges.single.maxChange, 2);
    });

    test('maps ServerException to ServerFailure', () async {
      stubDetailThrows(
        'nature',
        'x',
        const ServerException(message: '500', statusCode: 500),
      );
      final result = await repo().getNature('x');
      expect((result as Left).value, isA<ServerFailure>());
    });

    test('maps malformed json to UnexpectedFailure', () async {
      stubDetail('nature', 'bad', {'name': 'bad'});
      final result = await repo().getNature('bad');
      expect((result as Left).value, isA<UnexpectedFailure>());
    });
  });

  group('StatRepositoryImpl', () {
    test('maps detail json to entity', () async {
      stubDetail('stat', 'attack', {
        'id': 2,
        'name': 'attack',
        'game_index': 2,
        'is_battle_only': false,
        'move_damage_class': _namedRef('physical'),
        'names': [_localizedName('Attack')],
      });

      final result = await StatRepositoryImpl(remote).getStat('attack');

      expect(result.isRight(), isTrue);
      final stat = (result as Right).value as Stat;
      expect(stat.name, 'attack');
      expect(stat.gameIndex, 2);
      expect(stat.isBattleOnly, isFalse);
      expect(stat.moveDamageClass?.name, 'physical');
    });

    test('maps NetworkException to NetworkFailure', () async {
      stubDetailThrows(
        'stat',
        'x',
        const NetworkException(message: 'offline'),
      );
      final result = await StatRepositoryImpl(remote).getStat('x');
      expect((result as Left).value, isA<NetworkFailure>());
    });
  });

  group('GenderRepositoryImpl', () {
    test('maps detail json to entity', () async {
      stubDetail('gender', 'female', {
        'id': 1,
        'name': 'female',
        'pokemon_species_details': [
          {'rate': 4, 'pokemon_species': _namedRef('bulbasaur')},
        ],
        'required_for_evolution': [_namedRef('wormadam')],
      });

      final result = await GenderRepositoryImpl(remote).getGender('female');

      expect(result.isRight(), isTrue);
      final gender = (result as Right).value as Gender;
      expect(gender.name, 'female');
      expect(gender.pokemonSpeciesDetails.single.rate, 4);
      expect(gender.requiredForEvolution.single.name, 'wormadam');
    });
  });

  group('GrowthRateRepositoryImpl', () {
    test('maps detail json to entity and picks english description', () async {
      stubDetail('growth-rate', 'medium', {
        'id': 2,
        'name': 'medium',
        'formula': 'n^3',
        'descriptions': [
          {
            'description': 'Medium growth',
            'language': {'name': 'en', 'url': ''},
          },
        ],
        'levels': [
          {'level': 1, 'experience': 0},
        ],
        'pokemon_species': [_namedRef('bulbasaur')],
      });

      final result = await GrowthRateRepositoryImpl(
        remote,
      ).getGrowthRate('medium');

      expect(result.isRight(), isTrue);
      final gr = (result as Right).value as GrowthRate;
      expect(gr.formula, 'n^3');
      expect(gr.description, 'Medium growth');
      expect(gr.levels.single.experience, 0);
    });
  });

  group('EggGroupRepositoryImpl', () {
    test('maps detail json to entity', () async {
      stubDetail('egg-group', 'monster', {
        'id': 1,
        'name': 'monster',
        'names': [_localizedName('Monster')],
        'pokemon_species': [_namedRef('bulbasaur')],
      });

      final result = await EggGroupRepositoryImpl(
        remote,
      ).getEggGroup('monster');

      expect(result.isRight(), isTrue);
      expect(((result as Right).value as EggGroup).displayName, 'Monster');
    });
  });

  group('PokemonShapeRepositoryImpl', () {
    test('maps detail json to entity', () async {
      stubDetail('pokemon-shape', 'ball', {
        'id': 1,
        'name': 'ball',
        'names': [_localizedName('Ball')],
        'awesome_names': [
          {'awesome_name': 'Pomaceous', 'language': _namedRef('en')},
        ],
        'pokemon_species': [_namedRef('voltorb')],
      });

      final result = await PokemonShapeRepositoryImpl(
        remote,
      ).getPokemonShape('ball');

      expect(result.isRight(), isTrue);
      final shape = (result as Right).value as PokemonShape;
      expect(shape.displayName, 'Ball');
      expect(shape.awesomeNames.single.awesomeName, 'Pomaceous');
    });
  });

  group('PokemonColorRepositoryImpl', () {
    test('maps detail json to entity', () async {
      stubDetail('pokemon-color', 'red', {
        'id': 1,
        'name': 'red',
        'names': [_localizedName('Red')],
        'pokemon_species': [_namedRef('charmander')],
      });

      final result = await PokemonColorRepositoryImpl(
        remote,
      ).getPokemonColor('red');

      expect(result.isRight(), isTrue);
      expect(((result as Right).value as PokemonColor).displayName, 'Red');
    });
  });

  group('PokemonHabitatRepositoryImpl', () {
    test('maps detail json to entity', () async {
      stubDetail('pokemon-habitat', 'cave', {
        'id': 1,
        'name': 'cave',
        'names': [_localizedName('Cave')],
        'pokemon_species': [_namedRef('zubat')],
      });

      final result = await PokemonHabitatRepositoryImpl(
        remote,
      ).getPokemonHabitat('cave');

      expect(result.isRight(), isTrue);
      expect(((result as Right).value as PokemonHabitat).displayName, 'Cave');
    });
  });

  group('PokeathlonStatRepositoryImpl', () {
    test('maps detail json to entity', () async {
      stubDetail('pokeathlon-stat', 'power', {
        'id': 1,
        'name': 'power',
        'names': [_localizedName('Power')],
      });

      final result = await PokeathlonStatRepositoryImpl(
        remote,
      ).getPokeathlonStat('power');

      expect(result.isRight(), isTrue);
      expect(((result as Right).value as PokeathlonStat).displayName, 'Power');
    });
  });

  group('PokemonTypeRepositoryImpl', () {
    test('maps detail json to entity', () async {
      stubDetail('type', 'fire', {
        'id': 10,
        'name': 'fire',
        'damage_relations': {
          'no_damage_to': <dynamic>[],
          'half_damage_to': [_namedRef('water')],
          'double_damage_to': [_namedRef('grass')],
          'no_damage_from': <dynamic>[],
          'half_damage_from': [_namedRef('fire')],
          'double_damage_from': [_namedRef('water')],
        },
        'generation': _namedRef('generation-i'),
        'move_damage_class': _namedRef('special'),
        'names': [_localizedName('Fire')],
        'pokemon': [
          {'slot': 1, 'pokemon': _namedRef('charmander')},
        ],
      });

      final result = await PokemonTypeRepositoryImpl(
        remote,
      ).getPokemonType('fire');

      expect(result.isRight(), isTrue);
      final type = (result as Right).value as PokemonType;
      expect(type.displayName, 'Fire');
      expect(type.damageRelations.doubleDamageTo.single.name, 'grass');
      expect(type.pokemon.single.name, 'charmander');
    });
  });

  group('PokemonFormRepositoryImpl', () {
    test('maps detail json to entity including sprites and types', () async {
      stubDetail('pokemon-form', 'charizard-mega-x', {
        'id': 10034,
        'name': 'charizard-mega-x',
        'order': 1,
        'form_order': 2,
        'is_default': false,
        'is_battle_only': true,
        'is_mega': true,
        'form_name': 'mega-x',
        'pokemon': _namedRef('charizard'),
        'types': [
          {
            'type': {'name': 'fire'},
          },
          {
            'type': {'name': 'dragon'},
          },
        ],
        'sprites': {'front_default': 'https://img/charizard.png'},
      });

      final result = await PokemonFormRepositoryImpl(
        remote,
      ).getPokemonForm('charizard-mega-x');

      expect(result.isRight(), isTrue);
      final form = (result as Right).value as PokemonForm;
      expect(form.isMega, isTrue);
      expect(form.types, ['fire', 'dragon']);
      expect(form.spriteUrl, 'https://img/charizard.png');
      expect(form.pokemon?.name, 'charizard');
    });
  });

  group('CharacteristicRepositoryImpl', () {
    test('maps detail json to entity by numeric id', () async {
      stubDetail('characteristic', '1', {
        'id': 1,
        'gene_modulo': 0,
        'possible_values': [0, 5, 10],
        'highest_stat': _namedRef('hp'),
        'descriptions': [
          {
            'description': 'Loves to eat',
            'language': {'name': 'en', 'url': ''},
          },
        ],
      });

      final result = await CharacteristicRepositoryImpl(
        remote,
      ).getCharacteristic(1);

      expect(result.isRight(), isTrue);
      final ch = (result as Right).value as Characteristic;
      expect(ch.geneModulo, 0);
      expect(ch.possibleValues, [0, 5, 10]);
      expect(ch.highestStat.name, 'hp');
      expect(ch.description, 'Loves to eat');
    });

    test('maps error to failure', () async {
      stubDetailThrows(
        'characteristic',
        '99',
        const ServerException(message: '404', statusCode: 404),
      );
      final result = await CharacteristicRepositoryImpl(
        remote,
      ).getCharacteristic(99);
      expect((result as Left).value, isA<ServerFailure>());
    });
  });

  group('AbilityRepositoryImpl', () {
    test('maps detail json to entity picking english effect', () async {
      stubDetail('ability', 'blaze', {
        'id': 66,
        'name': 'blaze',
        'is_main_series': true,
        'generation': _namedRef('generation-iii'),
        'names': [_localizedName('Blaze')],
        'effect_entries': [
          {
            'effect': 'Powers up Fire moves in a pinch.',
            'short_effect': 'Boosts Fire.',
            'language': {'name': 'en', 'url': ''},
          },
        ],
        'pokemon': [
          {'pokemon': _namedRef('charmander'), 'is_hidden': false, 'slot': 1},
        ],
      });

      final result = await AbilityRepositoryImpl(remote).getAbility('blaze');

      expect(result.isRight(), isTrue);
      final ability = (result as Right).value as Ability;
      expect(ability.displayName, 'Blaze');
      expect(ability.shortEffect, 'Boosts Fire.');
      expect(ability.pokemon.single.pokemon.name, 'charmander');
    });
  });

  group('PokemonSpeciesRepositoryImpl', () {
    test('maps detail json to entity', () async {
      stubDetail('pokemon-species', 'bulbasaur', {
        'id': 1,
        'name': 'bulbasaur',
        'order': 1,
        'gender_rate': 1,
        'capture_rate': 45,
        'base_happiness': 50,
        'is_baby': false,
        'is_legendary': false,
        'is_mythical': false,
        'hatch_counter': 20,
        'has_gender_differences': false,
        'forms_switchable': false,
        'growth_rate': _namedRef('medium-slow'),
        'color': _namedRef('green'),
        'shape': _namedRef('quadruped'),
        'habitat': _namedRef('grassland'),
        'generation': _namedRef('generation-i'),
        'evolves_from_species': null,
        'evolution_chain': {'url': 'https://x/evolution-chain/1/'},
        'egg_groups': [_namedRef('monster')],
        'pokedex_numbers': [
          {'entry_number': 1, 'pokedex': _namedRef('national')},
        ],
        'varieties': [
          {'pokemon': _namedRef('bulbasaur'), 'is_default': true},
        ],
        'names': [_localizedName('Bulbasaur')],
        'genera': [
          {
            'genus': 'Seed Pokémon',
            'language': {'name': 'en', 'url': ''},
          },
        ],
        'flavor_text_entries': [
          {
            'flavor_text': 'A strange seed.',
            'language': {'name': 'en', 'url': ''},
          },
        ],
      });

      final result = await PokemonSpeciesRepositoryImpl(
        remote,
      ).getPokemonSpecies('bulbasaur');

      expect(result.isRight(), isTrue);
      final species = (result as Right).value as PokemonSpecies;
      expect(species.displayName, 'Bulbasaur');
      expect(species.captureRate, 45);
      expect(species.genera, ['Seed Pokémon']);
      expect(species.flavorText, 'A strange seed.');
      expect(species.eggGroups.single.name, 'monster');
      expect(species.evolutionChain?.url, contains('evolution-chain'));
    });

    test('maps unexpected error to UnexpectedFailure', () async {
      stubDetailThrows('pokemon-species', 'x', Exception('boom'));
      final result = await PokemonSpeciesRepositoryImpl(
        remote,
      ).getPokemonSpecies('x');
      expect((result as Left).value, isA<UnexpectedFailure>());
    });
  });

  group('ResourceListRepositoryImpl', () {
    test('maps paginated list into entities', () async {
      when(
        () => remote.fetchList(path: 'ability', offset: 0, limit: 20),
      ).thenAnswer(
        (_) async => (
          count: 2,
          next: 'next-url',
          previous: null,
          items: [
            const NamedApiResourceModel(name: 'stench', url: 'https://x/1/'),
            const NamedApiResourceModel(name: 'drizzle', url: 'https://x/2/'),
          ],
        ),
      );

      final result = await ResourceListRepositoryImpl(remote).getList(
        path: 'ability',
        page: const PageRequest(),
      );

      expect(result.isRight(), isTrue);
      final page = (result as Right).value as PaginatedResult<NamedApiResource>;
      expect(page.count, 2);
      expect(page.items.map((e) => e.name), ['stench', 'drizzle']);
    });

    test('maps AppException to Failure', () async {
      when(
        () => remote.fetchList(path: 'ability', offset: 0, limit: 20),
      ).thenThrow(const NetworkException(message: 'offline'));

      final result = await ResourceListRepositoryImpl(remote).getList(
        path: 'ability',
        page: const PageRequest(),
      );

      expect((result as Left).value, isA<NetworkFailure>());
    });

    test('maps unexpected error to UnexpectedFailure', () async {
      when(
        () => remote.fetchList(path: 'ability', offset: 0, limit: 20),
      ).thenThrow(Exception('boom'));

      final result = await ResourceListRepositoryImpl(remote).getList(
        path: 'ability',
        page: const PageRequest(),
      );

      expect((result as Left).value, isA<UnexpectedFailure>());
    });
  });

  group('resource repository error mapping', () {
    // Each repository maps errors with a try/catch that routes known
    // AppExceptions through Failure.fromException, plus a local parse-failure
    // path. These drive Network/Cache exceptions and a malformed payload
    // through every repo to cover those arms.
    test('NatureRepositoryImpl maps Cache/Network/parse', () async {
      stubDetailThrows('nature', 'a', const CacheException(message: 'c'));
      expect(
        (await NatureRepositoryImpl(remote).getNature('a') as Left).value,
        isA<CacheFailure>(),
      );
      stubDetailThrows('nature', 'b', const NetworkException(message: 'n'));
      expect(
        (await NatureRepositoryImpl(remote).getNature('b') as Left).value,
        isA<NetworkFailure>(),
      );
      stubDetailThrows('nature', 'c', Exception('boom'));
      expect(
        (await NatureRepositoryImpl(remote).getNature('c') as Left).value,
        isA<UnexpectedFailure>(),
      );
    });

    test('StatRepositoryImpl maps Cache + malformed', () async {
      stubDetailThrows('stat', 'a', const CacheException(message: 'c'));
      expect(
        (await StatRepositoryImpl(remote).getStat('a') as Left).value,
        isA<CacheFailure>(),
      );
      stubDetail('stat', 'bad', {'name': 'bad'});
      expect(
        (await StatRepositoryImpl(remote).getStat('bad') as Left).value,
        isA<UnexpectedFailure>(),
      );
    });

    test('GenderRepositoryImpl maps errors', () async {
      stubDetailThrows('gender', 'a', const NetworkException(message: 'n'));
      expect(
        (await GenderRepositoryImpl(remote).getGender('a') as Left).value,
        isA<NetworkFailure>(),
      );
      stubDetail('gender', 'bad', {'id': 'nope'});
      expect(
        (await GenderRepositoryImpl(remote).getGender('bad') as Left).value,
        isA<UnexpectedFailure>(),
      );
    });

    test('GrowthRateRepositoryImpl maps errors', () async {
      stubDetailThrows('growth-rate', 'a', const CacheException(message: 'c'));
      expect(
        (await GrowthRateRepositoryImpl(remote).getGrowthRate('a') as Left)
            .value,
        isA<CacheFailure>(),
      );
      stubDetail('growth-rate', 'bad', {'name': 'bad'});
      expect(
        (await GrowthRateRepositoryImpl(remote).getGrowthRate('bad') as Left)
            .value,
        isA<UnexpectedFailure>(),
      );
    });

    test('EggGroupRepositoryImpl maps errors', () async {
      stubDetailThrows('egg-group', 'a', const NetworkException(message: 'n'));
      expect(
        (await EggGroupRepositoryImpl(remote).getEggGroup('a') as Left).value,
        isA<NetworkFailure>(),
      );
      stubDetail('egg-group', 'bad', {'id': 'nope'});
      expect(
        (await EggGroupRepositoryImpl(remote).getEggGroup('bad') as Left).value,
        isA<UnexpectedFailure>(),
      );
    });

    test('PokemonShapeRepositoryImpl maps errors', () async {
      stubDetailThrows(
        'pokemon-shape',
        'a',
        const CacheException(message: 'c'),
      );
      expect(
        (await PokemonShapeRepositoryImpl(remote).getPokemonShape('a') as Left)
            .value,
        isA<CacheFailure>(),
      );
      stubDetail('pokemon-shape', 'bad', {'id': 'nope'});
      expect(
        (await PokemonShapeRepositoryImpl(remote).getPokemonShape('bad')
                as Left)
            .value,
        isA<UnexpectedFailure>(),
      );
    });

    test('PokemonColorRepositoryImpl maps errors', () async {
      stubDetailThrows(
        'pokemon-color',
        'a',
        const NetworkException(message: 'n'),
      );
      expect(
        (await PokemonColorRepositoryImpl(remote).getPokemonColor('a') as Left)
            .value,
        isA<NetworkFailure>(),
      );
      stubDetail('pokemon-color', 'bad', {'id': 'nope'});
      expect(
        (await PokemonColorRepositoryImpl(remote).getPokemonColor('bad')
                as Left)
            .value,
        isA<UnexpectedFailure>(),
      );
    });

    test('PokemonHabitatRepositoryImpl maps errors', () async {
      stubDetailThrows(
        'pokemon-habitat',
        'a',
        const CacheException(message: 'c'),
      );
      expect(
        (await PokemonHabitatRepositoryImpl(remote).getPokemonHabitat('a')
                as Left)
            .value,
        isA<CacheFailure>(),
      );
      stubDetail('pokemon-habitat', 'bad', {'id': 'nope'});
      expect(
        (await PokemonHabitatRepositoryImpl(remote).getPokemonHabitat('bad')
                as Left)
            .value,
        isA<UnexpectedFailure>(),
      );
    });

    test('PokeathlonStatRepositoryImpl maps errors', () async {
      stubDetailThrows(
        'pokeathlon-stat',
        'a',
        const NetworkException(message: 'n'),
      );
      expect(
        (await PokeathlonStatRepositoryImpl(remote).getPokeathlonStat('a')
                as Left)
            .value,
        isA<NetworkFailure>(),
      );
      stubDetail('pokeathlon-stat', 'bad', {'id': 'nope'});
      expect(
        (await PokeathlonStatRepositoryImpl(remote).getPokeathlonStat('bad')
                as Left)
            .value,
        isA<UnexpectedFailure>(),
      );
    });

    test('PokemonTypeRepositoryImpl maps errors', () async {
      stubDetailThrows('type', 'a', const CacheException(message: 'c'));
      expect(
        (await PokemonTypeRepositoryImpl(remote).getPokemonType('a') as Left)
            .value,
        isA<CacheFailure>(),
      );
      stubDetail('type', 'bad', {'name': 'bad'});
      expect(
        (await PokemonTypeRepositoryImpl(remote).getPokemonType('bad') as Left)
            .value,
        isA<UnexpectedFailure>(),
      );
    });

    test('PokemonFormRepositoryImpl maps errors', () async {
      stubDetailThrows(
        'pokemon-form',
        'a',
        const NetworkException(message: 'n'),
      );
      expect(
        (await PokemonFormRepositoryImpl(remote).getPokemonForm('a') as Left)
            .value,
        isA<NetworkFailure>(),
      );
      stubDetail('pokemon-form', 'bad', {'name': 'bad'});
      expect(
        (await PokemonFormRepositoryImpl(remote).getPokemonForm('bad') as Left)
            .value,
        isA<UnexpectedFailure>(),
      );
    });

    test('AbilityRepositoryImpl maps Cache error', () async {
      stubDetailThrows('ability', 'a', const CacheException(message: 'c'));
      expect(
        (await AbilityRepositoryImpl(remote).getAbility('a') as Left).value,
        isA<CacheFailure>(),
      );
    });

    test('CharacteristicRepositoryImpl maps Cache + malformed', () async {
      stubDetailThrows(
        'characteristic',
        '1',
        const CacheException(message: 'c'),
      );
      expect(
        (await CharacteristicRepositoryImpl(remote).getCharacteristic(1)
                as Left)
            .value,
        isA<CacheFailure>(),
      );
      stubDetail('characteristic', '2', {'id': 'nope'});
      expect(
        (await CharacteristicRepositoryImpl(remote).getCharacteristic(2)
                as Left)
            .value,
        isA<UnexpectedFailure>(),
      );
    });

    test('PokemonSpeciesRepositoryImpl maps Cache + Network', () async {
      stubDetailThrows(
        'pokemon-species',
        'a',
        const CacheException(message: 'c'),
      );
      expect(
        (await PokemonSpeciesRepositoryImpl(remote).getPokemonSpecies('a')
                as Left)
            .value,
        isA<CacheFailure>(),
      );
      stubDetailThrows(
        'pokemon-species',
        'b',
        const NetworkException(message: 'n'),
      );
      expect(
        (await PokemonSpeciesRepositoryImpl(remote).getPokemonSpecies('b')
                as Left)
            .value,
        isA<NetworkFailure>(),
      );
    });
  });
}
