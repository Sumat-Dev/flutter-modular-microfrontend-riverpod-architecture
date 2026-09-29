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
        child: FilledButton(
          onPressed: () => Modular.to.navigate('/pokemon'),
          child: const Text('Open Pokédex'),
        ),
      ),
    );
  }
}
