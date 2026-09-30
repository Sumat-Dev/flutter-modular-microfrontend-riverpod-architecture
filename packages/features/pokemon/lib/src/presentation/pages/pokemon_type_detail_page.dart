import 'package:feature_pokemon/src/domain/entities/common/named_api_resource.dart';
import 'package:feature_pokemon/src/presentation/providers/pokemon_type_detail_provider.dart';
import 'package:feature_pokemon/src/presentation/utils/failure_message.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:ui_components/ui_components.dart';

class PokemonTypeDetailPage extends ConsumerWidget {
  const PokemonTypeDetailPage({required this.idOrName, super.key});

  final String idOrName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detail = ref.watch(pokemonTypeDetailProvider(idOrName));
    return Scaffold(
      appBar: AppBar(title: Text(idOrName)),
      body: detail.when(
        loading: () => const AppLoadingView(),
        error: (error, _) => AppErrorView(
          message: failureToMessage(error),
          onRetry: () => ref.invalidate(pokemonTypeDetailProvider(idOrName)),
        ),
        data: (type) {
          final theme = Theme.of(context);
          final relations = type.damageRelations;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  type.displayName ?? type.name,
                  style: theme.textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text('#${type.id}'),
                if (type.generation != null)
                  Text('Generation: ${type.generation!.name}'),
                if (type.moveDamageClass != null)
                  Text('Damage class: ${type.moveDamageClass!.name}'),
                _section(
                  theme,
                  'Double damage to',
                  relations.doubleDamageTo,
                ),
                _section(
                  theme,
                  'Double damage from',
                  relations.doubleDamageFrom,
                ),
                _section(theme, 'No damage to', relations.noDamageTo),
                _section(theme, 'Half damage to', relations.halfDamageTo),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _section(
    ThemeData theme,
    String title,
    List<NamedApiResource> items,
  ) {
    if (items.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Text(title, style: theme.textTheme.titleMedium),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 4,
          children: [
            for (final i in items) Chip(label: Text(i.name)),
          ],
        ),
      ],
    );
  }
}
