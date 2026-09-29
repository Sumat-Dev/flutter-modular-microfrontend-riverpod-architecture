import 'package:feature_berries/src/data/datasources/berry_local_data_source.dart';
import 'package:feature_berries/src/data/datasources/berry_remote_data_source.dart';
import 'package:feature_berries/src/data/repositories/berry_repository_impl.dart';
import 'package:feature_berries/src/domain/repositories/berry_repository.dart';
import 'package:feature_berries/src/domain/usecases/get_berry.dart';
import 'package:feature_berries/src/domain/usecases/get_berry_list.dart';
import 'package:network/network.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:storage/storage.dart';

part 'berry_providers.g.dart';

@Riverpod(keepAlive: true)
ApiClient apiClient(Ref ref) => DioApiClient();

@Riverpod(keepAlive: true)
KeyValueStore keyValueStore(Ref ref) => InMemoryKeyValueStore();

@Riverpod(keepAlive: true)
BerryRemoteDataSource berryRemoteDataSource(Ref ref) =>
    BerryRemoteDataSourceImpl(ref.watch(apiClientProvider));

@Riverpod(keepAlive: true)
BerryLocalDataSource berryLocalDataSource(Ref ref) =>
    BerryLocalDataSourceImpl(ref.watch(keyValueStoreProvider));

@Riverpod(keepAlive: true)
BerryRepository berryRepository(Ref ref) => BerryRepositoryImpl(
  remote: ref.watch(berryRemoteDataSourceProvider),
  local: ref.watch(berryLocalDataSourceProvider),
);

@Riverpod(keepAlive: true)
GetBerryList getBerryList(Ref ref) =>
    GetBerryList(ref.watch(berryRepositoryProvider));

@Riverpod(keepAlive: true)
GetBerry getBerry(Ref ref) => GetBerry(ref.watch(berryRepositoryProvider));
