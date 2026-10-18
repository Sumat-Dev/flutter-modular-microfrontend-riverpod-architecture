import 'dart:async';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:pokemon_app/config/routes/app_module.dart';
import 'package:pokemon_app/home_page.dart';
import 'package:pokemon_app/main.dart';

void main() {
  Finder barLabel(String label) => find.descendant(
    of: find.byType(NavigationBar),
    matching: find.text(label),
  );

  int selectedIndex(WidgetTester tester) =>
      tester.widget<NavigationBar>(find.byType(NavigationBar)).selectedIndex;

  // Feature pages kick off a network fetch that never resolves here and show
  // an endlessly animating progress indicator, so `pumpAndSettle` would time
  // out. Pump fixed frames instead.
  Future<void> pumpApp(WidgetTester tester) async {
    await tester.pumpWidget(
      ModularApp(
        module: AppModule(),
        child: const ProviderScope(child: AppWidget()),
      ),
    );
    for (var i = 0; i < 6; i++) {
      await tester.pump(const Duration(milliseconds: 300));
    }
  }

  Future<void> tapTab(WidgetTester tester, String label) async {
    await tester.tap(barLabel(label));
    await tester.pump();
    // `navigate` debounces rapid taps by 500 ms.
    await tester.pump(const Duration(milliseconds: 600));
    await tester.pump(const Duration(milliseconds: 600));
  }

  // `ModularApp` hangs `routerConfig` off an injector singleton, so the
  // location it last resolved survives `cleanGlobals()` and would be replayed
  // into the next test. Rewind the provider so every test starts cold at `/`.
  setUp(() {
    cleanGlobals();
    (Modular.routerConfig.routeInformationProvider!
            as PlatformRouteInformationProvider)
        .routerReportsNewRouteInformation(
          RouteInformation(uri: Uri.parse('/')),
        );
  });

  tearDown(cleanGlobals);

  testWidgets('renders one destination per feature screen', (tester) async {
    await pumpApp(tester);

    expect(find.byType(HomePage), findsOneWidget);
    expect(find.byType(NavigationBar), findsOneWidget);
    expect(find.byType(NavigationDestination), findsNWidgets(4));
    for (final label in ['Pokédex', 'Resources', 'Berries', 'Items']) {
      expect(barLabel(label), findsOneWidget, reason: 'missing "$label" tab');
    }
  });

  testWidgets('opens on the Pokedex instead of an empty shell', (
    tester,
  ) async {
    await pumpApp(tester);

    expect(Modular.to.path, '/pokemon/');
    expect(selectedIndex(tester), 0);
    expect(
      find.byType(AppBar),
      findsOneWidget,
      reason: 'the outlet should render a feature screen, not a blank shell',
    );
  });

  testWidgets('Resources wins over the Pokedex route it is nested under', (
    tester,
  ) async {
    await pumpApp(tester);

    await tapTab(tester, 'Resources');

    expect(Modular.to.path, '/pokemon/resources');
    expect(selectedIndex(tester), 1);
  });

  testWidgets('tapping a destination routes to that screen, bar intact', (
    tester,
  ) async {
    await pumpApp(tester);

    await tapTab(tester, 'Berries');

    expect(Modular.to.path, '/berries/');
    expect(selectedIndex(tester), 2);
    expect(find.byType(NavigationBar), findsOneWidget);
    expect(find.byType(HomePage), findsOneWidget);
  });

  testWidgets('switching back and forth keeps the bar', (tester) async {
    await pumpApp(tester);

    await tapTab(tester, 'Berries');
    await tapTab(tester, 'Items');

    expect(Modular.to.path, '/items/');
    expect(selectedIndex(tester), 3);
    expect(find.byType(NavigationBar), findsOneWidget);
  });

  testWidgets('a detail route stacks over the shell and pops back', (
    tester,
  ) async {
    await pumpApp(tester);

    unawaited(Modular.to.pushNamed('/pokemon/pikachu'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 600));
    await tester.pump(const Duration(milliseconds: 600));

    expect(Modular.to.path, '/pokemon/pikachu');
    expect(find.byType(NavigationBar), findsOneWidget);

    await tester.tap(find.byType(BackButton));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 600));

    expect(Modular.to.path, '/pokemon/');
    expect(find.byType(NavigationBar), findsOneWidget);
  });
}
