# flutter_modular_microfrontend_riverpod_architecture

[![codecov](https://codecov.io/gh/Sumat-Dev/flutter-modular-microfrontend-riverpod-architecture/branch/main/graph/badge.svg?token=xXHDwrNGbB)](https://codecov.io/gh/Sumat-Dev/flutter-modular-microfrontend-riverpod-architecture)
[![style: very good analysis](https://img.shields.io/badge/style-very_good_analysis-B22C89.svg)](https://pub.dev/packages/very_good_analysis)
[![melos](https://img.shields.io/badge/maintained%20with-melos-f700ff.svg?style=flat-square)](https://github.com/invertase/melos)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](https://opensource.org/licenses/MIT)

A Flutter **pub workspace** that demonstrates a microfrontend architecture:
[flutter_modular](https://pub.dev/packages/flutter_modular) owns routing, and
[Riverpod](https://pub.dev/packages/flutter_riverpod) owns application state and
dependency injection. Each feature ships as an independent package with its own
Clean Architecture layers and its own routes, and is mounted into the shell app
without the shell knowing anything about its internals.

Data comes from the public [PokéAPI v2](https://pokeapi.co/) — no API key or
backend is required to run the app.

---

## Table of contents

- [Architecture at a glance](#architecture-at-a-glance)
- [Workspace layout](#workspace-layout)
- [Packages](#packages)
- [Routing](#routing)
- [State and dependency injection](#state-and-dependency-injection)
- [Code generation](#code-generation)
- [Commands](#commands)
- [Getting started](#getting-started)
- [Testing](#testing)
- [Continuous integration](#continuous-integration)
- [License](#license)

---

## Architecture at a glance

| Concern | Owner | Package |
| --- | --- | --- |
| Routing, navigation, route-scoped lifecycle | flutter_modular | `flutter_modular` |
| App state, async data, object graph | Riverpod 3 | `flutter_riverpod` |
| Widget toolkit / design system | `material_ui` + `ui_components` | shared |
| HTTP transport and error mapping | `network` (Dio) | shared |
| Feature business logic | each feature package | per feature |

The two concerns are deliberately kept apart:

- **flutter_modular** composes the route tree. Each feature exposes a `Module`
  and is mounted by the shell app under a route prefix.
- **Riverpod** builds the object graph. Providers are declared inside the
  feature that owns them and are resolved lazily, so a feature's data layer is
  never constructed unless the user navigates to it.

The shell app (`apps/pokemon_app`) owns only bootstrap, theming, and route
composition. It contains no feature business logic.

## Workspace layout

```
.
├── apps/
│   └── pokemon_app/              # Shell: bootstrap, theme, route composition
├── packages/
│   ├── features/                 # Microfrontends — independently shippable
│   │   ├── pokemon/              # Golden reference feature
│   │   ├── berries/
│   │   └── items/
│   └── libraries/                # Shared, feature-agnostic building blocks
│       ├── core/                 # Failure/Exception, UseCase, pagination
│       ├── network/              # ApiClient abstraction + Dio + error mapping
│       ├── ui_components/        # Reusable widgets (no business rules)
│       └── localization/         # Localization setup and shared utilities
├── docs/                         # PokéAPI endpoint reference notes
├── pubspec.yaml                  # Workspace root: packages + melos scripts
├── analysis_options.yaml         # very_good_analysis + analyzer excludes
└── sonar-project.properties      # SonarQube project configuration
```

`packages/libraries` holds code with **no** feature knowledge.
`packages/features` holds code that knows about exactly one domain. Neither
direction is violated.

## Packages

### Feature microfrontends

Each follows the same internal layering:

```
lib/
├── <feature>_module.dart        # flutter_modular Module: routes + binds
└── src/
    ├── data/                     # Remote data sources, models, repository impls
    │   ├── datasources/
    │   ├── models/               # JSON models (+ generated .g.dart)
    │   └── repositories/
    ├── domain/                   # Pure Dart — entities, repository contracts, use cases
    │   ├── entities/
    │   ├── repositories/
    │   └── usecases/
    └── presentation/             # Pages, widgets, Riverpod providers
        ├── pages/
        ├── providers/
        └── widgets/
```

| Package | Routes | Scope |
| --- | --- | --- |
| `feature_pokemon` | `/pokemon` | List, detail, and 14 browseable reference resources |
| `feature_berries` | `/berries` | Berry list and detail |
| `feature_items` | `/items` | Item list and detail |

The `domain` layer has no Flutter imports and no HTTP knowledge — it is pure
Dart, which is what makes it cheap to test.

`feature_pokemon` is the golden reference: it shows the pattern at full scale,
including a single generic list page driven by a static resource catalog instead
of 14 near-identical list screens.

### Shared libraries

| Package | Contents |
| --- | --- |
| `core` | `Failure`/`Exception` hierarchy, `UseCase` contract, pagination types, shared typedefs |
| `network` | `ApiClient` abstraction, `DioApiClient`, and `Failure` mapping from transport errors |
| `ui_components` | `AppAsyncView`, `AppEntityCard`, `AppPaginatedListView`, `AppLoadingView`, `AppErrorView`, `AppSection`, `AppChip`, design tokens |
| `localization` | `AppLocalizationConfig` delegates and supported locales |

`ui_components` is intentionally decoupled from Riverpod: callers pass
already-resolved `isLoading` / `hasError` / `data` values, which keeps the
package free of any state-management dependency.

## Routing

`AppModule` composes the tree. The root `/` route is a **shell**: it owns the
`NavigationBar` and renders the active feature module inside a `RouterOutlet`,
so the bar stays on screen while switching tabs.

```dart
r.child(
  '/',
  child: (_) => const HomePage(),
  children: [
    ModuleRoute('/pokemon', module: PokemonModule()),
    ModuleRoute('/berries', module: BerriesModule()),
    ModuleRoute('/items', module: ItemsModule()),
  ],
);
```

Resulting routes:

| Route | Screen |
| --- | --- |
| `/` | Shell — `HomePage` with the bottom `NavigationBar` |
| `/pokemon/` | `PokemonPage` (Pokédex) |
| `/pokemon/resources` | `ResourceIndexPage` — index of 14 reference resources |
| `/pokemon/resources/:segment` | `ResourceListPage` — generated from the catalog |
| `/pokemon/resources/:segment/:id` | Resource detail |
| `/pokemon/:name` | `PokemonDetailPage` |
| `/berries/` | `BerryPage` |
| `/berries/:name` | `BerryDetailPage` |
| `/items/` | `ItemPage` |
| `/items/:name` | `ItemDetailPage` |

The Resources tab is driven by `kPokemonResources`, a static
`List<ResourceDescriptor>` (Abilities, Types, Natures, Egg Groups, Growth Rates,
Stats, Colors, Shapes, Habitats, Forms, Species, Genders, Pokeathlon Stats,
Characteristics). One generic `ResourceListPage` renders every list from its
descriptor, and a `_detailForSegment` dispatcher in the module selects the right
detail screen for a given segment.

> **Note on trailing slashes.** Modules register their list routes as
> `/pokemon/`, `/berries/`, and `/items/`. Deep links without the slash
> (`/pokemon`) still resolve, but the parser logs a warning recommending the
> canonical form.

## State and dependency injection

Providers are declared next to the feature that owns them and wired as an
explicit chain, so the object graph is readable in one file:

```dart
@Riverpod(keepAlive: true)
ApiClient apiClient(Ref ref) => DioApiClient();

@Riverpod(keepAlive: true)
BerryRemoteDataSource berryRemoteDataSource(Ref ref) =>
    BerryRemoteDataSourceImpl(ref.watch(apiClientProvider));

@Riverpod(keepAlive: true)
BerryRepository berryRepository(Ref ref) =>
    BerryRepositoryImpl(remote: ref.watch(berryRemoteDataSourceProvider));

@Riverpod(keepAlive: true)
GetBerryList getBerryList(Ref ref) =>
    GetBerryList(ref.watch(berryRepositoryProvider));
```

`ApiClient` is an abstraction in `network`; swapping Dio for another transport
means overriding a single provider.

In the widget layer, `AppAsyncView` collapses the usual
`when(loading:, error:, data:)` boilerplate into one reusable widget:

```dart
AppAsyncView<BerryListState>(
  isLoading: state.isLoading,
  hasError: state.hasError,
  data: state.value,
  onRetry: notifier.refresh,
  dataBuilder: (context, data) => ...,
)
```

`ProviderScope` is mounted once at the app root in `main.dart`.

## Code generation

Models (`json_serializable`) and providers (`riverpod_generator`) are generated
with `build_runner`. Generated `.g.dart` files are committed, so a clean clone
builds without running codegen.

```sh
# Run inside a feature package, or across the workspace with melos exec
dart run build_runner build --delete-conflicting-outputs
```

Analyzer excludes `**/*.g.dart` and `build/**`.

## Commands

Defined as [melos](https://github.com/invertase/melos) scripts in the root
`pubspec.yaml`. Run them with `dart run melos run <script>`, or with `melos` if
you have it activated globally.

| Script | Purpose |
| --- | --- |
| `setup` | `flutter pub get` in every package |
| `analyze` | `flutter analyze` across all packages |
| `format` | Verify formatting (fails if anything would change) |
| `format:fix` | Apply formatting |
| `test` | Run tests in every package that has a `test/` directory |
| `test:coverage` | Same, with `--coverage` |
| `test:junit` | Same, emitting `junit.xml` for Codecov Test Analytics |

## Getting started

### Prerequisites

- Flutter **3.47.1** (pinned via [FVM](https://fvm.app) in `.fvmrc`)
- Dart SDK `^3.9.2`

### Run it

```sh
# Install dependencies for every package
dart run melos run setup

# Launch the app
cd apps/pokemon_app
flutter run
```

If you use FVM, prefix Flutter commands with `fvm`:

```sh
fvm flutter pub get
fvm flutter run
```

## Testing

```sh
dart run melos run test
```

Tests live in each package's `test/` directory. They cover domain logic, models,
remote data sources, and repository implementations — using `mocktail` for
fakes — plus widget and routing tests in the app shell.

The app shell has coverage for the navigation bar and its routing: the shell
renders one destination per feature, opens on the Pokédex rather than an empty
shell, keeps the bar across tab switches, resolves `/pokemon/resources` to the
Resources destination, and pushes/pops detail routes correctly.

### Widget test note

Feature pages start network fetches that never resolve under
`flutter_test`, and their loading view animates indefinitely — so
`pumpAndSettle` times out. Those tests pump fixed frames instead.

`ModularApp` stores its `routerConfig` on an injector **singleton**, so the last
resolved route survives `cleanGlobals()` and would leak between tests. The shell
test suite rewinds `routeInformationProvider` in `setUp` so each test starts
cold at `/`.

## Continuous integration

`.github/workflows/ci.yml` runs three gated jobs on push and pull request:

1. **Analyze** — `dart format --output=none --set-exit-if-changed .`, then
   `flutter analyze`.
2. **Test** — `melos run test:junit`, uploading coverage and test results to
   Codecov.
3. **SonarQube** — `melos run test:coverage`, then a SonarQube scan configured by
   `sonar-project.properties`.

Linting uses [`very_good_analysis`](https://pub.dev/packages/very_good_analysis),
with `public_member_api_docs` disabled.

## License

MIT — see [LICENSE](LICENSE).