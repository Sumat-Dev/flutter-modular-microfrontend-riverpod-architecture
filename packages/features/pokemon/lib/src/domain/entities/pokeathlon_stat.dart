import 'package:equatable/equatable.dart';

/// `/pokeathlon-stat/{id or name}`.
class PokeathlonStat extends Equatable {
  const PokeathlonStat({
    required this.id,
    required this.name,
    this.displayName,
  });

  final int id;
  final String name;
  final String? displayName;

  @override
  List<Object?> get props => [id, name, displayName];
}
