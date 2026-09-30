import 'package:feature_items/src/presentation/providers/item_detail_provider.dart';
import 'package:feature_items/src/presentation/utils/failure_message.dart';
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
      body: AppAsyncView(
        isLoading: detail.isLoading,
        hasError: detail.hasError,
        data: detail.value,
        errorMessage: detail.hasError ? failureToMessage(detail.error!) : null,
        onRetry: () => ref.invalidate(itemDetailProvider(name)),
        dataBuilder: (context, item) => SingleChildScrollView(
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
              AppChipWrap(
                labels: [
                  'category: ${item.category}',
                  'cost: ${item.cost}',
                  if (item.flingPower != null) 'fling: ${item.flingPower}',
                ],
              ),
              if (item.effect.isNotEmpty) ...[
                const AppSectionHeader(title: 'Effect'),
                Text(item.effect),
              ],
              if (item.attributes.isNotEmpty) ...[
                const AppSectionHeader(title: 'Attributes'),
                AppChipWrap(runSpacing: 8, labels: item.attributes),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
