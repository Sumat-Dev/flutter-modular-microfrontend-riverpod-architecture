import 'package:equatable/equatable.dart';

/// Failures live in the DOMAIN layer and are surfaced to presentation.
/// They are the domain-safe counterpart of data-layer exceptions.
sealed class Failure extends Equatable {
  const Failure(this.message, {this.statusCode});

  final String message;
  final int? statusCode;

  @override
  List<Object?> get props => [message, statusCode];
}

class NetworkFailure extends Failure {
  const NetworkFailure(super.message, {super.statusCode});
}

class ServerFailure extends Failure {
  const ServerFailure(super.message, {super.statusCode});
}

class CacheFailure extends Failure {
  const CacheFailure(super.message);
}

/// Fallback for anything unexpected (e.g. parsing errors).
class UnexpectedFailure extends Failure {
  const UnexpectedFailure(super.message);
}
