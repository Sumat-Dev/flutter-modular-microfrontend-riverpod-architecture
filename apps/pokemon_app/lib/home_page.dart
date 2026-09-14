import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pokemon_app/config/routes/app_routes.dart';

/// Minimal landing page that routes into feature screens.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pokémon Flutter')),
      body: Center(
        child: FilledButton(
          onPressed: () => context.go(Routes.pokemonList),
          child: const Text('Open Pokédex'),
        ),
      ),
    );
  }
}
