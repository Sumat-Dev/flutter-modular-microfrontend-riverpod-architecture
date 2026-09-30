import 'package:feature_pokemon/src/data/datasources/encounter_remote_data_source.dart';
import 'package:feature_pokemon/src/data/datasources/resource_list_remote_data_source.dart';
import 'package:feature_pokemon/src/data/repositories/ability_repository_impl.dart';
import 'package:feature_pokemon/src/data/repositories/characteristic_repository_impl.dart';
import 'package:feature_pokemon/src/data/repositories/egg_group_repository_impl.dart';
import 'package:feature_pokemon/src/data/repositories/encounter_repository_impl.dart';
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
import 'package:feature_pokemon/src/domain/repositories/ability_repository.dart';
import 'package:feature_pokemon/src/domain/repositories/characteristic_repository.dart';
import 'package:feature_pokemon/src/domain/repositories/egg_group_repository.dart';
import 'package:feature_pokemon/src/domain/repositories/encounter_repository.dart';
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
import 'package:feature_pokemon/src/domain/usecases/get_encounters.dart';
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
import 'package:feature_pokemon/src/presentation/providers/pokemon_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'resource_providers.g.dart';

// --- Shared datasources ----------------------------------------------------

@Riverpod(keepAlive: true)
ResourceListRemoteDataSource resourceListRemoteDataSource(Ref ref) =>
    ResourceListRemoteDataSource(ref.watch(apiClientProvider));

@Riverpod(keepAlive: true)
EncounterRemoteDataSource encounterRemoteDataSource(Ref ref) =>
    EncounterRemoteDataSourceImpl(ref.watch(apiClientProvider));

// --- Generic named-resource list -------------------------------------------

@Riverpod(keepAlive: true)
ResourceListRepository resourceListRepository(Ref ref) =>
    ResourceListRepositoryImpl(ref.watch(resourceListRemoteDataSourceProvider));

@Riverpod(keepAlive: true)
GetResourceList getResourceList(Ref ref) =>
    GetResourceList(ref.watch(resourceListRepositoryProvider));

// --- Per-resource repositories ---------------------------------------------

@Riverpod(keepAlive: true)
AbilityRepository abilityRepository(Ref ref) =>
    AbilityRepositoryImpl(ref.watch(resourceListRemoteDataSourceProvider));

@Riverpod(keepAlive: true)
EggGroupRepository eggGroupRepository(Ref ref) =>
    EggGroupRepositoryImpl(ref.watch(resourceListRemoteDataSourceProvider));

@Riverpod(keepAlive: true)
GenderRepository genderRepository(Ref ref) =>
    GenderRepositoryImpl(ref.watch(resourceListRemoteDataSourceProvider));

@Riverpod(keepAlive: true)
GrowthRateRepository growthRateRepository(Ref ref) =>
    GrowthRateRepositoryImpl(ref.watch(resourceListRemoteDataSourceProvider));

@Riverpod(keepAlive: true)
NatureRepository natureRepository(Ref ref) =>
    NatureRepositoryImpl(ref.watch(resourceListRemoteDataSourceProvider));

@Riverpod(keepAlive: true)
PokeathlonStatRepository pokeathlonStatRepository(Ref ref) =>
    PokeathlonStatRepositoryImpl(
      ref.watch(resourceListRemoteDataSourceProvider),
    );

@Riverpod(keepAlive: true)
PokemonColorRepository pokemonColorRepository(Ref ref) =>
    PokemonColorRepositoryImpl(ref.watch(resourceListRemoteDataSourceProvider));

@Riverpod(keepAlive: true)
PokemonFormRepository pokemonFormRepository(Ref ref) =>
    PokemonFormRepositoryImpl(ref.watch(resourceListRemoteDataSourceProvider));

@Riverpod(keepAlive: true)
PokemonHabitatRepository pokemonHabitatRepository(Ref ref) =>
    PokemonHabitatRepositoryImpl(
      ref.watch(resourceListRemoteDataSourceProvider),
    );

@Riverpod(keepAlive: true)
PokemonShapeRepository pokemonShapeRepository(Ref ref) =>
    PokemonShapeRepositoryImpl(ref.watch(resourceListRemoteDataSourceProvider));

@Riverpod(keepAlive: true)
StatRepository statRepository(Ref ref) =>
    StatRepositoryImpl(ref.watch(resourceListRemoteDataSourceProvider));

@Riverpod(keepAlive: true)
PokemonTypeRepository pokemonTypeRepository(Ref ref) =>
    PokemonTypeRepositoryImpl(ref.watch(resourceListRemoteDataSourceProvider));

@Riverpod(keepAlive: true)
CharacteristicRepository characteristicRepository(Ref ref) =>
    CharacteristicRepositoryImpl(
      ref.watch(resourceListRemoteDataSourceProvider),
    );

@Riverpod(keepAlive: true)
PokemonSpeciesRepository pokemonSpeciesRepository(Ref ref) =>
    PokemonSpeciesRepositoryImpl(
      ref.watch(resourceListRemoteDataSourceProvider),
    );

@Riverpod(keepAlive: true)
EncounterRepository encounterRepository(Ref ref) =>
    EncounterRepositoryImpl(ref.watch(encounterRemoteDataSourceProvider));

// --- Per-resource use cases -------------------------------------------------

@Riverpod(keepAlive: true)
GetAbility getAbility(Ref ref) =>
    GetAbility(ref.watch(abilityRepositoryProvider));

@Riverpod(keepAlive: true)
GetEggGroup getEggGroup(Ref ref) =>
    GetEggGroup(ref.watch(eggGroupRepositoryProvider));

@Riverpod(keepAlive: true)
GetGender getGender(Ref ref) => GetGender(ref.watch(genderRepositoryProvider));

@Riverpod(keepAlive: true)
GetGrowthRate getGrowthRate(Ref ref) =>
    GetGrowthRate(ref.watch(growthRateRepositoryProvider));

@Riverpod(keepAlive: true)
GetNature getNature(Ref ref) => GetNature(ref.watch(natureRepositoryProvider));

@Riverpod(keepAlive: true)
GetPokeathlonStat getPokeathlonStat(Ref ref) =>
    GetPokeathlonStat(ref.watch(pokeathlonStatRepositoryProvider));

@Riverpod(keepAlive: true)
GetPokemonColor getPokemonColor(Ref ref) =>
    GetPokemonColor(ref.watch(pokemonColorRepositoryProvider));

@Riverpod(keepAlive: true)
GetPokemonForm getPokemonForm(Ref ref) =>
    GetPokemonForm(ref.watch(pokemonFormRepositoryProvider));

@Riverpod(keepAlive: true)
GetPokemonHabitat getPokemonHabitat(Ref ref) =>
    GetPokemonHabitat(ref.watch(pokemonHabitatRepositoryProvider));

@Riverpod(keepAlive: true)
GetPokemonShape getPokemonShape(Ref ref) =>
    GetPokemonShape(ref.watch(pokemonShapeRepositoryProvider));

@Riverpod(keepAlive: true)
GetStat getStat(Ref ref) => GetStat(ref.watch(statRepositoryProvider));

@Riverpod(keepAlive: true)
GetPokemonType getPokemonType(Ref ref) =>
    GetPokemonType(ref.watch(pokemonTypeRepositoryProvider));

@Riverpod(keepAlive: true)
GetCharacteristic getCharacteristic(Ref ref) =>
    GetCharacteristic(ref.watch(characteristicRepositoryProvider));

@Riverpod(keepAlive: true)
GetPokemonSpecies getPokemonSpecies(Ref ref) =>
    GetPokemonSpecies(ref.watch(pokemonSpeciesRepositoryProvider));

@Riverpod(keepAlive: true)
GetEncounters getEncounters(Ref ref) =>
    GetEncounters(ref.watch(encounterRepositoryProvider));
