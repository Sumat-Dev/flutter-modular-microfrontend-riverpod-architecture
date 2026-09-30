import 'package:core/core.dart';
import 'package:feature_items/src/domain/entities/item.dart';
import 'package:json_annotation/json_annotation.dart';

part 'item_model.g.dart';

@JsonSerializable()
class ItemModel {
  const ItemModel({required this.id, required this.name});

  factory ItemModel.fromJson(DataMap json) => _$ItemModelFromJson(json);

  factory ItemModel.fromCacheJson(DataMap json) => ItemModel.fromJson(json);

  factory ItemModel.fromListJson(DataMap json) {
    final name = json['name'] as String;
    final url = json['url'] as String;
    return ItemModel(id: _idFromUrl(url), name: name);
  }

  final int id;
  final String name;

  Item toEntity() => Item(id: id, name: name);

  DataMap toJson() => _$ItemModelToJson(this);

  static int _idFromUrl(String url) {
    final segments = url.split('/').where((s) => s.isNotEmpty).toList();
    final last = segments.isNotEmpty ? segments.last : '';
    return int.tryParse(last) ?? 0;
  }
}
