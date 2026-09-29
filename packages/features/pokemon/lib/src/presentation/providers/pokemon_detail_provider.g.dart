// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_detail_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(pokemonDetail)
const pokemonDetailProvider = PokemonDetailFamily._();

final class PokemonDetailProvider
    extends
        $FunctionalProvider<
          AsyncValue<PokemonDetail>,
          PokemonDetail,
          FutureOr<PokemonDetail>
        >
    with $FutureModifier<PokemonDetail>, $FutureProvider<PokemonDetail> {
  const PokemonDetailProvider._({
    required PokemonDetailFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'pokemonDetailProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$pokemonDetailHash();

  @override
  String toString() {
    return r'pokemonDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<PokemonDetail> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<PokemonDetail> create(Ref ref) {
    final argument = this.argument as String;
    return pokemonDetail(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is PokemonDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$pokemonDetailHash() => r'c214053a8366a83220d8e3f85e41d4af4012b0d4';

final class PokemonDetailFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<PokemonDetail>, String> {
  const PokemonDetailFamily._()
    : super(
        retry: null,
        name: r'pokemonDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  PokemonDetailProvider call(String name) =>
      PokemonDetailProvider._(argument: name, from: this);

  @override
  String toString() => r'pokemonDetailProvider';
}
