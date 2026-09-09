/// Exceptions are thrown by the DATA layer (datasources / mappers).
/// Repositories catch these and convert them into [Failure]s.
library;

/// Base class for all app-level exceptions raised in the data layer.
sealed class AppException implements Exception {
  const AppException(this.message, {this.statusCode});

  final String message;
  final int? statusCode;

  @override
  String toString() =>
      '$runtimeType(message: $message, statusCode: $statusCode)';
}

/// Network connectivity / transport-level problem (timeouts, no connection).
class NetworkException extends AppException {
  const NetworkException(super.message, {super.statusCode});
}

/// Server responded with a non-success status code.
class ServerException extends AppException {
  const ServerException(super.message, {super.statusCode});
}

/// Local cache read/write problem.
class CacheException extends AppException {
  const CacheException(super.message);
}

/// Response could not be parsed / mapped into a model.
class ParsingException extends AppException {
  const ParsingException(super.message);
}
