import 'package:equatable/equatable.dart';

class Pokemon extends Equatable {
  const Pokemon({required this.id, required this.name});

  final int id;
  final String name;

  String get imageUrl =>
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png';

  @override
  List<Object?> get props => [id, name];
}
