// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_habitat_detail_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(pokemonHabitatDetail)
const pokemonHabitatDetailProvider = PokemonHabitatDetailFamily._();

final class PokemonHabitatDetailProvider
    extends
        $FunctionalProvider<
          AsyncValue<PokemonHabitat>,
          PokemonHabitat,
          FutureOr<PokemonHabitat>
        >
    with $FutureModifier<PokemonHabitat>, $FutureProvider<PokemonHabitat> {
  const PokemonHabitatDetailProvider._({
    required PokemonHabitatDetailFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'pokemonHabitatDetailProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$pokemonHabitatDetailHash();

  @override
  String toString() {
    return r'pokemonHabitatDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<PokemonHabitat> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<PokemonHabitat> create(Ref ref) {
    final argument = this.argument as String;
    return pokemonHabitatDetail(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is PokemonHabitatDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$pokemonHabitatDetailHash() =>
    r'28d269356024edecf1ba2845c68b86e48ed72c3d';

final class PokemonHabitatDetailFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<PokemonHabitat>, String> {
  const PokemonHabitatDetailFamily._()
    : super(
        retry: null,
        name: r'pokemonHabitatDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  PokemonHabitatDetailProvider call(String idOrName) =>
      PokemonHabitatDetailProvider._(argument: idOrName, from: this);

  @override
  String toString() => r'pokemonHabitatDetailProvider';
}
