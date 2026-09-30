// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_list_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ItemList)
const itemListProvider = ItemListProvider._();

final class ItemListProvider
    extends $AsyncNotifierProvider<ItemList, ItemListState> {
  const ItemListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'itemListProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$itemListHash();

  @$internal
  @override
  ItemList create() => ItemList();
}

String _$itemListHash() => r'529782125a2857e2a5c0340fa8b749318dead08a';

abstract class _$ItemList extends $AsyncNotifier<ItemListState> {
  FutureOr<ItemListState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<ItemListState>, ItemListState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<ItemListState>, ItemListState>,
              AsyncValue<ItemListState>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
