import 'package:feature_pokemon/src/presentation/providers/nature_detail_provider.dart';
import 'package:feature_pokemon/src/presentation/utils/failure_message.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:ui_components/ui_components.dart';

class NatureDetailPage extends ConsumerWidget {
  const NatureDetailPage({required this.idOrName, super.key});

  final String idOrName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detail = ref.watch(natureDetailProvider(idOrName));
    return Scaffold(
      appBar: AppBar(title: Text(idOrName)),
      body: detail.when(
        loading: () => const AppLoadingView(),
        error: (error, _) => AppErrorView(
          message: failureToMessage(error),
          onRetry: () => ref.invalidate(natureDetailProvider(idOrName)),
        ),
        data: (nature) {
          final theme = Theme.of(context);
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  nature.displayName ?? nature.name,
                  style: theme.textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text('#${nature.id}'),
                const SizedBox(height: 12),
                if (nature.increasedStat != null)
                  Text('Increased stat: ${nature.increasedStat!.name}'),
                if (nature.decreasedStat != null)
                  Text('Decreased stat: ${nature.decreasedStat!.name}'),
                if (nature.likesFlavor != null)
                  Text('Likes flavor: ${nature.likesFlavor!.name}'),
                if (nature.hatesFlavor != null)
                  Text('Hates flavor: ${nature.hatesFlavor!.name}'),
              ],
            ),
          );
        },
      ),
    );
  }
}
