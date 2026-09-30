// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_color_detail_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(pokemonColorDetail)
const pokemonColorDetailProvider = PokemonColorDetailFamily._();

final class PokemonColorDetailProvider
    extends
        $FunctionalProvider<
          AsyncValue<PokemonColor>,
          PokemonColor,
          FutureOr<PokemonColor>
        >
    with $FutureModifier<PokemonColor>, $FutureProvider<PokemonColor> {
  const PokemonColorDetailProvider._({
    required PokemonColorDetailFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'pokemonColorDetailProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$pokemonColorDetailHash();

  @override
  String toString() {
    return r'pokemonColorDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<PokemonColor> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<PokemonColor> create(Ref ref) {
    final argument = this.argument as String;
    return pokemonColorDetail(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is PokemonColorDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$pokemonColorDetailHash() =>
    r'30f9166d692a702afcc93c5cccfd381b65139546';

final class PokemonColorDetailFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<PokemonColor>, String> {
  const PokemonColorDetailFamily._()
    : super(
        retry: null,
        name: r'pokemonColorDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  PokemonColorDetailProvider call(String idOrName) =>
      PokemonColorDetailProvider._(argument: idOrName, from: this);

  @override
  String toString() => r'pokemonColorDetailProvider';
}
