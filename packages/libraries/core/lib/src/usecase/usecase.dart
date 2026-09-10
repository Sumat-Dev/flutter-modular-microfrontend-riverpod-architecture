import '../utils/typedefs.dart';

/// Generic use case contract. [Params] is the input; use [NoParams] when a use
/// case takes no arguments. Use cases live in the DOMAIN layer.
abstract interface class UseCaseWithParams<T, Params> {
  const UseCaseWithParams();

  ResultFuture<T> call(Params params);
}

abstract class UseCaseWithoutParams<T> {
  const UseCaseWithoutParams();

  ResultFuture<T> call();
}
