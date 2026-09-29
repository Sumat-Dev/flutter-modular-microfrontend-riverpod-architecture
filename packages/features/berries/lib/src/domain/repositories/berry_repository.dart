import 'package:core/core.dart';

import 'package:feature_berries/src/domain/entities/berry.dart';
import 'package:feature_berries/src/domain/entities/berry_detail.dart';

abstract interface class BerryRepository {
  ResultFuture<PaginatedResult<Berry>> getBerryList(PageRequest page);

  ResultFuture<BerryDetail> getBerry(String name);
}
