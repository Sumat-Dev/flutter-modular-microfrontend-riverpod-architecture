import 'package:go_router/go_router.dart';
import 'package:pokemon_app/config/routes/app_routes.dart';

/// Centralised router configuration for the app shell.
///
/// Mirrors the reference's `AppPages` (an `initial` route + the route table),
/// built on go_router. The typed routes live in `app_routes.dart`; this class
/// assembles them into the [GoRouter] consumed by `MaterialApp.router`.
class AppPages {
  AppPages._();

  /// The location the app opens on.
  static const String initial = Routes.home;

  /// The app's go_router instance, built from the generated typed routes.
  static final GoRouter router = GoRouter(
    initialLocation: initial,
    routes: $appRoutes,
  );
}
