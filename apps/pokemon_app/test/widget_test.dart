import 'package:feature_pokemon/pokemon_module.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokemon_app/config/routes/app_module.dart';

void main() {
  test('AppModule nests the feature modules under the home shell', () {
    final manager = RouteManager();
    AppModule().routes(manager);

    final names = manager.allRoutes.map((r) => r.name).toList();
    expect(names, ['/']);

    // The feature modules hang off the shell so they render inside its
    // RouterOutlet while the bottom navigation bar stays on screen.
    final children = manager.allRoutes.single.children.map((r) => r.name);
    expect(children, ['/pokemon', '/berries', '/items']);
  });

  test('PokemonModule exposes the list and detail routes', () {
    final manager = RouteManager();
    PokemonModule().routes(manager);

    final names = manager.allRoutes.map((r) => r.name).toList();
    expect(names, contains('/'));
    expect(names, contains('/:name'));
  });
}
