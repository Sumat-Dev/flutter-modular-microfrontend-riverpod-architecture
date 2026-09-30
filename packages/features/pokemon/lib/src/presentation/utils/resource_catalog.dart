import 'package:equatable/equatable.dart';

/// Static metadata describing a browseable PokéAPI reference resource.
///
/// Drives the shared resource-index and list pages so we don't hand-write 14
/// near-identical list screens.
class ResourceDescriptor extends Equatable {
  const ResourceDescriptor({
    required this.title,
    required this.apiPath,
    required this.routeSegment,
  });

  /// Human-friendly plural title, e.g. "Abilities".
  final String title;

  /// PokéAPI list path, e.g. 'ability'.
  final String apiPath;

  /// Route segment under `/pokemon/resources/`, e.g. 'abilities'.
  final String routeSegment;

  @override
  List<Object?> get props => [title, apiPath, routeSegment];
}

/// The 14 browseable reference resources exposed under the Resources index.
const kPokemonResources = <ResourceDescriptor>[
  ResourceDescriptor(
    title: 'Abilities',
    apiPath: 'ability',
    routeSegment: 'abilities',
  ),
  ResourceDescriptor(title: 'Types', apiPath: 'type', routeSegment: 'types'),
  ResourceDescriptor(
    title: 'Natures',
    apiPath: 'nature',
    routeSegment: 'natures',
  ),
  ResourceDescriptor(
    title: 'Egg Groups',
    apiPath: 'egg-group',
    routeSegment: 'egg-groups',
  ),
  ResourceDescriptor(
    title: 'Growth Rates',
    apiPath: 'growth-rate',
    routeSegment: 'growth-rates',
  ),
  ResourceDescriptor(title: 'Stats', apiPath: 'stat', routeSegment: 'stats'),
  ResourceDescriptor(
    title: 'Colors',
    apiPath: 'pokemon-color',
    routeSegment: 'colors',
  ),
  ResourceDescriptor(
    title: 'Shapes',
    apiPath: 'pokemon-shape',
    routeSegment: 'shapes',
  ),
  ResourceDescriptor(
    title: 'Habitats',
    apiPath: 'pokemon-habitat',
    routeSegment: 'habitats',
  ),
  ResourceDescriptor(
    title: 'Forms',
    apiPath: 'pokemon-form',
    routeSegment: 'forms',
  ),
  ResourceDescriptor(
    title: 'Species',
    apiPath: 'pokemon-species',
    routeSegment: 'species',
  ),
  ResourceDescriptor(
    title: 'Genders',
    apiPath: 'gender',
    routeSegment: 'genders',
  ),
  ResourceDescriptor(
    title: 'Pokeathlon Stats',
    apiPath: 'pokeathlon-stat',
    routeSegment: 'pokeathlon-stats',
  ),
  ResourceDescriptor(
    title: 'Characteristics',
    apiPath: 'characteristic',
    routeSegment: 'characteristics',
  ),
];
