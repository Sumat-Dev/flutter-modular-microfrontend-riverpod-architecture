import 'package:feature_pokemon/feature_pokemon.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'home_page.dart';

/// Root module. Owns only bootstrap wiring and top-level module composition
/// (plan §3). Business logic lives inside feature modules.
class AppModule extends Module {
  @override
  void routes(RouteManager r) {
    r.child('/', child: (_) => const HomePage());
    r.module('/pokemon', module: PokemonModule());
    // Future features register here (moves, items, ...) — plan §15.
  }
}
