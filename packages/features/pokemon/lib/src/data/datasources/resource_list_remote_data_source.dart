import 'package:core/core.dart';
import 'package:feature_pokemon/src/data/models/common/named_api_resource_model.dart';
import 'package:network/network.dart';

/// Shared datasource for the standard PokéAPI list shape:
/// `{ count, next, previous, results: [{ name, url }] }`.
///
/// Reused by every "reference" resource (ability, type, nature, ...) so the
/// pagination logic is written exactly once.
class ResourceListRemoteDataSource {
  const ResourceListRemoteDataSource(this._client);

  final ApiClient _client;

  Future<
    ({
      int count,
      String? next,
      String? previous,
      List<NamedApiResourceModel> items,
    })
  >
  fetchList({
    required String path,
    required int offset,
    required int limit,
  }) async {
    final json = await _client.get<DataMap>(
      path,
      queryParameters: {'offset': offset, 'limit': limit},
    );
    try {
      final results = (json['results'] as List<dynamic>)
          .toNamedApiResourceModels();
      return (
        count: json['count'] as int,
        next: json['next'] as String?,
        previous: json['previous'] as String?,
        items: results,
      );
    } on Object catch (e) {
      throw ParsingException(message: 'Failed to parse "$path" list: $e');
    }
  }

  /// Fetches a single resource detail JSON object at `path/{idOrName}`.
  Future<DataMap> fetchDetail({
    required String path,
    required String idOrName,
  }) => _client.get<DataMap>('$path/$idOrName');
}
