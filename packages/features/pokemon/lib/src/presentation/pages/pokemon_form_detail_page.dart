import 'package:feature_pokemon/src/presentation/providers/pokemon_form_detail_provider.dart';
import 'package:feature_pokemon/src/presentation/utils/failure_message.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:ui_components/ui_components.dart';

class PokemonFormDetailPage extends ConsumerWidget {
  const PokemonFormDetailPage({required this.idOrName, super.key});

  final String idOrName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detail = ref.watch(pokemonFormDetailProvider(idOrName));
    return Scaffold(
      appBar: AppBar(title: Text(idOrName)),
      body: detail.when(
        loading: () => const AppLoadingView(),
        error: (error, _) => AppErrorView(
          message: failureToMessage(error),
          onRetry: () => ref.invalidate(pokemonFormDetailProvider(idOrName)),
        ),
        data: (form) {
          final theme = Theme.of(context);
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (form.spriteUrl != null)
                  Center(
                    child: Image.network(
                      form.spriteUrl!,
                      height: 96,
                      errorBuilder: (_, _, _) =>
                          const Icon(Icons.catching_pokemon, size: 72),
                    ),
                  ),
                const SizedBox(height: 12),
                Text(form.name, style: theme.textTheme.titleLarge),
                const SizedBox(height: 8),
                Text('#${form.id}'),
                if (form.formName.isNotEmpty)
                  Text('Form name: ${form.formName}'),
                Text('Default: ${form.isDefault}'),
                Text('Battle only: ${form.isBattleOnly}'),
                Text('Mega: ${form.isMega}'),
                if (form.pokemon != null)
                  Text('Pokémon: ${form.pokemon!.name}'),
                if (form.types.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  Text('Types', style: theme.textTheme.titleMedium),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    children: [
                      for (final t in form.types) Chip(label: Text(t)),
                    ],
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}
