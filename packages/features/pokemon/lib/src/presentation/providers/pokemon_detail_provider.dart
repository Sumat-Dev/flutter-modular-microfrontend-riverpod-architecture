import 'package:core/core.dart';
import 'package:feature_pokemon/src/domain/entities/pokemon_detail.dart';
import 'package:feature_pokemon/src/presentation/providers/pokemon_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Loads a single Pokemon's detail, keyed by name. Throws the domain [Failure]
/// so the UI can surface it via [AsyncValue.error].
final FutureProviderFamily<PokemonDetail, String> pokemonDetailProvider =
    FutureProvider.family<PokemonDetail, String>((
      ref,
      name,
    ) async {
      final useCase = ref.watch(getPokemonProvider);
      final result = await useCase(name);
      // Deliberately rethrow the domain Failure so Riverpod surfaces it via
      // AsyncValue.error (see doc comment above).
      // ignore: only_throw_errors
      return result.fold((f) => throw f, (detail) => detail);
    });
