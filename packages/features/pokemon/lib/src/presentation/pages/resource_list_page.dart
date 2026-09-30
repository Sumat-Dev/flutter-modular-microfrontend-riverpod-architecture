import 'dart:async';

import 'package:feature_pokemon/src/presentation/providers/resource_list_provider.dart';
import 'package:feature_pokemon/src/presentation/utils/failure_message.dart';
import 'package:feature_pokemon/src/presentation/utils/resource_catalog.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:ui_components/ui_components.dart';

/// Generic paginated list screen reused by every browseable reference
/// resource. The [descriptor] selects the API path, title and detail route.
class ResourceListPage extends ConsumerStatefulWidget {
  const ResourceListPage({required this.descriptor, super.key});

  final ResourceDescriptor descriptor;

  @override
  ConsumerState<ResourceListPage> createState() => _ResourceListPageState();
}

class _ResourceListPageState extends ConsumerState<ResourceListPage> {
  final _scrollController = ScrollController();

  String get _path => widget.descriptor.apiPath;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 300) {
      unawaited(ref.read(resourceListProvider(_path).notifier).loadMore());
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(resourceListProvider(_path));
    return Scaffold(
      appBar: AppBar(title: Text(widget.descriptor.title)),
      body: state.when(
        loading: () => const AppLoadingView(),
        error: (error, _) => AppErrorView(
          message: failureToMessage(error),
          onRetry: () =>
              ref.read(resourceListProvider(_path).notifier).refresh(),
        ),
        data: (data) {
          return RefreshIndicator(
            onRefresh: () =>
                ref.read(resourceListProvider(_path).notifier).refresh(),
            child: ListView.builder(
              controller: _scrollController,
              itemCount: data.items.length + (data.hasMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index >= data.items.length) {
                  return const Padding(
                    padding: EdgeInsets.all(16),
                    child: Center(child: CircularProgressIndicator.adaptive()),
                  );
                }
                final item = data.items[index];
                final label = item.name.isEmpty ? '#${item.id}' : item.name;
                return ListTile(
                  title: Text(label),
                  subtitle: Text('#${item.id}'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => Modular.to.pushNamed(
                    '/pokemon/resources/'
                    '${widget.descriptor.routeSegment}/${item.id}',
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
