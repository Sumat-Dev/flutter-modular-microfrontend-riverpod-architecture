import 'package:feature_items/src/data/datasources/item_remote_data_source.dart';
import 'package:feature_items/src/data/repositories/item_repository_impl.dart';
import 'package:feature_items/src/domain/repositories/item_repository.dart';
import 'package:feature_items/src/domain/usecases/get_item.dart';
import 'package:feature_items/src/domain/usecases/get_item_list.dart';
import 'package:network/network.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'item_providers.g.dart';

@Riverpod(keepAlive: true)
ApiClient apiClient(Ref ref) => DioApiClient();

@Riverpod(keepAlive: true)
ItemRemoteDataSource itemRemoteDataSource(Ref ref) =>
    ItemRemoteDataSourceImpl(ref.watch(apiClientProvider));

@Riverpod(keepAlive: true)
ItemRepository itemRepository(Ref ref) =>
    ItemRepositoryImpl(remote: ref.watch(itemRemoteDataSourceProvider));

@Riverpod(keepAlive: true)
GetItemList getItemList(Ref ref) =>
    GetItemList(ref.watch(itemRepositoryProvider));

@Riverpod(keepAlive: true)
GetItem getItem(Ref ref) => GetItem(ref.watch(itemRepositoryProvider));
