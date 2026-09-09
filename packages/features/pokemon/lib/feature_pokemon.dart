/// feature_pokemon — public API (plan §13).
///
/// Only the module and intentionally-public domain contracts/entities are
/// exported. `src/data` and `src/presentation` internals stay private so the
/// app treats the feature as a black box.
library;

export 'src/domain/entities/pokemon.dart';
export 'src/domain/entities/pokemon_detail.dart';
export 'src/pokemon_module.dart';
