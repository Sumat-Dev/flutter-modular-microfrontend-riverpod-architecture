import 'package:equatable/equatable.dart';

import 'package:feature_pokemon/src/domain/entities/common/named_api_resource.dart';

/// `/characteristic/{id}` — note: characteristics have NO `name`, only an id.
class Characteristic extends Equatable {
  const Characteristic({
    required this.id,
    required this.geneModulo,
    required this.possibleValues,
    required this.highestStat,
    this.description,
  });

  final int id;
  final int geneModulo;
  final List<int> possibleValues;
  final NamedApiResource highestStat;

  /// English description, e.g. "Loves to eat".
  final String? description;

  @override
  List<Object?> get props => [
    id,
    geneModulo,
    possibleValues,
    highestStat,
    description,
  ];
}
