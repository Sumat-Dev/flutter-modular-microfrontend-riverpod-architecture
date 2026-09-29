import 'dart:async';

import 'package:feature_berries/src/presentation/providers/berry_list_provider.dart';
import 'package:feature_berries/src/presentation/utils/failure_message.dart';
import 'package:feature_berries/src/presentation/widgets/berry_card.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:ui_components/ui_components.dart';

class BerryPage extends ConsumerStatefulWidget {
  const BerryPage({super.key});

  @override
  ConsumerState<BerryPage> createState() => _BerryPageState();
}

class _BerryPageState extends ConsumerState<BerryPage> {
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
      unawaited(ref.read(berryListProvider.notifier).loadMore());
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(berryListProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Berries')),
      body: state.when(
        loading: () => const AppLoadingView(message: 'Loading berries...'),
        error: (error, _) => AppErrorView(
          message: failureToMessage(error),
          onRetry: () => ref.read(berryListProvider.notifier).refresh(),
        ),
        data: (data) {
          return RefreshIndicator(
            onRefresh: () => ref.read(berryListProvider.notifier).refresh(),
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
                final berry = data.items[index];
                return BerryCard(
                  berry: berry,
                  onTap: () => Modular.to.pushNamed('/berries/${berry.name}'),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
