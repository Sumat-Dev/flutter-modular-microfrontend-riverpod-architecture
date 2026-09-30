import 'package:feature_pokemon/src/presentation/utils/resource_catalog.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:material_ui/material_ui.dart';

/// Single entry point that lists all browseable PokéAPI reference resources.
class ResourceIndexPage extends StatelessWidget {
  const ResourceIndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pokémon Resources')),
      body: ListView.separated(
        itemCount: kPokemonResources.length,
        separatorBuilder: (_, _) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final resource = kPokemonResources[index];
          return ListTile(
            title: Text(resource.title),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Modular.to.pushNamed(
              '/pokemon/resources/${resource.routeSegment}',
            ),
          );
        },
      ),
    );
  }
}
