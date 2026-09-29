import 'package:core/core.dart';
import 'package:feature_berries/src/domain/entities/berry.dart';
import 'package:feature_berries/src/presentation/providers/berry_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'berry_list_provider.g.dart';

class BerryListState {
  const BerryListState({
    this.items = const [],
    this.isLoadingMore = false,
    this.hasMore = true,
    this.nextOffset = 0,
  });

  final List<Berry> items;
  final bool isLoadingMore;
  final bool hasMore;
  final int nextOffset;

  BerryListState copyWith({
    List<Berry>? items,
    bool? isLoadingMore,
    bool? hasMore,
    int? nextOffset,
  }) => BerryListState(
    items: items ?? this.items,
    isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    hasMore: hasMore ?? this.hasMore,
    nextOffset: nextOffset ?? this.nextOffset,
  );
}

@Riverpod(keepAlive: true)
class BerryList extends _$BerryList {
  static const _limit = 20;

  @override
  Future<BerryListState> build() => _fetch(const BerryListState());

  Future<BerryListState> _fetch(BerryListState current) async {
    final useCase = ref.read(getBerryListProvider);
    final result = await useCase(PageRequest(offset: current.nextOffset));
    return result.fold(
      // Deliberately rethrow the domain Failure so callers can surface it via
      // AsyncValue.error / AsyncValue.guard.
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
    state = await AsyncValue.guard(() => _fetch(const BerryListState()));
  }
}
