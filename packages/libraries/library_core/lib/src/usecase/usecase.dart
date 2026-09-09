import '../typedefs.dart';

/// Generic use case contract. [Params] is the input; use [NoParams] when a use
/// case takes no arguments. Use cases live in the DOMAIN layer.
abstract interface class UseCase<T, Params> {
  FutureResult<T> call(Params params);
}

/// Marker for use cases that take no parameters.
class NoParams {
  const NoParams();
}
