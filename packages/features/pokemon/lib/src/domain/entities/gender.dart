import 'package:equatable/equatable.dart';

import 'package:feature_pokemon/src/domain/entities/common/named_api_resource.dart';

/// `/gender/{id or name}`.
class Gender extends Equatable {
  const Gender({
    required this.id,
    required this.name,
    this.pokemonSpeciesDetails = const [],
    this.requiredForEvolution = const [],
  });

  final int id;
  final String name;
  final List<GenderSpeciesDetail> pokemonSpeciesDetails;
  final List<NamedApiResource> requiredForEvolution;

  @override
  List<Object?> get props => [
    id,
    name,
    pokemonSpeciesDetails,
    requiredForEvolution,
  ];
}

/// A species that can be this gender, with its chance rate.
class GenderSpeciesDetail extends Equatable {
  const GenderSpeciesDetail({
    required this.rate,
    required this.pokemonSpecies,
  });

  final int rate;
  final NamedApiResource pokemonSpecies;

  @override
  List<Object?> get props => [rate, pokemonSpecies];
}
