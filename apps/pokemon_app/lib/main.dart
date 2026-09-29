import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:localization/localization.dart';
import 'package:material_ui/material_ui.dart';
import 'package:pokemon_app/config/routes/app_pages.dart';
import 'package:pokemon_app/config/themes/app_theme.dart';

void main() {
  // ProviderScope hosts the Riverpod dependency graph; routing is handled by
  // go_router (see AppPages.router).
  runApp(const ProviderScope(child: AppWidget()));
}

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Pokémon Flutter',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: AppTheme.system,
      localizationsDelegates: AppLocalizationConfig.localizationsDelegates,
      supportedLocales: AppLocalizationConfig.supportedLocales,
      routerConfig: AppPages.router,
    );
  }
}
