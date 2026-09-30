import 'package:equatable/equatable.dart';

import 'package:feature_pokemon/src/domain/entities/common/named_api_resource.dart';

/// `/type/{id or name}`.
class PokemonType extends Equatable {
  const PokemonType({
    required this.id,
    required this.name,
    required this.damageRelations,
    this.displayName,
    this.generation,
    this.moveDamageClass,
    this.pokemon = const [],
  });

  final int id;
  final String name;
  final TypeDamageRelations damageRelations;
  final String? displayName;
  final NamedApiResource? generation;
  final NamedApiResource? moveDamageClass;
  final List<NamedApiResource> pokemon;

  @override
  List<Object?> get props => [
    id,
    name,
    damageRelations,
    displayName,
    generation,
    moveDamageClass,
    pokemon,
  ];
}

/// The effectiveness of this type against/from other types.
class TypeDamageRelations extends Equatable {
  const TypeDamageRelations({
    this.noDamageTo = const [],
    this.halfDamageTo = const [],
    this.doubleDamageTo = const [],
    this.noDamageFrom = const [],
    this.halfDamageFrom = const [],
    this.doubleDamageFrom = const [],
  });

  final List<NamedApiResource> noDamageTo;
  final List<NamedApiResource> halfDamageTo;
  final List<NamedApiResource> doubleDamageTo;
  final List<NamedApiResource> noDamageFrom;
  final List<NamedApiResource> halfDamageFrom;
  final List<NamedApiResource> doubleDamageFrom;

  @override
  List<Object?> get props => [
    noDamageTo,
    halfDamageTo,
    doubleDamageTo,
    noDamageFrom,
    halfDamageFrom,
    doubleDamageFrom,
  ];
}
