import 'package:core/core.dart';
import 'package:feature_berries/src/data/models/berry_detail_model.dart';
import 'package:storage/storage.dart';

abstract interface class BerryLocalDataSource {
  Future<BerryDetailModel?> readBerry(String name);

  Future<void> writeBerry(BerryDetailModel model);
}

class BerryLocalDataSourceImpl implements BerryLocalDataSource {
  const BerryLocalDataSourceImpl(this._store);

  final KeyValueStore _store;

  static String _key(String name) => 'berry_detail_$name';

  @override
  Future<BerryDetailModel?> readBerry(String name) async {
    final json = await _store.read(_key(name));
    if (json == null) {
      return null;
    }
    try {
      return BerryDetailModel.fromJson(json);
    } on Object catch (e) {
      throw CacheException(message: 'Corrupt cache for "$name": $e');
    }
  }

  @override
  Future<void> writeBerry(BerryDetailModel model) =>
      _store.write(_key(model.name), model.toJson());
}
