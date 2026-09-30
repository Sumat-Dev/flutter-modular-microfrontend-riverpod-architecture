import 'package:core/core.dart';
import 'package:feature_items/src/data/models/item_detail_model.dart';
import 'package:feature_items/src/data/models/item_model.dart';
import 'package:network/network.dart';

abstract interface class ItemRemoteDataSource {
  Future<({int count, String? next, String? previous, List<ItemModel> items})>
  fetchItemList({required int offset, required int limit});

  Future<ItemDetailModel> fetchItem(String name);
}

class ItemRemoteDataSourceImpl implements ItemRemoteDataSource {
  const ItemRemoteDataSourceImpl(this._client);

  final ApiClient _client;

  @override
  Future<({int count, String? next, String? previous, List<ItemModel> items})>
  fetchItemList({required int offset, required int limit}) async {
    final json = await _client.get<DataMap>(
      'item',
      queryParameters: {'offset': offset, 'limit': limit},
    );
    try {
      final results = (json['results'] as List<dynamic>)
          .map((dynamic e) => ItemModel.fromListJson(e as DataMap))
          .toList();
      return (
        count: json['count'] as int,
        next: json['next'] as String?,
        previous: json['previous'] as String?,
        items: results,
      );
    } on Object catch (e) {
      throw ParsingException(message: 'Failed to parse Item list: $e');
    }
  }

  @override
  Future<ItemDetailModel> fetchItem(String name) async {
    final json = await _client.get<DataMap>('item/$name');
    try {
      return ItemDetailModel.fromJson(json);
    } on Object catch (e) {
      throw ParsingException(message: 'Failed to parse Item "$name": $e');
    }
  }
}
