import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

/// Minimal landing page that routes into feature modules.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pokémon Flutter')),
      body: Center(
        child: FilledButton(
          onPressed: () => Modular.to.pushNamed('/pokemon/'),
          child: const Text('Open Pokédex'),
        ),
      ),
    );
  }
}
