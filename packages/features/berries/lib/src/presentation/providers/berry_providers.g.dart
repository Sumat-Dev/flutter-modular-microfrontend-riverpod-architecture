// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'berry_providers.dart';

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

@ProviderFor(berryRemoteDataSource)
const berryRemoteDataSourceProvider = BerryRemoteDataSourceProvider._();

final class BerryRemoteDataSourceProvider
    extends
        $FunctionalProvider<
          BerryRemoteDataSource,
          BerryRemoteDataSource,
          BerryRemoteDataSource
        >
    with $Provider<BerryRemoteDataSource> {
  const BerryRemoteDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'berryRemoteDataSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$berryRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<BerryRemoteDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  BerryRemoteDataSource create(Ref ref) {
    return berryRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BerryRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BerryRemoteDataSource>(value),
    );
  }
}

String _$berryRemoteDataSourceHash() =>
    r'd8b09af82d072c65e55a13bf6d142314d46b4f9a';

@ProviderFor(berryRepository)
const berryRepositoryProvider = BerryRepositoryProvider._();

final class BerryRepositoryProvider
    extends
        $FunctionalProvider<BerryRepository, BerryRepository, BerryRepository>
    with $Provider<BerryRepository> {
  const BerryRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'berryRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$berryRepositoryHash();

  @$internal
  @override
  $ProviderElement<BerryRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  BerryRepository create(Ref ref) {
    return berryRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BerryRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BerryRepository>(value),
    );
  }
}

String _$berryRepositoryHash() => r'083d5635f86a038ee83dc972aec7178e9cc09338';

@ProviderFor(getBerryList)
const getBerryListProvider = GetBerryListProvider._();

final class GetBerryListProvider
    extends $FunctionalProvider<GetBerryList, GetBerryList, GetBerryList>
    with $Provider<GetBerryList> {
  const GetBerryListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getBerryListProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getBerryListHash();

  @$internal
  @override
  $ProviderElement<GetBerryList> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GetBerryList create(Ref ref) {
    return getBerryList(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetBerryList value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetBerryList>(value),
    );
  }
}

String _$getBerryListHash() => r'f3f5ef89730ab7e0dd2babb8b0e4607d6d8752a3';

@ProviderFor(getBerry)
const getBerryProvider = GetBerryProvider._();

final class GetBerryProvider
    extends $FunctionalProvider<GetBerry, GetBerry, GetBerry>
    with $Provider<GetBerry> {
  const GetBerryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getBerryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getBerryHash();

  @$internal
  @override
  $ProviderElement<GetBerry> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GetBerry create(Ref ref) {
    return getBerry(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetBerry value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetBerry>(value),
    );
  }
}

String _$getBerryHash() => r'20ca066eeae0381f2eef0d08c2ae7c7b9a5ca22f';
