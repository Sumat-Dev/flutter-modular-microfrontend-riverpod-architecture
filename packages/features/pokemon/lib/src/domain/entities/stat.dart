import 'package:equatable/equatable.dart';

import 'package:feature_pokemon/src/domain/entities/common/named_api_resource.dart';

/// `/stat/{id or name}`.
class Stat extends Equatable {
  const Stat({
    required this.id,
    required this.name,
    required this.gameIndex,
    required this.isBattleOnly,
    this.displayName,
    this.moveDamageClass,
  });

  final int id;
  final String name;
  final int gameIndex;
  final bool isBattleOnly;
  final String? displayName;
  final NamedApiResource? moveDamageClass;

  @override
  List<Object?> get props => [
    id,
    name,
    gameIndex,
    isBattleOnly,
    displayName,
    moveDamageClass,
  ];
}
