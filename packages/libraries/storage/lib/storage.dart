/// storage
///
/// A generic key/value cache abstraction. Feature local datasources depend on
/// [KeyValueStore]; the concrete backend (in-memory, Hive, sqflite, ...) is an
/// implementation detail chosen at composition time.
library;

import 'package:storage/src/key_value_store.dart' show KeyValueStore;
import 'package:storage/storage.dart' show KeyValueStore;

export 'src/in_memory_key_value_store.dart';
export 'src/key_value_store.dart';
