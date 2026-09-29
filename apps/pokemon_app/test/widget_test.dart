import 'package:feature_pokemon/pokemon_module.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokemon_app/config/routes/app_module.dart';

void main() {
  test('AppModule declares the home route and mounts the Pokemon module', () {
    final manager = RouteManager();
    AppModule().routes(manager);

    final names = manager.allRoutes.map((r) => r.name).toList();
    expect(names, contains('/'));
    expect(names, contains('/pokemon'));
  });

  test('PokemonModule exposes the list and detail routes', () {
    final manager = RouteManager();
    PokemonModule().routes(manager);

    final names = manager.allRoutes.map((r) => r.name).toList();
    expect(names, contains('/'));
    expect(names, contains('/:name'));
  });
}
