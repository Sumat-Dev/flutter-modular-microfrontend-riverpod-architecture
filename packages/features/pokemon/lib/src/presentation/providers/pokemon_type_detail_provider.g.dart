// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_type_detail_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(pokemonTypeDetail)
const pokemonTypeDetailProvider = PokemonTypeDetailFamily._();

final class PokemonTypeDetailProvider
    extends
        $FunctionalProvider<
          AsyncValue<PokemonType>,
          PokemonType,
          FutureOr<PokemonType>
        >
    with $FutureModifier<PokemonType>, $FutureProvider<PokemonType> {
  const PokemonTypeDetailProvider._({
    required PokemonTypeDetailFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'pokemonTypeDetailProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$pokemonTypeDetailHash();

  @override
  String toString() {
    return r'pokemonTypeDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<PokemonType> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<PokemonType> create(Ref ref) {
    final argument = this.argument as String;
    return pokemonTypeDetail(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is PokemonTypeDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$pokemonTypeDetailHash() => r'172465ea85260d2c9c542a13b8cf3dbea2adf5ae';

final class PokemonTypeDetailFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<PokemonType>, String> {
  const PokemonTypeDetailFamily._()
    : super(
        retry: null,
        name: r'pokemonTypeDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  PokemonTypeDetailProvider call(String idOrName) =>
      PokemonTypeDetailProvider._(argument: idOrName, from: this);

  @override
  String toString() => r'pokemonTypeDetailProvider';
}
