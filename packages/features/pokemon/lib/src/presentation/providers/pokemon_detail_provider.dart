import 'package:feature_pokemon/src/domain/entities/pokemon_detail.dart';
import 'package:feature_pokemon/src/presentation/providers/pokemon_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pokemon_detail_provider.g.dart';

@Riverpod(keepAlive: true)
Future<PokemonDetail> pokemonDetail(Ref ref, String name) async {
  final useCase = ref.watch(getPokemonProvider);
  final result = await useCase(name);
  // Deliberately rethrow the domain Failure so Riverpod surfaces it via
  // AsyncValue.error.
  // ignore: only_throw_errors
  return result.fold((f) => throw f, (detail) => detail);
}
