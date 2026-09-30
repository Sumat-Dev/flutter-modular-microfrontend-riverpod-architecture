import 'package:feature_berries/berries_module.dart';
import 'package:feature_items/items_module.dart';
import 'package:feature_pokemon/pokemon_module.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pokemon_app/home_page.dart';

/// Root module for the app shell. Composes the home route and mounts the
/// feature modules under their route prefixes.
///
/// Routing is handled by flutter_modular; application state/DI remains on
/// Riverpod (see the `ProviderScope` in `main.dart`).
class AppModule extends Module {
  @override
  void routes(RouteManager r) {
    r
      // /
      ..child('/', child: (_) => const HomePage())
      // /pokemon (+ nested /pokemon/:name)
      ..module('/pokemon', module: PokemonModule())
      // /berries (+ nested /berries/:name)
      ..module('/berries', module: BerriesModule())
      // /items (+ nested /items/:name)
      ..module('/items', module: ItemsModule());
  }
}
