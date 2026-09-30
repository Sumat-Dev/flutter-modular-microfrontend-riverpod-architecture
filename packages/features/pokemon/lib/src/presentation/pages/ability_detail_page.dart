import 'package:feature_pokemon/src/presentation/providers/ability_detail_provider.dart';
import 'package:feature_pokemon/src/presentation/utils/failure_message.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:ui_components/ui_components.dart';

class AbilityDetailPage extends ConsumerWidget {
  const AbilityDetailPage({required this.idOrName, super.key});

  final String idOrName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detail = ref.watch(abilityDetailProvider(idOrName));
    return Scaffold(
      appBar: AppBar(title: Text(idOrName)),
      body: detail.when(
        loading: () => const AppLoadingView(),
        error: (error, _) => AppErrorView(
          message: failureToMessage(error),
          onRetry: () => ref.invalidate(abilityDetailProvider(idOrName)),
        ),
        data: (ability) {
          final theme = Theme.of(context);
          final pokemon = ability.pokemon.take(30).toList();
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ability.displayName ?? ability.name,
                  style: theme.textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text('#${ability.id}'),
                Text('Main series: ${ability.isMainSeries}'),
                if (ability.generation != null)
                  Text('Generation: ${ability.generation!.name}'),
                if (ability.shortEffect != null) ...[
                  const SizedBox(height: 12),
                  Text(ability.shortEffect!),
                ],
                if (ability.effect != null) ...[
                  const SizedBox(height: 12),
                  Text(ability.effect!),
                ],
                if (pokemon.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  Text('Pokémon', style: theme.textTheme.titleMedium),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    children: [
                      for (final p in pokemon)
                        Chip(label: Text(p.pokemon.name)),
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
