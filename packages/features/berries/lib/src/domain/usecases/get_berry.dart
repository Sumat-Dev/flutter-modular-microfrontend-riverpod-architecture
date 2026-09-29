import 'package:core/core.dart';

import 'package:feature_berries/src/domain/entities/berry_detail.dart';
import 'package:feature_berries/src/domain/repositories/berry_repository.dart';

class GetBerry implements UseCaseWithParams<BerryDetail, String> {
  const GetBerry(this._repository);

  final BerryRepository _repository;

  @override
  ResultFuture<BerryDetail> call(String params) =>
      _repository.getBerry(params);
}
