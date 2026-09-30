import 'package:core/core.dart';
import 'package:feature_items/src/domain/entities/item_detail.dart';
import 'package:json_annotation/json_annotation.dart';

part 'item_detail_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ItemDetailModel {
  const ItemDetailModel({
    required this.id,
    required this.name,
    required this.cost,
    required this.category,
    required this.attributes,
    required this.effect,
    this.flingPower,
    this.spriteUrl,
  });

  factory ItemDetailModel.fromJson(DataMap json) =>
      _$ItemDetailModelFromJson(json);

  final int id;
  final String name;
  final int cost;

  @JsonKey(fromJson: _nameFromResource, toJson: _nameToResource)
  final String category;

  @JsonKey(fromJson: _attributesFromJson, toJson: _attributesToJson)
  final List<String> attributes;

  @JsonKey(
    name: 'effect_entries',
    fromJson: _effectFromJson,
    toJson: _effectToJson,
  )
  final String effect;

  @JsonKey(name: 'fling_power')
  final int? flingPower;

  @JsonKey(name: 'sprites', fromJson: _spriteFromJson, toJson: _spriteToJson)
  final String? spriteUrl;

  DataMap toJson() => _$ItemDetailModelToJson(this);

  ItemDetail toEntity() => ItemDetail(
    id: id,
    name: name,
    cost: cost,
    category: category,
    attributes: attributes,
    effect: effect,
    flingPower: flingPower,
    spriteUrl: spriteUrl,
  );

  static String _nameFromResource(DataMap resource) =>
      resource['name'] as String;

  static Map<String, dynamic> _nameToResource(String name) => {'name': name};

  static List<String> _attributesFromJson(List<dynamic>? raw) =>
      (raw ?? []).map((dynamic a) => (a as DataMap)['name'] as String).toList();

  static List<Map<String, dynamic>> _attributesToJson(List<String> attrs) =>
      attrs.map((a) => {'name': a}).toList();

  /// Picks the first English `short_effect`, falling back to the first entry.
  static String _effectFromJson(List<dynamic>? raw) {
    final entries = raw ?? [];
    if (entries.isEmpty) {
      return '';
    }
    final english = entries.cast<DataMap>().firstWhere(
      (e) => (e['language'] as DataMap?)?['name'] == 'en',
      orElse: () => entries.first as DataMap,
    );
    return (english['short_effect'] ?? english['effect'] ?? '') as String;
  }

  static List<Map<String, dynamic>> _effectToJson(String effect) => [
    {
      'effect': effect,
      'short_effect': effect,
      'language': {'name': 'en'},
    },
  ];

  static String? _spriteFromJson(DataMap? sprites) =>
      sprites?['default'] as String?;

  static Map<String, dynamic> _spriteToJson(String? url) => {'default': url};
}
