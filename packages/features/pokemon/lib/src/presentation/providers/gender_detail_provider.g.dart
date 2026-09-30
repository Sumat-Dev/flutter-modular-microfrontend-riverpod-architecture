// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gender_detail_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(genderDetail)
const genderDetailProvider = GenderDetailFamily._();

final class GenderDetailProvider
    extends $FunctionalProvider<AsyncValue<Gender>, Gender, FutureOr<Gender>>
    with $FutureModifier<Gender>, $FutureProvider<Gender> {
  const GenderDetailProvider._({
    required GenderDetailFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'genderDetailProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$genderDetailHash();

  @override
  String toString() {
    return r'genderDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Gender> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Gender> create(Ref ref) {
    final argument = this.argument as String;
    return genderDetail(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is GenderDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$genderDetailHash() => r'ec78749d9a3b410b662f4e99665e24d8878dff2b';

final class GenderDetailFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Gender>, String> {
  const GenderDetailFamily._()
    : super(
        retry: null,
        name: r'genderDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  GenderDetailProvider call(String idOrName) =>
      GenderDetailProvider._(argument: idOrName, from: this);

  @override
  String toString() => r'genderDetailProvider';
}
