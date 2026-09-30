// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nature_detail_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(natureDetail)
const natureDetailProvider = NatureDetailFamily._();

final class NatureDetailProvider
    extends $FunctionalProvider<AsyncValue<Nature>, Nature, FutureOr<Nature>>
    with $FutureModifier<Nature>, $FutureProvider<Nature> {
  const NatureDetailProvider._({
    required NatureDetailFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'natureDetailProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$natureDetailHash();

  @override
  String toString() {
    return r'natureDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Nature> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Nature> create(Ref ref) {
    final argument = this.argument as String;
    return natureDetail(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is NatureDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$natureDetailHash() => r'700d2d1267d7f0d21d5f68940ea84e3592fcf2f8';

final class NatureDetailFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Nature>, String> {
  const NatureDetailFamily._()
    : super(
        retry: null,
        name: r'natureDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  NatureDetailProvider call(String idOrName) =>
      NatureDetailProvider._(argument: idOrName, from: this);

  @override
  String toString() => r'natureDetailProvider';
}
