// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_species_detail_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(pokemonSpeciesDetail)
const pokemonSpeciesDetailProvider = PokemonSpeciesDetailFamily._();

final class PokemonSpeciesDetailProvider
    extends
        $FunctionalProvider<
          AsyncValue<PokemonSpecies>,
          PokemonSpecies,
          FutureOr<PokemonSpecies>
        >
    with $FutureModifier<PokemonSpecies>, $FutureProvider<PokemonSpecies> {
  const PokemonSpeciesDetailProvider._({
    required PokemonSpeciesDetailFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'pokemonSpeciesDetailProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$pokemonSpeciesDetailHash();

  @override
  String toString() {
    return r'pokemonSpeciesDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<PokemonSpecies> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<PokemonSpecies> create(Ref ref) {
    final argument = this.argument as String;
    return pokemonSpeciesDetail(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is PokemonSpeciesDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$pokemonSpeciesDetailHash() =>
    r'a4c309175c6b94baa084931d05daf85ab05d8b86';

final class PokemonSpeciesDetailFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<PokemonSpecies>, String> {
  const PokemonSpeciesDetailFamily._()
    : super(
        retry: null,
        name: r'pokemonSpeciesDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  PokemonSpeciesDetailProvider call(String idOrName) =>
      PokemonSpeciesDetailProvider._(argument: idOrName, from: this);

  @override
  String toString() => r'pokemonSpeciesDetailProvider';
}
