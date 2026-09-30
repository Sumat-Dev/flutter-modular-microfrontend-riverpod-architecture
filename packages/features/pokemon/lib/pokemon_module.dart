import 'package:feature_pokemon/src/presentation/pages/ability_detail_page.dart';
import 'package:feature_pokemon/src/presentation/pages/characteristic_detail_page.dart';
import 'package:feature_pokemon/src/presentation/pages/egg_group_detail_page.dart';
import 'package:feature_pokemon/src/presentation/pages/gender_detail_page.dart';
import 'package:feature_pokemon/src/presentation/pages/growth_rate_detail_page.dart';
import 'package:feature_pokemon/src/presentation/pages/nature_detail_page.dart';
import 'package:feature_pokemon/src/presentation/pages/pokeathlon_stat_detail_page.dart';
import 'package:feature_pokemon/src/presentation/pages/pokemon_color_detail_page.dart';
import 'package:feature_pokemon/src/presentation/pages/pokemon_detail_page.dart';
import 'package:feature_pokemon/src/presentation/pages/pokemon_form_detail_page.dart';
import 'package:feature_pokemon/src/presentation/pages/pokemon_habitat_detail_page.dart';
import 'package:feature_pokemon/src/presentation/pages/pokemon_page.dart';
import 'package:feature_pokemon/src/presentation/pages/pokemon_shape_detail_page.dart';
import 'package:feature_pokemon/src/presentation/pages/pokemon_species_detail_page.dart';
import 'package:feature_pokemon/src/presentation/pages/pokemon_type_detail_page.dart';
import 'package:feature_pokemon/src/presentation/pages/resource_index_page.dart';
import 'package:feature_pokemon/src/presentation/pages/resource_list_page.dart';
import 'package:feature_pokemon/src/presentation/pages/stat_detail_page.dart';
import 'package:feature_pokemon/src/presentation/utils/resource_catalog.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';

export 'src/domain/entities/pokemon.dart';
export 'src/domain/entities/pokemon_detail.dart';
export 'src/presentation/pages/pokemon_detail_page.dart';
export 'src/presentation/pages/pokemon_page.dart';
export 'src/presentation/pages/resource_index_page.dart';

class PokemonModule extends Module {
  @override
  void routes(RouteManager r) {
    r
      // /pokemon
      ..child('/', child: (_) => const PokemonPage())
      // /pokemon/resources — single entry point listing reference resources.
      ..child('/resources', child: (_) => const ResourceIndexPage())
      // /pokemon/resources/:segment — generic list for a resource.
      ..child(
        '/resources/:segment',
        child: (context) {
          final segment = r.args.params['segment'] as String;
          final descriptor = _descriptorForSegment(segment);
          return ResourceListPage(descriptor: descriptor);
        },
      )
      // /pokemon/resources/:segment/:id — resource-specific detail page.
      ..child(
        '/resources/:segment/:id',
        child: (context) {
          final segment = r.args.params['segment'] as String;
          final id = r.args.params['id'] as String;
          return _detailForSegment(segment, id);
        },
      )
      // /pokemon/:name — existing Pokémon detail (kept last so the literal
      // '/resources' routes above take precedence).
      ..child(
        '/:name',
        child: (context) {
          final name = r.args.params['name'] as String;
          return PokemonDetailPage(name: name);
        },
      );
  }

  ResourceDescriptor _descriptorForSegment(String segment) =>
      kPokemonResources.firstWhere(
        (d) => d.routeSegment == segment,
        orElse: () => kPokemonResources.first,
      );

  Widget _detailForSegment(String segment, String id) {
    switch (segment) {
      case 'abilities':
        return AbilityDetailPage(idOrName: id);
      case 'types':
        return PokemonTypeDetailPage(idOrName: id);
      case 'natures':
        return NatureDetailPage(idOrName: id);
      case 'egg-groups':
        return EggGroupDetailPage(idOrName: id);
      case 'growth-rates':
        return GrowthRateDetailPage(idOrName: id);
      case 'stats':
        return StatDetailPage(idOrName: id);
      case 'colors':
        return PokemonColorDetailPage(idOrName: id);
      case 'shapes':
        return PokemonShapeDetailPage(idOrName: id);
      case 'habitats':
        return PokemonHabitatDetailPage(idOrName: id);
      case 'forms':
        return PokemonFormDetailPage(idOrName: id);
      case 'species':
        return PokemonSpeciesDetailPage(idOrName: id);
      case 'genders':
        return GenderDetailPage(idOrName: id);
      case 'pokeathlon-stats':
        return PokeathlonStatDetailPage(idOrName: id);
      case 'characteristics':
        return CharacteristicDetailPage(id: int.tryParse(id) ?? 1);
      default:
        return AbilityDetailPage(idOrName: id);
    }
  }
}
