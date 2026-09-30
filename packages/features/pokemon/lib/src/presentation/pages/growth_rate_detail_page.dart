import 'package:feature_pokemon/src/presentation/providers/growth_rate_detail_provider.dart';
import 'package:feature_pokemon/src/presentation/utils/failure_message.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:ui_components/ui_components.dart';

class GrowthRateDetailPage extends ConsumerWidget {
  const GrowthRateDetailPage({required this.idOrName, super.key});

  final String idOrName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detail = ref.watch(growthRateDetailProvider(idOrName));
    return Scaffold(
      appBar: AppBar(title: Text(idOrName)),
      body: AppAsyncView(
        isLoading: detail.isLoading,
        hasError: detail.hasError,
        data: detail.value,
        errorMessage: detail.hasError ? failureToMessage(detail.error!) : null,
        onRetry: () => ref.invalidate(growthRateDetailProvider(idOrName)),
        dataBuilder: (context, rate) {
          final theme = Theme.of(context);
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(rate.name, style: theme.textTheme.titleLarge),
                const SizedBox(height: 8),
                Text('#${rate.id}'),
                const SizedBox(height: 12),
                Text('Formula: ${rate.formula}'),
                if (rate.description != null) ...[
                  const SizedBox(height: 12),
                  Text(rate.description!),
                ],
                const SizedBox(height: 12),
                Text('Levels: ${rate.levels.length}'),
              ],
            ),
          );
        },
      ),
    );
  }
}
