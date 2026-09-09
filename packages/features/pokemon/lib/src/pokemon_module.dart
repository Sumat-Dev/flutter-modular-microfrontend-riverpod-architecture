import 'package:flutter_modular/flutter_modular.dart';

import 'presentation/pages/pokemon_detail_page.dart';
import 'presentation/pages/pokemon_page.dart';

/// Feature module. Owns its internal routes (plan §15). The root [AppModule]
/// registers this module under `/pokemon`.
class PokemonModule extends Module {
  @override
  void routes(RouteManager r) {
    r.child('/', child: (_) => const PokemonPage());
    r.child(
      '/:name',
      child: (_) => PokemonDetailPage(name: r.args.params['name'] as String),
    );
  }
}
