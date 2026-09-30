import 'package:core/core.dart';

import 'package:feature_items/src/domain/entities/item.dart';
import 'package:feature_items/src/domain/repositories/item_repository.dart';

class GetItemList
    implements UseCaseWithParams<PaginatedResult<Item>, PageRequest> {
  const GetItemList(this._repository);

  final ItemRepository _repository;

  @override
  ResultFuture<PaginatedResult<Item>> call(PageRequest params) =>
      _repository.getItemList(params);
}
