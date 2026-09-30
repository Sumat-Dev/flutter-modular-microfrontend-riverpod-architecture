// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(apiClient)
const apiClientProvider = ApiClientProvider._();

final class ApiClientProvider
    extends $FunctionalProvider<ApiClient, ApiClient, ApiClient>
    with $Provider<ApiClient> {
  const ApiClientProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'apiClientProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$apiClientHash();

  @$internal
  @override
  $ProviderElement<ApiClient> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ApiClient create(Ref ref) {
    return apiClient(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ApiClient value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ApiClient>(value),
    );
  }
}

String _$apiClientHash() => r'5d833c536c59b343477ab74e766896cdbdcf15c7';

@ProviderFor(keyValueStore)
const keyValueStoreProvider = KeyValueStoreProvider._();

final class KeyValueStoreProvider
    extends $FunctionalProvider<KeyValueStore, KeyValueStore, KeyValueStore>
    with $Provider<KeyValueStore> {
  const KeyValueStoreProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'keyValueStoreProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$keyValueStoreHash();

  @$internal
  @override
  $ProviderElement<KeyValueStore> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  KeyValueStore create(Ref ref) {
    return keyValueStore(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(KeyValueStore value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<KeyValueStore>(value),
    );
  }
}

String _$keyValueStoreHash() => r'cda52d16188a68d8b40135477b1b1f16a7ddc0c1';

@ProviderFor(itemRemoteDataSource)
const itemRemoteDataSourceProvider = ItemRemoteDataSourceProvider._();

final class ItemRemoteDataSourceProvider
    extends
        $FunctionalProvider<
          ItemRemoteDataSource,
          ItemRemoteDataSource,
          ItemRemoteDataSource
        >
    with $Provider<ItemRemoteDataSource> {
  const ItemRemoteDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'itemRemoteDataSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$itemRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<ItemRemoteDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ItemRemoteDataSource create(Ref ref) {
    return itemRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ItemRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ItemRemoteDataSource>(value),
    );
  }
}

String _$itemRemoteDataSourceHash() =>
    r'fd289605137a82cd7ad817952a6c74cb20c284e5';

@ProviderFor(itemLocalDataSource)
const itemLocalDataSourceProvider = ItemLocalDataSourceProvider._();

final class ItemLocalDataSourceProvider
    extends
        $FunctionalProvider<
          ItemLocalDataSource,
          ItemLocalDataSource,
          ItemLocalDataSource
        >
    with $Provider<ItemLocalDataSource> {
  const ItemLocalDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'itemLocalDataSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$itemLocalDataSourceHash();

  @$internal
  @override
  $ProviderElement<ItemLocalDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ItemLocalDataSource create(Ref ref) {
    return itemLocalDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ItemLocalDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ItemLocalDataSource>(value),
    );
  }
}

String _$itemLocalDataSourceHash() =>
    r'711bb160d6b8ec2d12806e554425d100ddb7c7c1';

@ProviderFor(itemRepository)
const itemRepositoryProvider = ItemRepositoryProvider._();

final class ItemRepositoryProvider
    extends $FunctionalProvider<ItemRepository, ItemRepository, ItemRepository>
    with $Provider<ItemRepository> {
  const ItemRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'itemRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$itemRepositoryHash();

  @$internal
  @override
  $ProviderElement<ItemRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ItemRepository create(Ref ref) {
    return itemRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ItemRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ItemRepository>(value),
    );
  }
}

String _$itemRepositoryHash() => r'81d915386ef731783e2201d81dcbd7982c013c40';

@ProviderFor(getItemList)
const getItemListProvider = GetItemListProvider._();

final class GetItemListProvider
    extends $FunctionalProvider<GetItemList, GetItemList, GetItemList>
    with $Provider<GetItemList> {
  const GetItemListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getItemListProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getItemListHash();

  @$internal
  @override
  $ProviderElement<GetItemList> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GetItemList create(Ref ref) {
    return getItemList(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetItemList value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetItemList>(value),
    );
  }
}

String _$getItemListHash() => r'21e4422df6e98f652c363afbeee3d07f87a292a8';

@ProviderFor(getItem)
const getItemProvider = GetItemProvider._();

final class GetItemProvider
    extends $FunctionalProvider<GetItem, GetItem, GetItem>
    with $Provider<GetItem> {
  const GetItemProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getItemProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getItemHash();

  @$internal
  @override
  $ProviderElement<GetItem> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GetItem create(Ref ref) {
    return getItem(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetItem value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetItem>(value),
    );
  }
}

String _$getItemHash() => r'4e132c224a2fd7308fe46e71e7f0d6017cf6e0b8';
