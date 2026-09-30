import 'dart:async';

import 'package:material_ui/material_ui.dart';
import 'package:ui_components/src/constants/app_constants.dart';

/// A vertically scrolling, infinitely-paginated list with pull-to-refresh and a
/// trailing progress indicator while the next page loads.
///
/// Consolidates the `ScrollController` + scroll-threshold + `ListView.builder`
/// + trailing loader + `RefreshIndicator` boilerplate that every feature list
/// page previously duplicated. Feature-agnostic: callers supply the [items],
/// an [itemBuilder], and the [onLoadMore] / [onRefresh] callbacks.
class AppPaginatedListView<T> extends StatefulWidget {
  const AppPaginatedListView({
    required this.items,
    required this.hasMore,
    required this.itemBuilder,
    required this.onLoadMore,
    required this.onRefresh,
    super.key,
    this.loadMoreThreshold = 300,
    this.padding,
  });

  /// The currently loaded items.
  final List<T> items;

  /// Whether more pages are available (controls the trailing loader).
  final bool hasMore;

  /// Builds a row for the item at a given index.
  final Widget Function(BuildContext context, T item, int index) itemBuilder;

  /// Invoked when the user scrolls near the end of the list.
  final Future<void> Function() onLoadMore;

  /// Invoked on pull-to-refresh.
  final Future<void> Function() onRefresh;

  /// Distance (in px) from the bottom at which [onLoadMore] fires.
  final double loadMoreThreshold;

  /// Optional padding around the list.
  final EdgeInsetsGeometry? padding;

  @override
  State<AppPaginatedListView<T>> createState() =>
      _AppPaginatedListViewState<T>();
}

class _AppPaginatedListViewState<T> extends State<AppPaginatedListView<T>> {
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
    if (!widget.hasMore) return;
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - widget.loadMoreThreshold) {
      unawaited(widget.onLoadMore());
    }
  }

  @override
  Widget build(BuildContext context) {
    final itemCount = widget.items.length + (widget.hasMore ? 1 : 0);
    return RefreshIndicator(
      onRefresh: widget.onRefresh,
      child: ListView.builder(
        controller: _scrollController,
        padding: widget.padding,
        itemCount: itemCount,
        itemBuilder: (context, index) {
          if (index >= widget.items.length) {
            return const Padding(
              padding: EdgeInsets.all(kSpacing / 2),
              child: Center(child: CircularProgressIndicator.adaptive()),
            );
          }
          return widget.itemBuilder(context, widget.items[index], index);
        },
      ),
    );
  }
}
