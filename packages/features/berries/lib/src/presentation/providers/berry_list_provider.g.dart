// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'berry_list_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(BerryList)
const berryListProvider = BerryListProvider._();

final class BerryListProvider
    extends $AsyncNotifierProvider<BerryList, BerryListState> {
  const BerryListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'berryListProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$berryListHash();

  @$internal
  @override
  BerryList create() => BerryList();
}

String _$berryListHash() => r'df085211d13309a6cf2dcc64e84601dcf5c13527';

abstract class _$BerryList extends $AsyncNotifier<BerryListState> {
  FutureOr<BerryListState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<BerryListState>, BerryListState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<BerryListState>, BerryListState>,
              AsyncValue<BerryListState>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
