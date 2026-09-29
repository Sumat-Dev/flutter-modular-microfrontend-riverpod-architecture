import 'package:core/core.dart';
import 'package:feature_berries/src/data/datasources/berry_local_data_source.dart';
import 'package:feature_berries/src/data/datasources/berry_remote_data_source.dart';
import 'package:feature_berries/src/domain/entities/berry.dart';
import 'package:feature_berries/src/domain/entities/berry_detail.dart';
import 'package:feature_berries/src/domain/repositories/berry_repository.dart';

class BerryRepositoryImpl implements BerryRepository {
  const BerryRepositoryImpl({
    required BerryRemoteDataSource remote,
    required BerryLocalDataSource local,
  }) : _remote = remote,
       _local = local;

  final BerryRemoteDataSource _remote;
  final BerryLocalDataSource _local;

  @override
  ResultFuture<PaginatedResult<Berry>> getBerryList(PageRequest page) async {
    try {
      final res = await _remote.fetchBerryList(
        offset: page.offset,
        limit: page.limit,
      );
      final result = PaginatedResult<Berry>(
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
  ResultFuture<BerryDetail> getBerry(String name) async {
    // 1. Try cache. A cache failure must not break the feature (§11).
    try {
      final cached = await _local.readBerry(name);
      if (cached != null) {
        return Right(cached.toEntity());
      }
    } on CacheException {
      // Ignore and fall through to remote.
    }

    // 2. Cache miss → remote → save → entity.
    try {
      final model = await _remote.fetchBerry(name);
      try {
        await _local.writeBerry(model);
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
