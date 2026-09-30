import 'package:feature_berries/src/presentation/providers/berry_list_provider.dart';
import 'package:feature_berries/src/presentation/utils/failure_message.dart';
import 'package:feature_berries/src/presentation/widgets/berry_card.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:ui_components/ui_components.dart';

class BerryPage extends ConsumerWidget {
  const BerryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(berryListProvider);
    final notifier = ref.read(berryListProvider.notifier);
    return Scaffold(
      appBar: AppBar(title: const Text('Berries')),
      body: AppAsyncView(
        isLoading: state.isLoading,
        hasError: state.hasError,
        data: state.value,
        loadingMessage: 'Loading berries...',
        errorMessage: state.hasError ? failureToMessage(state.error!) : null,
        onRetry: notifier.refresh,
        dataBuilder: (context, data) => AppPaginatedListView(
          items: data.items,
          hasMore: data.hasMore,
          onLoadMore: notifier.loadMore,
          onRefresh: notifier.refresh,
          itemBuilder: (context, berry, index) => BerryCard(
            berry: berry,
            onTap: () => Modular.to.pushNamed('/berries/${berry.name}'),
          ),
        ),
      ),
    );
  }
}
