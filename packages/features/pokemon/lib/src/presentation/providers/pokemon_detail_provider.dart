import 'package:core/core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/pokemon_detail.dart';
import 'pokemon_providers.dart';

/// Loads a single Pokemon's detail, keyed by name. Throws the domain [Failure]
/// so the UI can surface it via [AsyncValue.error].
final FutureProviderFamily<PokemonDetail, String> pokemonDetailProvider =
    FutureProvider.family<PokemonDetail, String>((
      ref,
      name,
    ) async {
      final useCase = ref.watch(getPokemonProvider);
      final result = await useCase(name);
      return result.fold((f) => throw f, (detail) => detail);
    });
