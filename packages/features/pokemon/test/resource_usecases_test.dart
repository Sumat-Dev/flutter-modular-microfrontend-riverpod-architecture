import 'package:core/core.dart';
import 'package:feature_pokemon/src/domain/repositories/ability_repository.dart';
import 'package:feature_pokemon/src/domain/repositories/characteristic_repository.dart';
import 'package:feature_pokemon/src/domain/repositories/egg_group_repository.dart';
import 'package:feature_pokemon/src/domain/repositories/gender_repository.dart';
import 'package:feature_pokemon/src/domain/repositories/growth_rate_repository.dart';
import 'package:feature_pokemon/src/domain/repositories/nature_repository.dart';
import 'package:feature_pokemon/src/domain/repositories/pokeathlon_stat_repository.dart';
import 'package:feature_pokemon/src/domain/repositories/pokemon_color_repository.dart';
import 'package:feature_pokemon/src/domain/repositories/pokemon_form_repository.dart';
import 'package:feature_pokemon/src/domain/repositories/pokemon_habitat_repository.dart';
import 'package:feature_pokemon/src/domain/repositories/pokemon_shape_repository.dart';
import 'package:feature_pokemon/src/domain/repositories/pokemon_species_repository.dart';
import 'package:feature_pokemon/src/domain/repositories/pokemon_type_repository.dart';
import 'package:feature_pokemon/src/domain/repositories/resource_list_repository.dart';
import 'package:feature_pokemon/src/domain/repositories/stat_repository.dart';
import 'package:feature_pokemon/src/domain/usecases/get_ability.dart';
import 'package:feature_pokemon/src/domain/usecases/get_characteristic.dart';
import 'package:feature_pokemon/src/domain/usecases/get_egg_group.dart';
import 'package:feature_pokemon/src/domain/usecases/get_gender.dart';
import 'package:feature_pokemon/src/domain/usecases/get_growth_rate.dart';
import 'package:feature_pokemon/src/domain/usecases/get_nature.dart';
import 'package:feature_pokemon/src/domain/usecases/get_pokeathlon_stat.dart';
import 'package:feature_pokemon/src/domain/usecases/get_pokemon_color.dart';
import 'package:feature_pokemon/src/domain/usecases/get_pokemon_form.dart';
import 'package:feature_pokemon/src/domain/usecases/get_pokemon_habitat.dart';
import 'package:feature_pokemon/src/domain/usecases/get_pokemon_shape.dart';
import 'package:feature_pokemon/src/domain/usecases/get_pokemon_species.dart';
import 'package:feature_pokemon/src/domain/usecases/get_pokemon_type.dart';
import 'package:feature_pokemon/src/domain/usecases/get_resource_list.dart';
import 'package:feature_pokemon/src/domain/usecases/get_stat.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockAbilityRepo extends Mock implements AbilityRepository {}

class _MockCharacteristicRepo extends Mock
    implements CharacteristicRepository {}

class _MockEggGroupRepo extends Mock implements EggGroupRepository {}

class _MockGenderRepo extends Mock implements GenderRepository {}

class _MockGrowthRateRepo extends Mock implements GrowthRateRepository {}

class _MockNatureRepo extends Mock implements NatureRepository {}

class _MockPokeathlonStatRepo extends Mock
    implements PokeathlonStatRepository {}

class _MockPokemonColorRepo extends Mock implements PokemonColorRepository {}

class _MockPokemonFormRepo extends Mock implements PokemonFormRepository {}

class _MockPokemonHabitatRepo extends Mock
    implements PokemonHabitatRepository {}

class _MockPokemonShapeRepo extends Mock implements PokemonShapeRepository {}

class _MockPokemonSpeciesRepo extends Mock
    implements PokemonSpeciesRepository {}

class _MockPokemonTypeRepo extends Mock implements PokemonTypeRepository {}

class _MockStatRepo extends Mock implements StatRepository {}

class _MockResourceListRepo extends Mock implements ResourceListRepository {}

class _FakePageRequest extends Fake implements PageRequest {}

/// Every resource use case is a thin delegate to its repository. These tests
/// assert the delegation contract (arg passthrough + result passthrough) using
/// a `Left(failure)` so we don't need to build full entities.
void main() {
  setUpAll(() {
    registerFallbackValue(_FakePageRequest());
  });

  const failure = ServerFailure(message: 'x');

  test('GetResourceList delegates to repository with path + page', () async {
    final repo = _MockResourceListRepo();
    when(
      () => repo.getList(
        path: any(named: 'path'),
        page: any(named: 'page'),
      ),
    ).thenAnswer((_) async => const Left(failure));

    final result = await GetResourceList(repo)(
      const ResourceListParams(path: 'ability', page: PageRequest()),
    );

    expect(result.isLeft(), isTrue);
    verify(
      () => repo.getList(path: 'ability', page: const PageRequest()),
    ).called(1);
  });

  test('ResourceListParams value equality', () {
    expect(
      const ResourceListParams(path: 'ability', page: PageRequest()),
      const ResourceListParams(path: 'ability', page: PageRequest()),
    );
    expect(
      const ResourceListParams(path: 'ability', page: PageRequest()),
      isNot(const ResourceListParams(path: 'type', page: PageRequest())),
    );
  });

  test('GetAbility delegates to repository', () async {
    final repo = _MockAbilityRepo();
    when(
      () => repo.getAbility(any()),
    ).thenAnswer((_) async => const Left(failure));
    final result = await GetAbility(repo)('blaze');
    expect(result.isLeft(), isTrue);
    verify(() => repo.getAbility('blaze')).called(1);
  });

  test('GetCharacteristic delegates to repository', () async {
    final repo = _MockCharacteristicRepo();
    when(
      () => repo.getCharacteristic(any()),
    ).thenAnswer((_) async => const Left(failure));
    final result = await GetCharacteristic(repo)(1);
    expect(result.isLeft(), isTrue);
    verify(() => repo.getCharacteristic(1)).called(1);
  });

  test('GetEggGroup delegates to repository', () async {
    final repo = _MockEggGroupRepo();
    when(
      () => repo.getEggGroup(any()),
    ).thenAnswer((_) async => const Left(failure));
    final result = await GetEggGroup(repo)('monster');
    expect(result.isLeft(), isTrue);
    verify(() => repo.getEggGroup('monster')).called(1);
  });

  test('GetGender delegates to repository', () async {
    final repo = _MockGenderRepo();
    when(
      () => repo.getGender(any()),
    ).thenAnswer((_) async => const Left(failure));
    final result = await GetGender(repo)('female');
    expect(result.isLeft(), isTrue);
    verify(() => repo.getGender('female')).called(1);
  });

  test('GetGrowthRate delegates to repository', () async {
    final repo = _MockGrowthRateRepo();
    when(
      () => repo.getGrowthRate(any()),
    ).thenAnswer((_) async => const Left(failure));
    final result = await GetGrowthRate(repo)('medium');
    expect(result.isLeft(), isTrue);
    verify(() => repo.getGrowthRate('medium')).called(1);
  });

  test('GetNature delegates to repository', () async {
    final repo = _MockNatureRepo();
    when(
      () => repo.getNature(any()),
    ).thenAnswer((_) async => const Left(failure));
    final result = await GetNature(repo)('adamant');
    expect(result.isLeft(), isTrue);
    verify(() => repo.getNature('adamant')).called(1);
  });

  test('GetPokeathlonStat delegates to repository', () async {
    final repo = _MockPokeathlonStatRepo();
    when(
      () => repo.getPokeathlonStat(any()),
    ).thenAnswer((_) async => const Left(failure));
    final result = await GetPokeathlonStat(repo)('power');
    expect(result.isLeft(), isTrue);
    verify(() => repo.getPokeathlonStat('power')).called(1);
  });

  test('GetPokemonColor delegates to repository', () async {
    final repo = _MockPokemonColorRepo();
    when(
      () => repo.getPokemonColor(any()),
    ).thenAnswer((_) async => const Left(failure));
    final result = await GetPokemonColor(repo)('red');
    expect(result.isLeft(), isTrue);
    verify(() => repo.getPokemonColor('red')).called(1);
  });

  test('GetPokemonForm delegates to repository', () async {
    final repo = _MockPokemonFormRepo();
    when(
      () => repo.getPokemonForm(any()),
    ).thenAnswer((_) async => const Left(failure));
    final result = await GetPokemonForm(repo)('charizard-mega-x');
    expect(result.isLeft(), isTrue);
    verify(() => repo.getPokemonForm('charizard-mega-x')).called(1);
  });

  test('GetPokemonHabitat delegates to repository', () async {
    final repo = _MockPokemonHabitatRepo();
    when(
      () => repo.getPokemonHabitat(any()),
    ).thenAnswer((_) async => const Left(failure));
    final result = await GetPokemonHabitat(repo)('cave');
    expect(result.isLeft(), isTrue);
    verify(() => repo.getPokemonHabitat('cave')).called(1);
  });

  test('GetPokemonShape delegates to repository', () async {
    final repo = _MockPokemonShapeRepo();
    when(
      () => repo.getPokemonShape(any()),
    ).thenAnswer((_) async => const Left(failure));
    final result = await GetPokemonShape(repo)('ball');
    expect(result.isLeft(), isTrue);
    verify(() => repo.getPokemonShape('ball')).called(1);
  });

  test('GetPokemonSpecies delegates to repository', () async {
    final repo = _MockPokemonSpeciesRepo();
    when(
      () => repo.getPokemonSpecies(any()),
    ).thenAnswer((_) async => const Left(failure));
    final result = await GetPokemonSpecies(repo)('bulbasaur');
    expect(result.isLeft(), isTrue);
    verify(() => repo.getPokemonSpecies('bulbasaur')).called(1);
  });

  test('GetPokemonType delegates to repository', () async {
    final repo = _MockPokemonTypeRepo();
    when(
      () => repo.getPokemonType(any()),
    ).thenAnswer((_) async => const Left(failure));
    final result = await GetPokemonType(repo)('fire');
    expect(result.isLeft(), isTrue);
    verify(() => repo.getPokemonType('fire')).called(1);
  });

  test('GetStat delegates to repository', () async {
    final repo = _MockStatRepo();
    when(
      () => repo.getStat(any()),
    ).thenAnswer((_) async => const Left(failure));
    final result = await GetStat(repo)('attack');
    expect(result.isLeft(), isTrue);
    verify(() => repo.getStat('attack')).called(1);
  });
}
