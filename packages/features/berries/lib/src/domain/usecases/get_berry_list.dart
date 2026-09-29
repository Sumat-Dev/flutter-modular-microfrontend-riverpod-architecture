import 'package:core/core.dart';

import 'package:feature_berries/src/domain/entities/berry.dart';
import 'package:feature_berries/src/domain/repositories/berry_repository.dart';

class GetBerryList
    implements UseCaseWithParams<PaginatedResult<Berry>, PageRequest> {
  const GetBerryList(this._repository);

  final BerryRepository _repository;

  @override
  ResultFuture<PaginatedResult<Berry>> call(PageRequest params) =>
      _repository.getBerryList(params);
}
