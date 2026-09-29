import 'package:feature_pokemon/src/presentation/pages/pokemon_detail_page.dart';
import 'package:feature_pokemon/src/presentation/pages/pokemon_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

export 'src/domain/entities/pokemon.dart';
export 'src/domain/entities/pokemon_detail.dart';
export 'src/presentation/pages/pokemon_detail_page.dart';
export 'src/presentation/pages/pokemon_page.dart';

class PokemonModule extends Module {
  @override
  void routes(RouteManager r) {
    // /pokemon
    r.child('/', child: (_) => const PokemonPage());

    // /pokemon/:name
    r.child(
      '/:name',
      child: (context) {
        final name = r.args.params['name'] as String;
        return PokemonDetailPage(name: name);
      },
    );
  }
}
