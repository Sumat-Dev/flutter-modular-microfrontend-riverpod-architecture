import 'package:feature_pokemon/src/presentation/providers/resource_list_provider.dart';
import 'package:feature_pokemon/src/presentation/utils/failure_message.dart';
import 'package:feature_pokemon/src/presentation/utils/resource_catalog.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:ui_components/ui_components.dart';

/// Generic paginated list screen reused by every browseable reference
/// resource. The [descriptor] selects the API path, title and detail route.
class ResourceListPage extends ConsumerWidget {
  const ResourceListPage({required this.descriptor, super.key});

  final ResourceDescriptor descriptor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final path = descriptor.apiPath;
    final state = ref.watch(resourceListProvider(path));
    final notifier = ref.read(resourceListProvider(path).notifier);
    return Scaffold(
      appBar: AppBar(title: Text(descriptor.title)),
      body: AppAsyncView(
        isLoading: state.isLoading,
        hasError: state.hasError,
        data: state.value,
        errorMessage: state.hasError ? failureToMessage(state.error!) : null,
        onRetry: notifier.refresh,
        dataBuilder: (context, data) => AppPaginatedListView(
          items: data.items,
          hasMore: data.hasMore,
          onLoadMore: notifier.loadMore,
          onRefresh: notifier.refresh,
          itemBuilder: (context, item, index) {
            final label = item.name.isEmpty ? '#${item.id}' : item.name;
            return ListTile(
              title: Text(label),
              subtitle: Text('#${item.id}'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => Modular.to.pushNamed(
                '/pokemon/resources/'
                '${descriptor.routeSegment}/${item.id}',
              ),
            );
          },
        ),
      ),
    );
  }
}
