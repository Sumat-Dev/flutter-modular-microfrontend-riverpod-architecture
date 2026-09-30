// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_form_detail_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(pokemonFormDetail)
const pokemonFormDetailProvider = PokemonFormDetailFamily._();

final class PokemonFormDetailProvider
    extends
        $FunctionalProvider<
          AsyncValue<PokemonForm>,
          PokemonForm,
          FutureOr<PokemonForm>
        >
    with $FutureModifier<PokemonForm>, $FutureProvider<PokemonForm> {
  const PokemonFormDetailProvider._({
    required PokemonFormDetailFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'pokemonFormDetailProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$pokemonFormDetailHash();

  @override
  String toString() {
    return r'pokemonFormDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<PokemonForm> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<PokemonForm> create(Ref ref) {
    final argument = this.argument as String;
    return pokemonFormDetail(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is PokemonFormDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$pokemonFormDetailHash() => r'a5d8d9fa26efad124c718d8c2e7535a74af15391';

final class PokemonFormDetailFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<PokemonForm>, String> {
  const PokemonFormDetailFamily._()
    : super(
        retry: null,
        name: r'pokemonFormDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  PokemonFormDetailProvider call(String idOrName) =>
      PokemonFormDetailProvider._(argument: idOrName, from: this);

  @override
  String toString() => r'pokemonFormDetailProvider';
}
