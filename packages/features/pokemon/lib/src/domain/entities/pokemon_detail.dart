import 'package:equatable/equatable.dart';

import 'package:feature_pokemon/src/domain/entities/pokemon.dart';

/// Full Pokemon detail entity used on the detail page.
class PokemonDetail extends Equatable {
  const PokemonDetail({
    required this.id,
    required this.name,
    required this.height,
    required this.weight,
    required this.types,
    required this.stats,
  });

  final int id;
  final String name;
  final int height;
  final int weight;
  final List<String> types;
  final List<PokemonStat> stats;

  Pokemon get summary => Pokemon(id: id, name: name);

  String get imageUrl => summary.imageUrl;

  @override
  List<Object?> get props => [id, name, height, weight, types, stats];
}

/// A single base stat (e.g. hp, attack).
class PokemonStat extends Equatable {
  const PokemonStat({required this.name, required this.baseValue});

  final String name;
  final int baseValue;

  @override
  List<Object?> get props => [name, baseValue];
}
