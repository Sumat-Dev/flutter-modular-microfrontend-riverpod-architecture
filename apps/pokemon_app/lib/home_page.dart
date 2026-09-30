import 'package:flutter_modular/flutter_modular.dart';
import 'package:material_ui/material_ui.dart';

/// Minimal landing page that routes into feature screens.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pokémon Flutter')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FilledButton(
              onPressed: () => Modular.to.navigate('/pokemon'),
              child: const Text('Open Pokédex'),
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () => Modular.to.navigate('/pokemon/resources'),
              child: const Text('Pokémon Resources'),
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () => Modular.to.navigate('/berries'),
              child: const Text('Open Berries'),
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () => Modular.to.navigate('/items'),
              child: const Text('Open Items'),
            ),
          ],
        ),
      ),
    );
  }
}
