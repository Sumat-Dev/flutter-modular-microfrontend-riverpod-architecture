// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'characteristic_detail_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(characteristicDetail)
const characteristicDetailProvider = CharacteristicDetailFamily._();

final class CharacteristicDetailProvider
    extends
        $FunctionalProvider<
          AsyncValue<Characteristic>,
          Characteristic,
          FutureOr<Characteristic>
        >
    with $FutureModifier<Characteristic>, $FutureProvider<Characteristic> {
  const CharacteristicDetailProvider._({
    required CharacteristicDetailFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'characteristicDetailProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$characteristicDetailHash();

  @override
  String toString() {
    return r'characteristicDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Characteristic> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<Characteristic> create(Ref ref) {
    final argument = this.argument as int;
    return characteristicDetail(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is CharacteristicDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$characteristicDetailHash() =>
    r'b4c7415907738a9501eeb2d8c7118dd11dfcd31e';

final class CharacteristicDetailFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Characteristic>, int> {
  const CharacteristicDetailFamily._()
    : super(
        retry: null,
        name: r'characteristicDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  CharacteristicDetailProvider call(int id) =>
      CharacteristicDetailProvider._(argument: id, from: this);

  @override
  String toString() => r'characteristicDetailProvider';
}
