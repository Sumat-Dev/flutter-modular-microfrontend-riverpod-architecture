import 'package:core/core.dart';
import 'package:feature_pokemon/pokemon_module.dart';
import 'package:feature_pokemon/src/data/datasources/pokemon_local_data_source.dart';
import 'package:feature_pokemon/src/data/datasources/pokemon_remote_data_source.dart';
import 'package:feature_pokemon/src/data/models/pokemon_detail_model.dart';
import 'package:feature_pokemon/src/data/models/pokemon_model.dart';
import 'package:feature_pokemon/src/data/repositories/pokemon_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:storage/storage.dart';

class _MockRemote extends Mock implements PokemonRemoteDataSource {}

class _MockLocal extends Mock implements PokemonLocalDataSource {}

class _FakeDetailModel extends Fake implements PokemonDetailModel {}

PokemonDetailModel _detailModel() => const PokemonDetailModel(
  id: 25,
  name: 'pikachu',
  height: 4,
  weight: 60,
  types: ['electric'],
  stats: [PokemonStatModel(name: 'hp', baseValue: 35)],
);

void main() {
  setUpAll(() {
    registerFallbackValue(_FakeDetailModel());
  });

  late _MockRemote remote;
  late _MockLocal local;
  late PokemonRepositoryImpl repo;

  setUp(() {
    remote = _MockRemote();
    local = _MockLocal();
    repo = PokemonRepositoryImpl(remote: remote, local: local);
  });

  group('getPokemon (cache strategy §11)', () {
    test('returns cached entity on cache hit without hitting remote', () async {
      when(
        () => local.readPokemon('pikachu'),
      ).thenAnswer((_) async => _detailModel());

      final result = await repo.getPokemon('pikachu');

      expect(result.isRight(), isTrue);
      final entity = (result as Right).value as PokemonDetail;
      expect(entity.name, 'pikachu');
      verifyNever(() => remote.fetchPokemon(any()));
    });

    test('falls back to remote on cache miss and saves to cache', () async {
      when(() => local.readPokemon('pikachu')).thenAnswer((_) async => null);
      when(
        () => remote.fetchPokemon('pikachu'),
      ).thenAnswer((_) async => _detailModel());
      when(() => local.writePokemon(any())).thenAnswer((_) async {});

      final result = await repo.getPokemon('pikachu');

      expect(result.isRight(), isTrue);
      verify(() => remote.fetchPokemon('pikachu')).called(1);
      verify(() => local.writePokemon(any())).called(1);
    });

    test('maps ServerException to ServerFailure', () async {
      when(() => local.readPokemon('pikachu')).thenAnswer((_) async => null);
      when(
        () => remote.fetchPokemon('pikachu'),
      ).thenThrow(const ServerException(message: '500', statusCode: 500));

      final result = await repo.getPokemon('pikachu');

      expect(result.isLeft(), isTrue);
      final failure = (result as Left).value as Failure;
      expect(failure, isA<ServerFailure>());
      expect(failure.statusCode, 500);
    });

    test('cache read failure is ignored and remote is used', () async {
      when(
        () => local.readPokemon('pikachu'),
      ).thenThrow(const CacheException(message: 'corrupt'));
      when(
        () => remote.fetchPokemon('pikachu'),
      ).thenAnswer((_) async => _detailModel());
      when(() => local.writePokemon(any())).thenAnswer((_) async {});

      final result = await repo.getPokemon('pikachu');

      expect(result.isRight(), isTrue);
    });
  });

  group('getPokemonList', () {
    test('maps models to entities and preserves paging', () async {
      when(() => remote.fetchPokemonList(offset: 0, limit: 20)).thenAnswer(
        (_) async => (
          count: 1,
          next: 'next-url',
          previous: null,
          items: [const PokemonModel(id: 1, name: 'bulbasaur')],
        ),
      );

      final result = await repo.getPokemonList(
        const PageRequest(),
      );

      expect(result.isRight(), isTrue);
      final page = (result as Right).value as PaginatedResult<Pokemon>;
      expect(page.items.single.name, 'bulbasaur');
      expect(page.hasMore, isTrue);
    });

    test('maps NetworkException to NetworkFailure', () async {
      when(
        () => remote.fetchPokemonList(offset: 0, limit: 20),
      ).thenThrow(const NetworkException(message: 'offline'));

      final result = await repo.getPokemonList(
        const PageRequest(),
      );

      expect(result.isLeft(), isTrue);
      expect((result as Left).value, isA<NetworkFailure>());
    });
  });

  group('local store integration', () {
    test('InMemoryKeyValueStore round-trips detail model', () async {
      final store = InMemoryKeyValueStore();
      final ds = PokemonLocalDataSourceImpl(store);
      await ds.writePokemon(_detailModel());
      final read = await ds.readPokemon('pikachu');
      expect(read?.name, 'pikachu');
    });
  });
}
