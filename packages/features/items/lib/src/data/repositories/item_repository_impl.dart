import 'package:core/core.dart';
import 'package:feature_items/src/data/datasources/item_remote_data_source.dart';
import 'package:feature_items/src/domain/entities/item.dart';
import 'package:feature_items/src/domain/entities/item_detail.dart';
import 'package:feature_items/src/domain/repositories/item_repository.dart';

class ItemRepositoryImpl implements ItemRepository {
  const ItemRepositoryImpl({required ItemRemoteDataSource remote})
    : _remote = remote;

  final ItemRemoteDataSource _remote;

  @override
  ResultFuture<PaginatedResult<Item>> getItemList(PageRequest page) async {
    try {
      final res = await _remote.fetchItemList(
        offset: page.offset,
        limit: page.limit,
      );
      return Right(
        PaginatedResult<Item>(
          count: res.count,
          next: res.next,
          previous: res.previous,
          items: res.items.map((m) => m.toEntity()).toList(),
        ),
      );
    } on AppException catch (e) {
      return Left(Failure.fromException(e));
    } on Object catch (e) {
      return Left(UnexpectedFailure(message: '$e'));
    }
  }

  @override
  ResultFuture<ItemDetail> getItem(String name) async {
    try {
      final model = await _remote.fetchItem(name);
      return Right(model.toEntity());
    } on AppException catch (e) {
      return Left(Failure.fromException(e));
    } on Object catch (e) {
      return Left(UnexpectedFailure(message: '$e'));
    }
  }
}
