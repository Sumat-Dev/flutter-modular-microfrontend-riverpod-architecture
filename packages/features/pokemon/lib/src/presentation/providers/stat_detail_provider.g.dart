// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stat_detail_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(statDetail)
const statDetailProvider = StatDetailFamily._();

final class StatDetailProvider
    extends $FunctionalProvider<AsyncValue<Stat>, Stat, FutureOr<Stat>>
    with $FutureModifier<Stat>, $FutureProvider<Stat> {
  const StatDetailProvider._({
    required StatDetailFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'statDetailProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$statDetailHash();

  @override
  String toString() {
    return r'statDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Stat> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Stat> create(Ref ref) {
    final argument = this.argument as String;
    return statDetail(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is StatDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$statDetailHash() => r'88fde69f55a046d87417c28f97babce37fc66c00';

final class StatDetailFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Stat>, String> {
  const StatDetailFamily._()
    : super(
        retry: null,
        name: r'statDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  StatDetailProvider call(String idOrName) =>
      StatDetailProvider._(argument: idOrName, from: this);

  @override
  String toString() => r'statDetailProvider';
}
