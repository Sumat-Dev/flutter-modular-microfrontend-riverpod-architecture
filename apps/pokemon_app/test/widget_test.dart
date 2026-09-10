import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:pokemon_app/config/routes/app_pages.dart';
import 'package:pokemon_app/config/routes/app_routes.dart';

void main() {
  test('AppPages exposes a GoRouter starting at the home route', () {
    expect(AppPages.router, isA<GoRouter>());
    expect(AppPages.initial, Routes.home);
  });

  test('Routes builds the detail path from a name', () {
    expect(Routes.pokemonDetail('pikachu'), '/pokemon/pikachu');
  });
}
