// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ability_detail_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(abilityDetail)
const abilityDetailProvider = AbilityDetailFamily._();

final class AbilityDetailProvider
    extends $FunctionalProvider<AsyncValue<Ability>, Ability, FutureOr<Ability>>
    with $FutureModifier<Ability>, $FutureProvider<Ability> {
  const AbilityDetailProvider._({
    required AbilityDetailFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'abilityDetailProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$abilityDetailHash();

  @override
  String toString() {
    return r'abilityDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Ability> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Ability> create(Ref ref) {
    final argument = this.argument as String;
    return abilityDetail(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is AbilityDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$abilityDetailHash() => r'0d8ed08c3d0ca4eac409cac3b6f32c455233a896';

final class AbilityDetailFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Ability>, String> {
  const AbilityDetailFamily._()
    : super(
        retry: null,
        name: r'abilityDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  AbilityDetailProvider call(String idOrName) =>
      AbilityDetailProvider._(argument: idOrName, from: this);

  @override
  String toString() => r'abilityDetailProvider';
}
