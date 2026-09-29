// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'berry_detail_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(berryDetail)
const berryDetailProvider = BerryDetailFamily._();

final class BerryDetailProvider
    extends
        $FunctionalProvider<
          AsyncValue<BerryDetail>,
          BerryDetail,
          FutureOr<BerryDetail>
        >
    with $FutureModifier<BerryDetail>, $FutureProvider<BerryDetail> {
  const BerryDetailProvider._({
    required BerryDetailFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'berryDetailProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$berryDetailHash();

  @override
  String toString() {
    return r'berryDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<BerryDetail> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<BerryDetail> create(Ref ref) {
    final argument = this.argument as String;
    return berryDetail(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is BerryDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$berryDetailHash() => r'c4f30838b91652278a0d3fc40cd2de19deb7678b';

final class BerryDetailFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<BerryDetail>, String> {
  const BerryDetailFamily._()
    : super(
        retry: null,
        name: r'berryDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  BerryDetailProvider call(String name) =>
      BerryDetailProvider._(argument: name, from: this);

  @override
  String toString() => r'berryDetailProvider';
}
