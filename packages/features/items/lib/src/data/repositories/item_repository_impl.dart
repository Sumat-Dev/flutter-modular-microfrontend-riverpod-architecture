import 'package:core/core.dart';
import 'package:feature_items/src/data/datasources/item_local_data_source.dart';
import 'package:feature_items/src/data/datasources/item_remote_data_source.dart';
import 'package:feature_items/src/domain/entities/item.dart';
import 'package:feature_items/src/domain/entities/item_detail.dart';
import 'package:feature_items/src/domain/repositories/item_repository.dart';

class ItemRepositoryImpl implements ItemRepository {
  const ItemRepositoryImpl({
    required ItemRemoteDataSource remote,
    required ItemLocalDataSource local,
  }) : _remote = remote,
       _local = local;

  final ItemRemoteDataSource _remote;
  final ItemLocalDataSource _local;

  @override
  ResultFuture<PaginatedResult<Item>> getItemList(PageRequest page) async {
    try {
      final res = await _remote.fetchItemList(
        offset: page.offset,
        limit: page.limit,
      );
      final result = PaginatedResult<Item>(
        count: res.count,
        next: res.next,
        previous: res.previous,
        items: res.items.map((m) => m.toEntity()).toList(),
      );
      return Right(result);
    } on AppException catch (e) {
      return Left(_mapException(e));
    } on Object catch (e) {
      return Left(UnexpectedFailure(message: '$e'));
    }
  }

  @override
  ResultFuture<ItemDetail> getItem(String name) async {
    // 1. Try cache. A cache failure must not break the feature (§11).
    try {
      final cached = await _local.readItem(name);
      if (cached != null) {
        return Right(cached.toEntity());
      }
    } on CacheException {
      // Ignore and fall through to remote.
    }

    // 2. Cache miss → remote → save → entity.
    try {
      final model = await _remote.fetchItem(name);
      try {
        await _local.writeItem(model);
      } on CacheException {
        // Persisting is best-effort; ignore write failures.
      }
      return Right(model.toEntity());
    } on AppException catch (e) {
      return Left(_mapException(e));
    } on Object catch (e) {
      return Left(UnexpectedFailure(message: '$e'));
    }
  }

  Failure _mapException(AppException e) => switch (e) {
    NetworkException() => NetworkFailure.fromException(e),
    ServerException() => ServerFailure.fromException(e),
    CacheException() => CacheFailure.fromException(e),
    ParsingException() => UnexpectedFailure(message: e.message),
  };
}
