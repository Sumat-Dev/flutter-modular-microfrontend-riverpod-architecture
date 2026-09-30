import 'package:core/core.dart';
import 'package:feature_pokemon/src/data/datasources/pokemon_remote_data_source.dart';
import 'package:feature_pokemon/src/data/models/pokemon_detail_model.dart';
import 'package:feature_pokemon/src/data/models/pokemon_model.dart';
import 'package:feature_pokemon/src/data/repositories/pokemon_repository_impl.dart';
import 'package:feature_pokemon/src/domain/entities/pokemon.dart';
import 'package:feature_pokemon/src/domain/entities/pokemon_detail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockRemote extends Mock implements PokemonRemoteDataSource {}

PokemonDetailModel _detailModel() => const PokemonDetailModel(
  id: 25,
  name: 'pikachu',
  height: 4,
  weight: 60,
  types: ['electric'],
  stats: [PokemonStatModel(name: 'hp', baseValue: 35)],
);

void main() {
  late _MockRemote remote;
  late PokemonRepositoryImpl repo;

  setUp(() {
    remote = _MockRemote();
    repo = PokemonRepositoryImpl(remote: remote);
  });

  group('getPokemon', () {
    test('returns entity from remote', () async {
      when(
        () => remote.fetchPokemon('pikachu'),
      ).thenAnswer((_) async => _detailModel());

      final result = await repo.getPokemon('pikachu');

      expect(result.isRight(), isTrue);
      final entity = (result as Right).value as PokemonDetail;
      expect(entity.name, 'pikachu');
      verify(() => remote.fetchPokemon('pikachu')).called(1);
    });

    test('maps ServerException to ServerFailure', () async {
      when(
        () => remote.fetchPokemon('pikachu'),
      ).thenThrow(const ServerException(message: '500', statusCode: 500));

      final result = await repo.getPokemon('pikachu');

      expect(result.isLeft(), isTrue);
      final failure = (result as Left).value as Failure;
      expect(failure, isA<ServerFailure>());
      expect(failure.statusCode, 500);
    });

    test('maps unexpected error to UnexpectedFailure', () async {
      when(() => remote.fetchPokemon('pikachu')).thenThrow(Exception('boom'));

      final result = await repo.getPokemon('pikachu');

      expect(result.isLeft(), isTrue);
      expect((result as Left).value, isA<UnexpectedFailure>());
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
}
