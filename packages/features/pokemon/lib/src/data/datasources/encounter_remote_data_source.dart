import 'package:core/core.dart';
import 'package:feature_pokemon/src/data/models/location_area_encounter_model.dart';
import 'package:network/network.dart';

// A single-method contract is intentional: it mirrors the datasource pattern
// used across this feature.
// ignore: one_member_abstracts
abstract interface class EncounterRemoteDataSource {
  Future<List<LocationAreaEncounterModel>> fetchEncounters(String idOrName);
}

class EncounterRemoteDataSourceImpl implements EncounterRemoteDataSource {
  const EncounterRemoteDataSourceImpl(this._client);

  final ApiClient _client;

  @override
  Future<List<LocationAreaEncounterModel>> fetchEncounters(
    String idOrName,
  ) async {
    // This endpoint returns a bare JSON array (not the standard list shape).
    final raw = await _client.get<List<dynamic>>(
      'pokemon/$idOrName/encounters',
    );
    try {
      return raw
          .map(
            (dynamic e) => LocationAreaEncounterModel.fromJson(e as DataMap),
          )
          .toList();
    } on Object catch (e) {
      throw ParsingException(message: 'Failed to parse encounters: $e');
    }
  }
}
