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
import 'package:feature_pokemon/src/domain/entities/pokemon_type.dart';
import 'package:feature_pokemon/src/domain/entities/stat.dart';
import 'package:flutter_test/flutter_test.dart';

/// Builds a fresh (non-const) NamedApiResource so equality checks below can't
/// be short-circuited by Dart's const canonicalisation and must evaluate the
/// entity `props` getters.
NamedApiResource ref([String name = 'x']) =>
    NamedApiResource(name: name, url: 'https://x/$name/1/');

/// Asserts that [a] equals a structurally-identical value and differs from a
/// value with one changed field, forcing `props`/`hashCode` evaluation.
void expectProps(Object a, Object equal, Object different) {
  expect(a, equal);
  expect(a.hashCode, equal.hashCode);
  expect(a, isNot(different));
}

void main() {
  group('NamedApiResource / ApiResource', () {
    test('id parses trailing segment from url', () {
      expect(
        const NamedApiResource(name: 'fire', url: 'https://x/type/10/').id,
        10,
      );
      expect(const ApiResource(url: 'https://x/evolution-chain/7/').id, 7);
    });

    test('id falls back to 0 on malformed url', () {
      expect(const NamedApiResource(name: 'x', url: 'https://x/type/z/').id, 0);
      expect(const ApiResource(url: '').id, 0);
    });

    test('value equality', () {
      expectProps(ref('a'), ref('a'), ref('b'));
      expectProps(
        const ApiResource(url: 'a'),
        const ApiResource(url: 'a'),
        const ApiResource(url: 'b'),
      );
    });

    test('localized wrappers value equality', () {
      expectProps(
        LocalizedName(name: 'A', language: ref()),
        LocalizedName(name: 'A', language: ref()),
        LocalizedName(name: 'B', language: ref()),
      );
      expectProps(
        LocalizedDescription(description: 'd', language: ref()),
        LocalizedDescription(description: 'd', language: ref()),
        LocalizedDescription(description: 'e', language: ref()),
      );
      expectProps(
        FlavorText(text: 't', language: ref()),
        FlavorText(text: 't', language: ref()),
        FlavorText(text: 'u', language: ref()),
      );
      expectProps(
        Genus(genus: 'g', language: ref()),
        Genus(genus: 'g', language: ref()),
        Genus(genus: 'h', language: ref()),
      );
    });
  });

  test('EggGroup props', () {
    expectProps(
      EggGroup(
        id: 1,
        name: 'monster',
        displayName: 'M',
        pokemonSpecies: [ref()],
      ),
      EggGroup(
        id: 1,
        name: 'monster',
        displayName: 'M',
        pokemonSpecies: [ref()],
      ),
      const EggGroup(id: 2, name: 'monster'),
    );
  });

  test('PokeathlonStat props', () {
    expectProps(
      const PokeathlonStat(id: 1, name: 'power', displayName: 'Power'),
      const PokeathlonStat(id: 1, name: 'power', displayName: 'Power'),
      const PokeathlonStat(id: 2, name: 'power'),
    );
  });

  test('PokemonColor props', () {
    expectProps(
      PokemonColor(
        id: 1,
        name: 'red',
        displayName: 'Red',
        pokemonSpecies: [ref()],
      ),
      PokemonColor(
        id: 1,
        name: 'red',
        displayName: 'Red',
        pokemonSpecies: [ref()],
      ),
      const PokemonColor(id: 2, name: 'red'),
    );
  });

  test('PokemonHabitat props', () {
    expectProps(
      PokemonHabitat(
        id: 1,
        name: 'cave',
        displayName: 'C',
        pokemonSpecies: [ref()],
      ),
      PokemonHabitat(
        id: 1,
        name: 'cave',
        displayName: 'C',
        pokemonSpecies: [ref()],
      ),
      const PokemonHabitat(id: 2, name: 'cave'),
    );
  });

  test('Stat props', () {
    expectProps(
      Stat(
        id: 2,
        name: 'attack',
        gameIndex: 2,
        isBattleOnly: false,
        moveDamageClass: ref(),
      ),
      Stat(
        id: 2,
        name: 'attack',
        gameIndex: 2,
        isBattleOnly: false,
        moveDamageClass: ref(),
      ),
      const Stat(id: 3, name: 'attack', gameIndex: 2, isBattleOnly: false),
    );
  });

  test('GrowthRate props', () {
    expectProps(
      GrowthRate(
        id: 1,
        name: 'medium',
        formula: 'n',
        description: 'd',
        levels: const [GrowthRateLevel(level: 1, experience: 0)],
        pokemonSpecies: [ref()],
      ),
      GrowthRate(
        id: 1,
        name: 'medium',
        formula: 'n',
        description: 'd',
        levels: const [GrowthRateLevel(level: 1, experience: 0)],
        pokemonSpecies: [ref()],
      ),
      const GrowthRate(id: 2, name: 'medium', formula: 'n'),
    );
    expectProps(
      const GrowthRateLevel(level: 1, experience: 0),
      const GrowthRateLevel(level: 1, experience: 0),
      const GrowthRateLevel(level: 2, experience: 0),
    );
  });

  test('PokemonShape props', () {
    expectProps(
      PokemonShape(
        id: 1,
        name: 'ball',
        displayName: 'Ball',
        awesomeNames: [ShapeAwesomeName(awesomeName: 'Pom', language: ref())],
        pokemonSpecies: [ref()],
      ),
      PokemonShape(
        id: 1,
        name: 'ball',
        displayName: 'Ball',
        awesomeNames: [ShapeAwesomeName(awesomeName: 'Pom', language: ref())],
        pokemonSpecies: [ref()],
      ),
      const PokemonShape(id: 2, name: 'ball'),
    );
    expectProps(
      ShapeAwesomeName(awesomeName: 'P', language: ref()),
      ShapeAwesomeName(awesomeName: 'P', language: ref()),
      ShapeAwesomeName(awesomeName: 'Q', language: ref()),
    );
  });

  test('Gender props', () {
    expectProps(
      Gender(
        id: 1,
        name: 'female',
        pokemonSpeciesDetails: [
          GenderSpeciesDetail(rate: 4, pokemonSpecies: ref()),
        ],
        requiredForEvolution: [ref()],
      ),
      Gender(
        id: 1,
        name: 'female',
        pokemonSpeciesDetails: [
          GenderSpeciesDetail(rate: 4, pokemonSpecies: ref()),
        ],
        requiredForEvolution: [ref()],
      ),
      const Gender(id: 2, name: 'female'),
    );
    expectProps(
      GenderSpeciesDetail(rate: 4, pokemonSpecies: ref()),
      GenderSpeciesDetail(rate: 4, pokemonSpecies: ref()),
      GenderSpeciesDetail(rate: 8, pokemonSpecies: ref()),
    );
  });

  test('Nature props', () {
    expectProps(
      Nature(
        id: 3,
        name: 'adamant',
        displayName: 'Adamant',
        increasedStat: ref('attack'),
        pokeathlonStatChanges: [
          NaturePokeathlonStatChange(maxChange: 2, pokeathlonStat: ref()),
        ],
      ),
      Nature(
        id: 3,
        name: 'adamant',
        displayName: 'Adamant',
        increasedStat: ref('attack'),
        pokeathlonStatChanges: [
          NaturePokeathlonStatChange(maxChange: 2, pokeathlonStat: ref()),
        ],
      ),
      const Nature(id: 4, name: 'adamant'),
    );
    expectProps(
      NaturePokeathlonStatChange(maxChange: 2, pokeathlonStat: ref()),
      NaturePokeathlonStatChange(maxChange: 2, pokeathlonStat: ref()),
      NaturePokeathlonStatChange(maxChange: 3, pokeathlonStat: ref()),
    );
  });

  test('PokemonType props', () {
    final relations = TypeDamageRelations(doubleDamageTo: [ref('grass')]);
    expectProps(
      PokemonType(
        id: 10,
        name: 'fire',
        damageRelations: relations,
        pokemon: [ref()],
      ),
      PokemonType(
        id: 10,
        name: 'fire',
        damageRelations: relations,
        pokemon: [ref()],
      ),
      PokemonType(id: 11, name: 'fire', damageRelations: relations),
    );
    expectProps(
      TypeDamageRelations(doubleDamageTo: [ref('grass')]),
      TypeDamageRelations(doubleDamageTo: [ref('grass')]),
      TypeDamageRelations(doubleDamageTo: [ref('ice')]),
    );
  });

  test('PokemonForm props', () {
    PokemonForm build(int id) => PokemonForm(
      id: id,
      name: 'f',
      order: 1,
      formOrder: 1,
      isDefault: true,
      isBattleOnly: false,
      isMega: false,
      formName: '',
      pokemon: ref(),
      types: const ['fire'],
      spriteUrl: 'u',
    );
    expectProps(build(1), build(1), build(2));
  });

  test('Characteristic props', () {
    expectProps(
      Characteristic(
        id: 1,
        geneModulo: 0,
        possibleValues: const [0, 5],
        highestStat: ref(),
      ),
      Characteristic(
        id: 1,
        geneModulo: 0,
        possibleValues: const [0, 5],
        highestStat: ref(),
      ),
      Characteristic(
        id: 2,
        geneModulo: 0,
        possibleValues: const [0, 5],
        highestStat: ref(),
      ),
    );
  });

  test('Ability props', () {
    Ability build(int id) => Ability(
      id: id,
      name: 'blaze',
      isMainSeries: true,
      generation: ref('generation-iii'),
      displayName: 'Blaze',
      effect: 'e',
      shortEffect: 's',
      pokemon: [AbilityPokemon(pokemon: ref(), isHidden: false, slot: 1)],
    );
    expectProps(build(66), build(66), build(67));
    expectProps(
      AbilityPokemon(pokemon: ref(), isHidden: false, slot: 1),
      AbilityPokemon(pokemon: ref(), isHidden: false, slot: 1),
      AbilityPokemon(pokemon: ref(), isHidden: true, slot: 1),
    );
  });
}
