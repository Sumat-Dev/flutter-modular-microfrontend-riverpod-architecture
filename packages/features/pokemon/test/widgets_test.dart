import 'package:feature_pokemon/src/domain/entities/pokemon.dart';
import 'package:feature_pokemon/src/domain/entities/pokemon_detail.dart';
import 'package:feature_pokemon/src/presentation/widgets/pokemon_card.dart';
import 'package:feature_pokemon/src/presentation/widgets/pokemon_stat_view.dart';
import 'package:feature_pokemon/src/presentation/widgets/pokemon_type_chip.dart';
import 'package:flutter_test/flutter_test.dart';
// Use the same Material implementation the widgets use so the widget types
// (Chip/ListTile/LinearProgressIndicator/Material) match in finders.
import 'package:material_ui/material_ui.dart';

Widget _wrap(Widget child) => MaterialApp(home: Scaffold(body: child));

void main() {
  group('PokemonTypeChip', () {
    testWidgets('renders the type label', (tester) async {
      await tester.pumpWidget(_wrap(const PokemonTypeChip(type: 'electric')));
      expect(find.text('electric'), findsOneWidget);
      expect(find.byType(Chip), findsOneWidget);
    });
  });

  group('PokemonStatView', () {
    testWidgets('renders name, value and clamped progress', (tester) async {
      await tester.pumpWidget(
        _wrap(
          const PokemonStatView(stat: PokemonStat(name: 'hp', baseValue: 35)),
        ),
      );

      expect(find.text('hp'), findsOneWidget);
      expect(find.text('35'), findsOneWidget);

      final indicator = tester.widget<LinearProgressIndicator>(
        find.byType(LinearProgressIndicator),
      );
      expect(indicator.value, closeTo(35 / 255, 1e-9));
    });

    testWidgets('clamps value above the 255 cap to 1.0', (tester) async {
      await tester.pumpWidget(
        _wrap(
          const PokemonStatView(stat: PokemonStat(name: 'atk', baseValue: 999)),
        ),
      );

      final indicator = tester.widget<LinearProgressIndicator>(
        find.byType(LinearProgressIndicator),
      );
      expect(indicator.value, 1.0);
    });
  });

  group('PokemonCard', () {
    testWidgets('shows name and formatted id', (tester) async {
      await tester.pumpWidget(
        _wrap(
          PokemonCard(
            pokemon: const Pokemon(id: 1, name: 'bulbasaur'),
            onTap: () {},
          ),
        ),
      );

      expect(find.text('bulbasaur'), findsOneWidget);
      expect(find.text('#1'), findsOneWidget);
      expect(find.byIcon(Icons.chevron_right), findsOneWidget);
    });

    testWidgets('invokes onTap when tapped', (tester) async {
      var tapped = false;
      await tester.pumpWidget(
        _wrap(
          PokemonCard(
            pokemon: const Pokemon(id: 1, name: 'bulbasaur'),
            onTap: () => tapped = true,
          ),
        ),
      );

      await tester.tap(find.byType(ListTile));
      expect(tapped, isTrue);
    });
  });
}
