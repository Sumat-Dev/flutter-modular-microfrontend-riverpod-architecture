// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokeathlon_stat_detail_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(pokeathlonStatDetail)
const pokeathlonStatDetailProvider = PokeathlonStatDetailFamily._();

final class PokeathlonStatDetailProvider
    extends
        $FunctionalProvider<
          AsyncValue<PokeathlonStat>,
          PokeathlonStat,
          FutureOr<PokeathlonStat>
        >
    with $FutureModifier<PokeathlonStat>, $FutureProvider<PokeathlonStat> {
  const PokeathlonStatDetailProvider._({
    required PokeathlonStatDetailFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'pokeathlonStatDetailProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$pokeathlonStatDetailHash();

  @override
  String toString() {
    return r'pokeathlonStatDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<PokeathlonStat> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<PokeathlonStat> create(Ref ref) {
    final argument = this.argument as String;
    return pokeathlonStatDetail(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is PokeathlonStatDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$pokeathlonStatDetailHash() =>
    r'9ed78299d935a5d3145e98405f0868e33b8d79db';

final class PokeathlonStatDetailFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<PokeathlonStat>, String> {
  const PokeathlonStatDetailFamily._()
    : super(
        retry: null,
        name: r'pokeathlonStatDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  PokeathlonStatDetailProvider call(String idOrName) =>
      PokeathlonStatDetailProvider._(argument: idOrName, from: this);

  @override
  String toString() => r'pokeathlonStatDetailProvider';
}
