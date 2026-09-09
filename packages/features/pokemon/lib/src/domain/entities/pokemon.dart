import 'package:equatable/equatable.dart';

/// Lightweight Pokemon entity used in list views. Pure domain — no framework
/// imports.
class Pokemon extends Equatable {
  const Pokemon({required this.id, required this.name});

  final int id;
  final String name;

  /// Official artwork sprite URL, derived from the id.
  String get imageUrl =>
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png';

  @override
  List<Object?> get props => [id, name];
}
