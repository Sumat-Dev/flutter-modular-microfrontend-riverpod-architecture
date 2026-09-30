import 'package:core/core.dart';
import 'package:feature_pokemon/src/data/datasources/resource_list_remote_data_source.dart';
import 'package:feature_pokemon/src/domain/entities/common/named_api_resource.dart';
import 'package:feature_pokemon/src/domain/repositories/resource_list_repository.dart';

class ResourceListRepositoryImpl implements ResourceListRepository {
  const ResourceListRepositoryImpl(this._remote);

  final ResourceListRemoteDataSource _remote;

  @override
  ResultFuture<PaginatedResult<NamedApiResource>> getList({
    required String path,
    required PageRequest page,
  }) async {
    try {
      final res = await _remote.fetchList(
        path: path,
        offset: page.offset,
        limit: page.limit,
      );
      return Right(
        PaginatedResult<NamedApiResource>(
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
}
