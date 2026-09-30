import 'package:core/core.dart';
import 'package:feature_pokemon/src/domain/entities/common/named_api_resource.dart';
import 'package:feature_pokemon/src/domain/usecases/get_resource_list.dart';
import 'package:feature_pokemon/src/presentation/providers/resource_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'resource_list_provider.g.dart';

class ResourceListState {
  const ResourceListState({
    this.items = const [],
    this.isLoadingMore = false,
    this.hasMore = true,
    this.nextOffset = 0,
  });

  final List<NamedApiResource> items;
  final bool isLoadingMore;
  final bool hasMore;
  final int nextOffset;

  ResourceListState copyWith({
    List<NamedApiResource>? items,
    bool? isLoadingMore,
    bool? hasMore,
    int? nextOffset,
  }) => ResourceListState(
    items: items ?? this.items,
    isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    hasMore: hasMore ?? this.hasMore,
    nextOffset: nextOffset ?? this.nextOffset,
  );
}

/// Generic paginated list notifier, one instance per resource [path]
/// (e.g. 'ability', 'type', 'nature').
@riverpod
class ResourceList extends _$ResourceList {
  static const _limit = 20;

  late String _path;

  @override
  Future<ResourceListState> build(String path) {
    _path = path;
    return _fetch(const ResourceListState());
  }

  Future<ResourceListState> _fetch(ResourceListState current) async {
    final useCase = ref.read(getResourceListProvider);
    final result = await useCase(
      ResourceListParams(
        path: _path,
        page: PageRequest(offset: current.nextOffset),
      ),
    );
    return result.fold(
      // Deliberately rethrow so callers surface it via AsyncValue.
      // ignore: only_throw_errors
      (f) => throw f,
      (page) => current.copyWith(
        items: [...current.items, ...page.items],
        hasMore: page.hasMore,
        nextOffset: current.nextOffset + _limit,
        isLoadingMore: false,
      ),
    );
  }

  Future<void> loadMore() async {
    final current = state.value;
    if (current == null || current.isLoadingMore || !current.hasMore) {
      return;
    }
    state = AsyncData(current.copyWith(isLoadingMore: true));
    try {
      state = AsyncData(await _fetch(current));
    } on Failure catch (f, st) {
      state = AsyncError(f, st);
    }
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _fetch(const ResourceListState()));
  }
}
