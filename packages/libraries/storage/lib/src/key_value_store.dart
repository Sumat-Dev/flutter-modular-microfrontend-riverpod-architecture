/// Generic string-keyed cache. Values are JSON-serialisable maps so any
/// feature can store its models without leaking domain types into storage.
abstract interface class KeyValueStore {
  Future<Map<String, dynamic>?> read(String key);

  Future<void> write(String key, Map<String, dynamic> value);

  Future<void> delete(String key);

  Future<void> clear();
}
