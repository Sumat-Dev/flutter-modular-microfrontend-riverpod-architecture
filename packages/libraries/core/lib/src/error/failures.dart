import 'package:equatable/equatable.dart';

import 'exceptions.dart';

/// Failures live in the DOMAIN layer and are surfaced to presentation.
/// They are the domain-safe counterpart of data-layer [AppException]s.
///
/// Modelled after the reference architecture: failures extend [Equatable]
/// (value equality) and take named parameters.
sealed class Failure extends Equatable {
  const Failure({required this.message, this.statusCode});

  final String message;
  final int? statusCode;

  @override
  List<Object?> get props => [message, statusCode];
}

class NetworkFailure extends Failure {
  const NetworkFailure({required super.message, super.statusCode});

  NetworkFailure.fromException(NetworkException exception)
    : this(message: exception.message, statusCode: exception.statusCode);
}

class ServerFailure extends Failure {
  const ServerFailure({required super.message, super.statusCode});

  ServerFailure.fromException(ServerException exception)
    : this(message: exception.message, statusCode: exception.statusCode);
}

class CacheFailure extends Failure {
  const CacheFailure({required super.message, super.statusCode});

  CacheFailure.fromException(CacheException exception)
    : this(message: exception.message, statusCode: exception.statusCode);
}

/// Fallback for anything unexpected (e.g. parsing errors).
class UnexpectedFailure extends Failure {
  const UnexpectedFailure({required super.message, super.statusCode});
}
