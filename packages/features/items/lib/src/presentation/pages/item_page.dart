import 'dart:async';

import 'package:feature_items/src/presentation/providers/item_list_provider.dart';
import 'package:feature_items/src/presentation/utils/failure_message.dart';
import 'package:feature_items/src/presentation/widgets/item_card.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:ui_components/ui_components.dart';

class ItemPage extends ConsumerStatefulWidget {
  const ItemPage({super.key});

  @override
  ConsumerState<ItemPage> createState() => _ItemPageState();
}

class _ItemPageState extends ConsumerState<ItemPage> {
  final _scrollController = ScrollController();

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
      unawaited(ref.read(itemListProvider.notifier).loadMore());
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(itemListProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Items')),
      body: state.when(
        loading: () => const AppLoadingView(message: 'Loading items...'),
        error: (error, _) => AppErrorView(
          message: failureToMessage(error),
          onRetry: () => ref.read(itemListProvider.notifier).refresh(),
        ),
        data: (data) {
          return RefreshIndicator(
            onRefresh: () => ref.read(itemListProvider.notifier).refresh(),
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
                return ItemCard(
                  item: item,
                  onTap: () => Modular.to.pushNamed('/items/${item.name}'),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
