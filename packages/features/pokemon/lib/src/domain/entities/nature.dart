import 'package:equatable/equatable.dart';

import 'package:feature_pokemon/src/domain/entities/common/named_api_resource.dart';

/// `/nature/{id or name}`.
class Nature extends Equatable {
  const Nature({
    required this.id,
    required this.name,
    this.displayName,
    this.decreasedStat,
    this.increasedStat,
    this.hatesFlavor,
    this.likesFlavor,
    this.pokeathlonStatChanges = const [],
  });

  final int id;
  final String name;
  final String? displayName;
  final NamedApiResource? decreasedStat;
  final NamedApiResource? increasedStat;
  final NamedApiResource? hatesFlavor;
  final NamedApiResource? likesFlavor;
  final List<NaturePokeathlonStatChange> pokeathlonStatChanges;

  @override
  List<Object?> get props => [
    id,
    name,
    displayName,
    decreasedStat,
    increasedStat,
    hatesFlavor,
    likesFlavor,
    pokeathlonStatChanges,
  ];
}

/// A pokéathlon stat change granted by this nature.
class NaturePokeathlonStatChange extends Equatable {
  const NaturePokeathlonStatChange({
    required this.maxChange,
    required this.pokeathlonStat,
  });

  final int maxChange;
  final NamedApiResource pokeathlonStat;

  @override
  List<Object?> get props => [maxChange, pokeathlonStat];
}
