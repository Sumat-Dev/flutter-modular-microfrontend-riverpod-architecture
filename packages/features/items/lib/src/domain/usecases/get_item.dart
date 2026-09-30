import 'package:core/core.dart';

import 'package:feature_items/src/domain/entities/item_detail.dart';
import 'package:feature_items/src/domain/repositories/item_repository.dart';

class GetItem implements UseCaseWithParams<ItemDetail, String> {
  const GetItem(this._repository);

  final ItemRepository _repository;

  @override
  ResultFuture<ItemDetail> call(String params) => _repository.getItem(params);
}
