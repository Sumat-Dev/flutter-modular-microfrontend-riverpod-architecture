// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'growth_rate_detail_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(growthRateDetail)
const growthRateDetailProvider = GrowthRateDetailFamily._();

final class GrowthRateDetailProvider
    extends
        $FunctionalProvider<
          AsyncValue<GrowthRate>,
          GrowthRate,
          FutureOr<GrowthRate>
        >
    with $FutureModifier<GrowthRate>, $FutureProvider<GrowthRate> {
  const GrowthRateDetailProvider._({
    required GrowthRateDetailFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'growthRateDetailProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$growthRateDetailHash();

  @override
  String toString() {
    return r'growthRateDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<GrowthRate> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<GrowthRate> create(Ref ref) {
    final argument = this.argument as String;
    return growthRateDetail(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is GrowthRateDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$growthRateDetailHash() => r'a324e7f779f1e0dfc111916ea58018732bfab937';

final class GrowthRateDetailFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<GrowthRate>, String> {
  const GrowthRateDetailFamily._()
    : super(
        retry: null,
        name: r'growthRateDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  GrowthRateDetailProvider call(String idOrName) =>
      GrowthRateDetailProvider._(argument: idOrName, from: this);

  @override
  String toString() => r'growthRateDetailProvider';
}
