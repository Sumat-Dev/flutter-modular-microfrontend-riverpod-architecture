import 'package:core/src/error/failures.dart';
import 'package:dartz/dartz.dart';

/// Convenience typedef for an async repository/use case result.
///
/// Backed by dartz [Either]: [Left] carries a [Failure], [Right] the value.
typedef ResultFuture<T> = Future<Either<Failure, T>>;

/// Synchronous variant of [ResultFuture].
typedef ResultOr<T> = Either<Failure, T>;

/// A decoded JSON object.
typedef DataMap = Map<String, dynamic>;
