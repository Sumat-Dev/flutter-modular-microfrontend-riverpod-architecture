import 'package:equatable/equatable.dart';

/// Exceptions are thrown by the DATA layer (datasources / mappers).
/// Repositories catch these and convert them into `Failure`s.
///
/// Modelled after the reference architecture: exceptions extend [Equatable]
/// (value equality) and take named parameters.
sealed class AppException extends Equatable implements Exception {
  const AppException({required this.message, this.statusCode});

  final String message;
  final int? statusCode;

  @override
  List<Object?> get props => [message, statusCode];
}

/// Network connectivity / transport-level problem (timeouts, no connection).
class NetworkException extends AppException {
  const NetworkException({required super.message, super.statusCode});
}

/// Server responded with a non-success status code.
class ServerException extends AppException {
  const ServerException({required super.message, super.statusCode});
}

/// Local cache read/write problem.
class CacheException extends AppException {
  const CacheException({required super.message, super.statusCode});
}

/// Response could not be parsed / mapped into a model.
class ParsingException extends AppException {
  const ParsingException({required super.message, super.statusCode});
}
