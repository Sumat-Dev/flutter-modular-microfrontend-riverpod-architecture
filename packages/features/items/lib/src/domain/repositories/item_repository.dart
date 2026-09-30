import 'package:core/core.dart';

import 'package:feature_items/src/domain/entities/item.dart';
import 'package:feature_items/src/domain/entities/item_detail.dart';

abstract interface class ItemRepository {
  ResultFuture<PaginatedResult<Item>> getItemList(PageRequest page);

  ResultFuture<ItemDetail> getItem(String name);
}
