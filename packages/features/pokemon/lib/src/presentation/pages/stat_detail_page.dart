import 'package:feature_pokemon/src/presentation/providers/stat_detail_provider.dart';
import 'package:feature_pokemon/src/presentation/utils/failure_message.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:ui_components/ui_components.dart';

class StatDetailPage extends ConsumerWidget {
  const StatDetailPage({required this.idOrName, super.key});

  final String idOrName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detail = ref.watch(statDetailProvider(idOrName));
    return Scaffold(
      appBar: AppBar(title: Text(idOrName)),
      body: AppAsyncView(
        isLoading: detail.isLoading,
        hasError: detail.hasError,
        data: detail.value,
        errorMessage: detail.hasError ? failureToMessage(detail.error!) : null,
        onRetry: () => ref.invalidate(statDetailProvider(idOrName)),
        dataBuilder: (context, stat) {
          final theme = Theme.of(context);
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  stat.displayName ?? stat.name,
                  style: theme.textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text('#${stat.id}'),
                const SizedBox(height: 12),
                Text('Game index: ${stat.gameIndex}'),
                Text('Battle only: ${stat.isBattleOnly}'),
                if (stat.moveDamageClass != null)
                  Text('Damage class: ${stat.moveDamageClass!.name}'),
              ],
            ),
          );
        },
      ),
    );
  }
}
