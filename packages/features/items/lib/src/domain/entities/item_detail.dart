import 'package:equatable/equatable.dart';

import 'package:feature_items/src/domain/entities/item.dart';

/// Full item details as returned by `GET /item/{id or name}`.
class ItemDetail extends Equatable {
  const ItemDetail({
    required this.id,
    required this.name,
    required this.cost,
    required this.category,
    required this.attributes,
    required this.effect,
    this.flingPower,
    this.spriteUrl,
  });

  final int id;
  final String name;
  final int cost;

  /// e.g. `standard-balls`, `stat-boosts`.
  final String category;

  /// e.g. `holdable`, `countable`, `usable-in-battle`.
  final List<String> attributes;

  /// English short effect text (falls back to empty when unavailable).
  final String effect;

  /// Power of the move Fling when this item is used. Null when not flingable.
  final int? flingPower;

  /// Default sprite URL from the API; falls back to [Item.imageUrl].
  final String? spriteUrl;

  Item get summary => Item(id: id, name: name);

  String get imageUrl => spriteUrl ?? summary.imageUrl;

  @override
  List<Object?> get props => [
    id,
    name,
    cost,
    category,
    attributes,
    effect,
    flingPower,
    spriteUrl,
  ];
}
