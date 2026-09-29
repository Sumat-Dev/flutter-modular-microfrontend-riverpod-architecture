import 'package:equatable/equatable.dart';

import 'package:feature_berries/src/domain/entities/berry.dart';

/// Full berry details as returned by `GET /berry/{id or name}`.
class BerryDetail extends Equatable {
  const BerryDetail({
    required this.id,
    required this.name,
    required this.growthTime,
    required this.maxHarvest,
    required this.naturalGiftPower,
    required this.size,
    required this.smoothness,
    required this.soilDryness,
    required this.firmness,
    required this.naturalGiftType,
    required this.flavors,
  });

  final int id;
  final String name;
  final int growthTime;
  final int maxHarvest;
  final int naturalGiftPower;
  final int size;
  final int smoothness;
  final int soilDryness;

  /// e.g. `soft`, `hard`, `super-hard`.
  final String firmness;

  /// Elemental type granted by the move Natural Gift, e.g. `fire`.
  final String naturalGiftType;

  final List<BerryFlavor> flavors;

  Berry get summary => Berry(id: id, name: name);

  @override
  List<Object?> get props => [
    id,
    name,
    growthTime,
    maxHarvest,
    naturalGiftPower,
    size,
    smoothness,
    soilDryness,
    firmness,
    naturalGiftType,
    flavors,
  ];
}

/// A flavor and its potency for a given berry.
class BerryFlavor extends Equatable {
  const BerryFlavor({required this.flavor, required this.potency});

  /// e.g. `spicy`, `dry`, `sweet`, `bitter`, `sour`.
  final String flavor;
  final int potency;

  @override
  List<Object?> get props => [flavor, potency];
}
