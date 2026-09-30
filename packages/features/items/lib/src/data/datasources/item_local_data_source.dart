import 'package:core/core.dart';
import 'package:feature_items/src/data/models/item_detail_model.dart';
import 'package:storage/storage.dart';

abstract interface class ItemLocalDataSource {
  Future<ItemDetailModel?> readItem(String name);

  Future<void> writeItem(ItemDetailModel model);
}

class ItemLocalDataSourceImpl implements ItemLocalDataSource {
  const ItemLocalDataSourceImpl(this._store);

  final KeyValueStore _store;

  static String _key(String name) => 'item_detail_$name';

  @override
  Future<ItemDetailModel?> readItem(String name) async {
    final json = await _store.read(_key(name));
    if (json == null) {
      return null;
    }
    try {
      return ItemDetailModel.fromJson(json);
    } on Object catch (e) {
      throw CacheException(message: 'Corrupt cache for "$name": $e');
    }
  }

  @override
  Future<void> writeItem(ItemDetailModel model) =>
      _store.write(_key(model.name), model.toJson());
}
