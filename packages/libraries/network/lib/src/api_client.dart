import 'package:core/core.dart' show NetworkException, ServerException;

/// Transport-agnostic API contract. Feature datasources depend on this,
/// never on Dio directly (see plan §9).
// A single-method contract is intentional: this abstraction decouples feature
// datasources from the concrete HTTP client (Dio).
// ignore: one_member_abstracts
abstract interface class ApiClient {
  /// Performs a GET request and returns the decoded JSON body.
  ///
  /// Throws [NetworkException]/[ServerException] (from core) on
  /// failure via the implementation's error mapping.
  Future<T> get<T>(String path, {Map<String, dynamic>? queryParameters});
}
