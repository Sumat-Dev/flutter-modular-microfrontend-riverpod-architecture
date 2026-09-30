import 'package:feature_items/src/presentation/providers/item_detail_provider.dart';
import 'package:feature_items/src/presentation/utils/failure_message.dart';
import 'package:feature_items/src/presentation/widgets/item_attribute_chip.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:ui_components/ui_components.dart';

class ItemDetailPage extends ConsumerWidget {
  const ItemDetailPage({required this.name, super.key});

  final String name;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detail = ref.watch(itemDetailProvider(name));
    return Scaffold(
      appBar: AppBar(title: Text(name)),
      body: detail.when(
        loading: () => const AppLoadingView(),
        error: (error, _) => AppErrorView(
          message: failureToMessage(error),
          onRetry: () => ref.invalidate(itemDetailProvider(name)),
        ),
        data: (item) => SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.network(
                  item.imageUrl,
                  height: 96,
                  errorBuilder: (_, _, _) =>
                      const Icon(Icons.inventory_2, size: 96),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                '#${item.id}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: [
                  Chip(label: Text('category: ${item.category}')),
                  Chip(label: Text('cost: ${item.cost}')),
                  if (item.flingPower != null)
                    Chip(label: Text('fling: ${item.flingPower}')),
                ],
              ),
              if (item.effect.isNotEmpty) ...[
                const SizedBox(height: 16),
                Text('Effect', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8),
                Text(item.effect),
              ],
              if (item.attributes.isNotEmpty) ...[
                const SizedBox(height: 16),
                Text(
                  'Attributes',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (final attribute in item.attributes)
                      ItemAttributeChip(attribute: attribute),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
