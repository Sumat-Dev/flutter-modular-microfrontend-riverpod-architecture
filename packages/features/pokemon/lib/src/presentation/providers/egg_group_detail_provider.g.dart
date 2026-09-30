// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'egg_group_detail_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(eggGroupDetail)
const eggGroupDetailProvider = EggGroupDetailFamily._();

final class EggGroupDetailProvider
    extends
        $FunctionalProvider<AsyncValue<EggGroup>, EggGroup, FutureOr<EggGroup>>
    with $FutureModifier<EggGroup>, $FutureProvider<EggGroup> {
  const EggGroupDetailProvider._({
    required EggGroupDetailFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'eggGroupDetailProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$eggGroupDetailHash();

  @override
  String toString() {
    return r'eggGroupDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<EggGroup> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<EggGroup> create(Ref ref) {
    final argument = this.argument as String;
    return eggGroupDetail(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is EggGroupDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$eggGroupDetailHash() => r'cce13f9d1ed4f075ab813931c17b6a3b5e27da7e';

final class EggGroupDetailFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<EggGroup>, String> {
  const EggGroupDetailFamily._()
    : super(
        retry: null,
        name: r'eggGroupDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  EggGroupDetailProvider call(String idOrName) =>
      EggGroupDetailProvider._(argument: idOrName, from: this);

  @override
  String toString() => r'eggGroupDetailProvider';
}
