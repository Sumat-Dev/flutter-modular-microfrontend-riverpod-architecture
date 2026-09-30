import 'package:equatable/equatable.dart';

import 'package:feature_pokemon/src/domain/entities/common/named_api_resource.dart';

/// `/egg-group/{id or name}`.
class EggGroup extends Equatable {
  const EggGroup({
    required this.id,
    required this.name,
    this.displayName,
    this.pokemonSpecies = const [],
  });

  final int id;
  final String name;
  final String? displayName;
  final List<NamedApiResource> pokemonSpecies;

  @override
  List<Object?> get props => [id, name, displayName, pokemonSpecies];
}
