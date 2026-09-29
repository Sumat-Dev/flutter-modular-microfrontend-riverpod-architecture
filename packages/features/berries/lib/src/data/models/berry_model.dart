import 'package:core/core.dart';
import 'package:feature_berries/src/domain/entities/berry.dart';
import 'package:json_annotation/json_annotation.dart';

part 'berry_model.g.dart';

@JsonSerializable()
class BerryModel {
  const BerryModel({required this.id, required this.name});

  factory BerryModel.fromJson(DataMap json) => _$BerryModelFromJson(json);

  factory BerryModel.fromCacheJson(DataMap json) => BerryModel.fromJson(json);

  factory BerryModel.fromListJson(DataMap json) {
    final name = json['name'] as String;
    final url = json['url'] as String;
    return BerryModel(id: _idFromUrl(url), name: name);
  }

  final int id;
  final String name;

  Berry toEntity() => Berry(id: id, name: name);

  DataMap toJson() => _$BerryModelToJson(this);

  static int _idFromUrl(String url) {
    final segments = url.split('/').where((s) => s.isNotEmpty).toList();
    final last = segments.isNotEmpty ? segments.last : '';
    return int.tryParse(last) ?? 0;
  }
}
