import 'package:core/core.dart';
import 'package:feature_pokemon/pokemon_module.dart';
import 'package:feature_pokemon/src/domain/repositories/pokemon_repository.dart';
import 'package:feature_pokemon/src/presentation/providers/pokemon_providers.dart';
import 'package:feature_pokemon/src/presentation/widgets/pokemon_card.dart';
import 'package:feature_pokemon/src/presentation/widgets/pokemon_stat_view.dart';
import 'package:feature_pokemon/src/presentation/widgets/pokemon_type_chip.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

/// Repository fake that lets each test control the outcomes and timing.
class _FakeRepo implements PokemonRepository {
  _FakeRepo({
    this.listResult,
    this.detailResult,
    this.listDelay = Duration.zero,
    this.detailDelay = Duration.zero,
  });

  final Either<Failure, PaginatedResult<Pokemon>>? listResult;
  final Either<Failure, PokemonDetail>? detailResult;
  final Duration listDelay;
  final Duration detailDelay;

  @override
  ResultFuture<PaginatedResult<Pokemon>> getPokemonList(PageRequest page) async {
    if (listDelay > Duration.zero) {
      await Future<void>.delayed(listDelay);
    }
    return listResult ??
        const Right(
          PaginatedResult<Pokemon>(
            count: 1,
            items: [Pokemon(id: 1, name: 'bulbasaur')],
          ),
        );
  }

  @override
  ResultFuture<PokemonDetail> getPokemon(String name) async {
    if (detailDelay > Duration.zero) {
      await Future<void>.delayed(detailDelay);
    }
    return detailResult ??
        Right(
          PokemonDetail(
            id: 25,
            name: name,
            height: 4,
            weight: 60,
            types: const ['electric'],
            stats: const [PokemonStat(name: 'hp', baseValue: 35)],
          ),
        );
  }
}

Widget _app(_FakeRepo repo, Widget home) => ProviderScope(
  overrides: [pokemonRepositoryProvider.overrideWithValue(repo)],
  child: MaterialApp(home: home),
);

void main() {
  group('PokemonDetailPage', () {
    testWidgets('shows loading indicator while the future is pending', (
      tester,
    ) async {
      final repo = _FakeRepo(detailDelay: const Duration(milliseconds: 50));
      await tester.pumpWidget(_app(repo, const PokemonDetailPage(name: 'pikachu')));

      // Initial frame: still loading.
      expect(find.byType(CircularProgressIndicator), findsWidgets);

      await tester.pumpAndSettle();
    });

    testWidgets('renders detail data on success', (tester) async {
      final repo = _FakeRepo();
      await tester.pumpWidget(_app(repo, const PokemonDetailPage(name: 'pikachu')));
      await tester.pumpAndSettle();

      expect(find.text('#25'), findsOneWidget);
      expect(find.byType(PokemonTypeChip), findsOneWidget);
      expect(find.byType(PokemonStatView), findsOneWidget);
      expect(find.textContaining('Height: 4'), findsOneWidget);
    });

    testWidgets('renders error view on failure', (tester) async {
      final repo = _FakeRepo(
        detailResult: const Left(ServerFailure(message: 'boom')),
      );
      await tester.pumpWidget(_app(repo, const PokemonDetailPage(name: 'x')));
      await tester.pumpAndSettle();

      expect(
        find.text('The server is unavailable right now.'),
        findsOneWidget,
      );
    });
  });

  group('PokemonPage', () {
    testWidgets('renders a list of PokemonCard on success', (tester) async {
      final repo = _FakeRepo(
        listResult: const Right(
          PaginatedResult<Pokemon>(
            count: 2,
            items: [
              Pokemon(id: 1, name: 'bulbasaur'),
              Pokemon(id: 2, name: 'ivysaur'),
            ],
          ),
        ),
      );
      await tester.pumpWidget(_app(repo, const PokemonPage()));
      await tester.pumpAndSettle();

      expect(find.text('Pokédex'), findsOneWidget);
      expect(find.byType(PokemonCard), findsNWidgets(2));
      expect(find.text('bulbasaur'), findsOneWidget);
      expect(find.text('ivysaur'), findsOneWidget);
    });

    testWidgets('shows a trailing loader when more pages are available', (
      tester,
    ) async {
      final repo = _FakeRepo(
        listResult: const Right(
          PaginatedResult<Pokemon>(
            count: 40,
            next: 'next-url',
            items: [Pokemon(id: 1, name: 'bulbasaur')],
          ),
        ),
      );
      await tester.pumpWidget(_app(repo, const PokemonPage()));
      // Data is available synchronously (zero delay). Use pump (not
      // pumpAndSettle) because the trailing adaptive spinner animates forever.
      await tester.pump();
      await tester.pump();

      // One card + one trailing progress row because hasMore == true.
      expect(find.byType(PokemonCard), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsWidgets);
    });

    testWidgets('renders error view on failure', (tester) async {
      final repo = _FakeRepo(
        listResult: const Left(NetworkFailure(message: 'offline')),
      );
      await tester.pumpWidget(_app(repo, const PokemonPage()));
      await tester.pumpAndSettle();

      expect(
        find.text('No internet connection. Please try again.'),
        findsOneWidget,
      );
    });

    testWidgets('shows loading view while the first page is pending', (
      tester,
    ) async {
      final repo = _FakeRepo(listDelay: const Duration(milliseconds: 50));
      await tester.pumpWidget(_app(repo, const PokemonPage()));

      expect(find.byType(PokemonCard), findsNothing);

      await tester.pumpAndSettle();
    });
  });
}
