import 'package:feature_pokemon/src/presentation/providers/gender_detail_provider.dart';
import 'package:feature_pokemon/src/presentation/utils/failure_message.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:ui_components/ui_components.dart';

class GenderDetailPage extends ConsumerWidget {
  const GenderDetailPage({required this.idOrName, super.key});

  final String idOrName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detail = ref.watch(genderDetailProvider(idOrName));
    return Scaffold(
      appBar: AppBar(title: Text(idOrName)),
      body: detail.when(
        loading: () => const AppLoadingView(),
        error: (error, _) => AppErrorView(
          message: failureToMessage(error),
          onRetry: () => ref.invalidate(genderDetailProvider(idOrName)),
        ),
        data: (gender) {
          final theme = Theme.of(context);
          final details = gender.pokemonSpeciesDetails.take(30).toList();
          final required = gender.requiredForEvolution;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(gender.name, style: theme.textTheme.titleLarge),
                const SizedBox(height: 8),
                Text('#${gender.id}'),
                if (details.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  Text('Species', style: theme.textTheme.titleMedium),
                  const SizedBox(height: 8),
                  for (final d in details)
                    Text(
                      '${d.pokemonSpecies.name} (rate ${d.rate})',
                    ),
                ],
                if (required.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  Text(
                    'Required for evolution',
                    style: theme.textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    children: [
                      for (final r in required) Chip(label: Text(r.name)),
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
