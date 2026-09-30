// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'encounters_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(encounters)
const encountersProvider = EncountersFamily._();

final class EncountersProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<LocationAreaEncounter>>,
          List<LocationAreaEncounter>,
          FutureOr<List<LocationAreaEncounter>>
        >
    with
        $FutureModifier<List<LocationAreaEncounter>>,
        $FutureProvider<List<LocationAreaEncounter>> {
  const EncountersProvider._({
    required EncountersFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'encountersProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$encountersHash();

  @override
  String toString() {
    return r'encountersProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<LocationAreaEncounter>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<LocationAreaEncounter>> create(Ref ref) {
    final argument = this.argument as String;
    return encounters(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is EncountersProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$encountersHash() => r'2b5c910ddeabc3ed928fd63ec3f91d47573c8d71';

final class EncountersFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<List<LocationAreaEncounter>>,
          String
        > {
  const EncountersFamily._()
    : super(
        retry: null,
        name: r'encountersProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  EncountersProvider call(String idOrName) =>
      EncountersProvider._(argument: idOrName, from: this);

  @override
  String toString() => r'encountersProvider';
}
