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

String _$itemRepositoryHash() => r'd761040fd910b9ae12b3b93ef323050dc6733b9c';

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
