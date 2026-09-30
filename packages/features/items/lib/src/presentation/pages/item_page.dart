import 'package:feature_items/src/presentation/providers/item_list_provider.dart';
import 'package:feature_items/src/presentation/utils/failure_message.dart';
import 'package:feature_items/src/presentation/widgets/item_card.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:ui_components/ui_components.dart';

class ItemPage extends ConsumerWidget {
  const ItemPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(itemListProvider);
    final notifier = ref.read(itemListProvider.notifier);
    return Scaffold(
      appBar: AppBar(title: const Text('Items')),
      body: AppAsyncView(
        isLoading: state.isLoading,
        hasError: state.hasError,
        data: state.value,
        loadingMessage: 'Loading items...',
        errorMessage: state.hasError ? failureToMessage(state.error!) : null,
        onRetry: notifier.refresh,
        dataBuilder: (context, data) => AppPaginatedListView(
          items: data.items,
          hasMore: data.hasMore,
          onLoadMore: notifier.loadMore,
          onRefresh: notifier.refresh,
          itemBuilder: (context, item, index) => ItemCard(
            item: item,
            onTap: () => Modular.to.pushNamed('/items/${item.name}'),
          ),
        ),
      ),
    );
  }
}
