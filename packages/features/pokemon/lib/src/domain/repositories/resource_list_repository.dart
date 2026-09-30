import 'package:core/core.dart';

import 'package:feature_pokemon/src/domain/entities/common/named_api_resource.dart';

/// Generic repository contract for browsing any standard PokéAPI named-resource
/// list (`/ability`, `/type`, `/nature`, ...). The `path` selects the resource.
// A single-method contract is intentional: it mirrors the repository pattern
// used across this feature and keeps the domain boundary explicit.
// ignore: one_member_abstracts
abstract interface class ResourceListRepository {
  ResultFuture<PaginatedResult<NamedApiResource>> getList({
    required String path,
    required PageRequest page,
  });
}
