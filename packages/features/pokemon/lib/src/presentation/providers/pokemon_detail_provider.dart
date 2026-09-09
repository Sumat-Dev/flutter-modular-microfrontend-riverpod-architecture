import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:library_core/library_core.dart';

import '../../domain/entities/pokemon_detail.dart';
import 'pokemon_providers.dart';

/// Loads a single Pokemon's detail, keyed by name. Throws the domain [Failure]
/// so the UI can surface it via [AsyncValue.error].
final pokemonDetailProvider = FutureProvider.family<PokemonDetail, String>((
  ref,
  name,
) async {
  final useCase = ref.watch(getPokemonProvider);
  final result = await useCase(name);
  return result.when(success: (detail) => detail, failure: (f) => throw f);
});
