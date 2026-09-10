import 'package:core/core.dart';

import 'key_value_store.dart';

/// Default in-memory [KeyValueStore]. Suitable for the golden feature and
/// tests; can be swapped for a persistent backend without touching features.
class InMemoryKeyValueStore implements KeyValueStore {
  final Map<String, Map<String, dynamic>> _store = {};

  @override
  Future<void> clear() async => _store.clear();

  @override
  Future<void> delete(String key) async => _store.remove(key);

  @override
  Future<Map<String, dynamic>?> read(String key) async {
    try {
      return _store[key];
    } on Object catch (e) {
      throw CacheException(message: 'Failed to read cache key "$key": $e');
    }
  }

  @override
  Future<void> write(String key, Map<String, dynamic> value) async {
    try {
      _store[key] = value;
    } on Object catch (e) {
      throw CacheException(message: 'Failed to write cache key "$key": $e');
    }
  }
}
