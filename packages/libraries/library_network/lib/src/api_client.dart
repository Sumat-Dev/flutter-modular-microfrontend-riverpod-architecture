/// Transport-agnostic API contract. Feature datasources depend on this,
/// never on Dio directly (see plan §9).
abstract interface class ApiClient {
  /// Performs a GET request and returns the decoded JSON body.
  ///
  /// Throws [NetworkException]/[ServerException] (from library_core) on
  /// failure via the implementation's error mapping.
  Future<T> get<T>(String path, {Map<String, dynamic>? queryParameters});
}
