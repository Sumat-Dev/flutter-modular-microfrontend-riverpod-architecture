import 'package:feature_pokemon/src/domain/entities/pokemon_habitat.dart';
import 'package:feature_pokemon/src/presentation/providers/resource_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pokemon_habitat_detail_provider.g.dart';

@Riverpod(keepAlive: true)
Future<PokemonHabitat> pokemonHabitatDetail(
  Ref ref,
  String idOrName,
) async {
  final useCase = ref.watch(getPokemonHabitatProvider);
  final result = await useCase(idOrName);
  // Rethrow the domain Failure so Riverpod surfaces it via
  // AsyncValue.error.
  // ignore: only_throw_errors
  return result.fold((f) => throw f, (d) => d);
}
