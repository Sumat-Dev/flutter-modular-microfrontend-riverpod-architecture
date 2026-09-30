import 'package:equatable/equatable.dart';

import 'package:feature_pokemon/src/domain/entities/common/named_api_resource.dart';

/// `/pokemon-form/{id or name}`.
class PokemonForm extends Equatable {
  const PokemonForm({
    required this.id,
    required this.name,
    required this.order,
    required this.formOrder,
    required this.isDefault,
    required this.isBattleOnly,
    required this.isMega,
    required this.formName,
    this.pokemon,
    this.types = const [],
    this.spriteUrl,
  });

  final int id;
  final String name;
  final int order;
  final int formOrder;
  final bool isDefault;
  final bool isBattleOnly;
  final bool isMega;
  final String formName;
  final NamedApiResource? pokemon;
  final List<String> types;
  final String? spriteUrl;

  @override
  List<Object?> get props => [
    id,
    name,
    order,
    formOrder,
    isDefault,
    isBattleOnly,
    isMega,
    formName,
    pokemon,
    types,
    spriteUrl,
  ];
}
