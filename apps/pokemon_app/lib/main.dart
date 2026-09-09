import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_module.dart';

void main() {
  runApp(
    // ProviderScope hosts the Riverpod dependency graph; ModularApp provides
    // routing/module composition (plan §6/§7).
    ProviderScope(
      child: ModularApp(module: AppModule(), child: const AppWidget()),
    ),
  );
}

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Pokémon Flutter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      routerConfig: Modular.routerConfig,
    );
  }
}
