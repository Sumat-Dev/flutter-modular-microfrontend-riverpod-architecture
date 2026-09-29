import 'package:core/core.dart';
import 'package:feature_berries/src/data/models/berry_detail_model.dart';
import 'package:feature_berries/src/data/models/berry_model.dart';
import 'package:network/network.dart';

abstract interface class BerryRemoteDataSource {
  Future<
    ({int count, String? next, String? previous, List<BerryModel> items})
  >
  fetchBerryList({required int offset, required int limit});

  Future<BerryDetailModel> fetchBerry(String name);
}

class BerryRemoteDataSourceImpl implements BerryRemoteDataSource {
  const BerryRemoteDataSourceImpl(this._client);

  final ApiClient _client;

  @override
  Future<
    ({int count, String? next, String? previous, List<BerryModel> items})
  >
  fetchBerryList({required int offset, required int limit}) async {
    final json = await _client.get<DataMap>(
      'berry',
      queryParameters: {'offset': offset, 'limit': limit},
    );
    try {
      final results = (json['results'] as List<dynamic>)
          .map((dynamic e) => BerryModel.fromListJson(e as DataMap))
          .toList();
      return (
        count: json['count'] as int,
        next: json['next'] as String?,
        previous: json['previous'] as String?,
        items: results,
      );
    } on Object catch (e) {
      throw ParsingException(message: 'Failed to parse Berry list: $e');
    }
  }

  @override
  Future<BerryDetailModel> fetchBerry(String name) async {
    final json = await _client.get<DataMap>('berry/$name');
    try {
      return BerryDetailModel.fromJson(json);
    } on Object catch (e) {
      throw ParsingException(message: 'Failed to parse Berry "$name": $e');
    }
  }
}
