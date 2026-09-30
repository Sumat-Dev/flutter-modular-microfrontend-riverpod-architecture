// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_detail_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(itemDetail)
const itemDetailProvider = ItemDetailFamily._();

final class ItemDetailProvider
    extends
        $FunctionalProvider<
          AsyncValue<ItemDetail>,
          ItemDetail,
          FutureOr<ItemDetail>
        >
    with $FutureModifier<ItemDetail>, $FutureProvider<ItemDetail> {
  const ItemDetailProvider._({
    required ItemDetailFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'itemDetailProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$itemDetailHash();

  @override
  String toString() {
    return r'itemDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<ItemDetail> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<ItemDetail> create(Ref ref) {
    final argument = this.argument as String;
    return itemDetail(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ItemDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$itemDetailHash() => r'ee1c31a406c2597803cd708cc1e98d8ffd096dc9';

final class ItemDetailFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<ItemDetail>, String> {
  const ItemDetailFamily._()
    : super(
        retry: null,
        name: r'itemDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  ItemDetailProvider call(String name) =>
      ItemDetailProvider._(argument: name, from: this);

  @override
  String toString() => r'itemDetailProvider';
}
