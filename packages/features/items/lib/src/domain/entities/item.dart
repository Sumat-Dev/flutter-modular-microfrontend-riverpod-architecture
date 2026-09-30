import 'package:equatable/equatable.dart';

/// Lightweight item summary used in list views.
class Item extends Equatable {
  const Item({required this.id, required this.name});

  final int id;
  final String name;

  /// Official item sprite. PokeAPI names sprites by the item's slug.
  String get imageUrl =>
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/items/$name.png';

  @override
  List<Object?> get props => [id, name];
}
