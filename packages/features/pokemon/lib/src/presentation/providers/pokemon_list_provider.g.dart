// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_list_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PokemonList)
const pokemonListProvider = PokemonListProvider._();

final class PokemonListProvider
    extends $AsyncNotifierProvider<PokemonList, PokemonListState> {
  const PokemonListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pokemonListProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pokemonListHash();

  @$internal
  @override
  PokemonList create() => PokemonList();
}

String _$pokemonListHash() => r'dab831d7d1eec77311babee82138c36a2b16997f';

abstract class _$PokemonList extends $AsyncNotifier<PokemonListState> {
  FutureOr<PokemonListState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<AsyncValue<PokemonListState>, PokemonListState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<PokemonListState>, PokemonListState>,
              AsyncValue<PokemonListState>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
