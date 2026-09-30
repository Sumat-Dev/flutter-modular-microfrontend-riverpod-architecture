import 'package:core/core.dart';
import 'package:equatable/equatable.dart';

import 'package:feature_pokemon/src/domain/entities/common/named_api_resource.dart';
import 'package:feature_pokemon/src/domain/repositories/resource_list_repository.dart';

/// Parameters for [GetResourceList]: which resource [path] and which [page].
class ResourceListParams extends Equatable {
  const ResourceListParams({required this.path, required this.page});

  final String path;
  final PageRequest page;

  @override
  List<Object?> get props => [path, page];
}

/// Generic use case to browse any standard named-resource list.
class GetResourceList
    implements
        UseCaseWithParams<
          PaginatedResult<NamedApiResource>,
          ResourceListParams
        > {
  const GetResourceList(this._repository);

  final ResourceListRepository _repository;

  @override
  ResultFuture<PaginatedResult<NamedApiResource>> call(
    ResourceListParams params,
  ) => _repository.getList(path: params.path, page: params.page);
}
