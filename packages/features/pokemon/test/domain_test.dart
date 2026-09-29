import 'package:core/core.dart';
import 'package:feature_pokemon/pokemon_module.dart';
import 'package:feature_pokemon/src/domain/repositories/pokemon_repository.dart';
import 'package:feature_pokemon/src/domain/usecases/get_pokemon.dart';
import 'package:feature_pokemon/src/domain/usecases/get_pokemon_list.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockRepo extends Mock implements PokemonRepository {}

class _FakePageRequest extends Fake implements PageRequest {}

void main() {
  setUpAll(() {
    registerFallbackValue(_FakePageRequest());
  });

  late _MockRepo repo;

  setUp(() {
    repo = _MockRepo();
  });

  group('GetPokemonList use case', () {
    test('delegates to repository and returns its result', () async {
      const page = PaginatedResult<Pokemon>(
        count: 1,
        items: [Pokemon(id: 1, name: 'bulbasaur')],
      );
      when(
        () => repo.getPokemonList(any()),
      ).thenAnswer((_) async => const Right(page));

      final useCase = GetPokemonList(repo);
      final result = await useCase(const PageRequest());

      expect(result.isRight(), isTrue);
      expect((result as Right).value, page);
      verify(() => repo.getPokemonList(const PageRequest())).called(1);
    });

    test('propagates failure from repository', () async {
      when(
        () => repo.getPokemonList(any()),
      ).thenAnswer((_) async => const Left(NetworkFailure(message: 'x')));

      final useCase = GetPokemonList(repo);
      final result = await useCase(const PageRequest(offset: 20));

      expect(result.isLeft(), isTrue);
      expect((result as Left).value, isA<NetworkFailure>());
    });
  });

  group('GetPokemon use case', () {
    test('delegates to repository and returns detail', () async {
      const detail = PokemonDetail(
        id: 25,
        name: 'pikachu',
        height: 4,
        weight: 60,
        types: ['electric'],
        stats: [PokemonStat(name: 'hp', baseValue: 35)],
      );
      when(
        () => repo.getPokemon(any()),
      ).thenAnswer((_) async => const Right(detail));

      final useCase = GetPokemon(repo);
      final result = await useCase('pikachu');

      expect(result.isRight(), isTrue);
      expect(((result as Right).value as PokemonDetail).name, 'pikachu');
      verify(() => repo.getPokemon('pikachu')).called(1);
    });

    test('propagates failure from repository', () async {
      when(
        () => repo.getPokemon(any()),
      ).thenAnswer((_) async => const Left(ServerFailure(message: 'x')));

      final useCase = GetPokemon(repo);
      final result = await useCase('missing');

      expect(result.isLeft(), isTrue);
      expect((result as Left).value, isA<ServerFailure>());
    });
  });

  group('Pokemon entity', () {
    test('builds official artwork imageUrl from id', () {
      const p = Pokemon(id: 25, name: 'pikachu');
      expect(p.imageUrl, contains('/25.png'));
    });

    test('value equality via Equatable props', () {
      expect(
        const Pokemon(id: 1, name: 'bulbasaur'),
        const Pokemon(id: 1, name: 'bulbasaur'),
      );
      expect(
        const Pokemon(id: 1, name: 'bulbasaur'),
        isNot(const Pokemon(id: 2, name: 'ivysaur')),
      );
    });
  });

  group('PokemonDetail entity', () {
    const detail = PokemonDetail(
      id: 25,
      name: 'pikachu',
      height: 4,
      weight: 60,
      types: ['electric'],
      stats: [PokemonStat(name: 'hp', baseValue: 35)],
    );

    test('summary maps to a Pokemon and shares imageUrl', () {
      expect(detail.summary, const Pokemon(id: 25, name: 'pikachu'));
      expect(detail.imageUrl, detail.summary.imageUrl);
      expect(detail.imageUrl, contains('/25.png'));
    });

    test('value equality via Equatable props', () {
      expect(
        detail,
        const PokemonDetail(
          id: 25,
          name: 'pikachu',
          height: 4,
          weight: 60,
          types: ['electric'],
          stats: [PokemonStat(name: 'hp', baseValue: 35)],
        ),
      );
    });

    test('PokemonStat value equality', () {
      expect(
        const PokemonStat(name: 'hp', baseValue: 35),
        const PokemonStat(name: 'hp', baseValue: 35),
      );
      expect(
        const PokemonStat(name: 'hp', baseValue: 35),
        isNot(const PokemonStat(name: 'atk', baseValue: 55)),
      );
    });
  });
}
