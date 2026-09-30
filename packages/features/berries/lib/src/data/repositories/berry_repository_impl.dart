import 'package:core/core.dart';
import 'package:feature_berries/src/data/datasources/berry_remote_data_source.dart';
import 'package:feature_berries/src/domain/entities/berry.dart';
import 'package:feature_berries/src/domain/entities/berry_detail.dart';
import 'package:feature_berries/src/domain/repositories/berry_repository.dart';

class BerryRepositoryImpl implements BerryRepository {
  const BerryRepositoryImpl({required BerryRemoteDataSource remote})
    : _remote = remote;

  final BerryRemoteDataSource _remote;

  @override
  ResultFuture<PaginatedResult<Berry>> getBerryList(PageRequest page) async {
    try {
      final res = await _remote.fetchBerryList(
        offset: page.offset,
        limit: page.limit,
      );
      return Right(
        PaginatedResult<Berry>(
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
  ResultFuture<BerryDetail> getBerry(String name) async {
    try {
      final model = await _remote.fetchBerry(name);
      return Right(model.toEntity());
    } on AppException catch (e) {
      return Left(Failure.fromException(e));
    } on Object catch (e) {
      return Left(UnexpectedFailure(message: '$e'));
    }
  }
}
