import 'package:feature_berries/berries_module.dart';
import 'package:feature_items/items_module.dart';
import 'package:feature_pokemon/pokemon_module.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pokemon_app/home_page.dart';

class AppModule extends Module {
  @override
  void routes(RouteManager r) {
    r.child(
      '/',
      child: (_) => const HomePage(),
      children: [
        ModuleRoute('/pokemon', module: PokemonModule()),
        ModuleRoute('/berries', module: BerriesModule()),
        ModuleRoute('/items', module: ItemsModule()),
      ],
    );
  }
}
