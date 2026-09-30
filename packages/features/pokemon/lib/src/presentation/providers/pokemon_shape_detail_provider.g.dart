// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_shape_detail_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(pokemonShapeDetail)
const pokemonShapeDetailProvider = PokemonShapeDetailFamily._();

final class PokemonShapeDetailProvider
    extends
        $FunctionalProvider<
          AsyncValue<PokemonShape>,
          PokemonShape,
          FutureOr<PokemonShape>
        >
    with $FutureModifier<PokemonShape>, $FutureProvider<PokemonShape> {
  const PokemonShapeDetailProvider._({
    required PokemonShapeDetailFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'pokemonShapeDetailProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$pokemonShapeDetailHash();

  @override
  String toString() {
    return r'pokemonShapeDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<PokemonShape> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<PokemonShape> create(Ref ref) {
    final argument = this.argument as String;
    return pokemonShapeDetail(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is PokemonShapeDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$pokemonShapeDetailHash() =>
    r'9d456d934b35f69736d2953d1aa224a3f8943132';

final class PokemonShapeDetailFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<PokemonShape>, String> {
  const PokemonShapeDetailFamily._()
    : super(
        retry: null,
        name: r'pokemonShapeDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  PokemonShapeDetailProvider call(String idOrName) =>
      PokemonShapeDetailProvider._(argument: idOrName, from: this);

  @override
  String toString() => r'pokemonShapeDetailProvider';
}
