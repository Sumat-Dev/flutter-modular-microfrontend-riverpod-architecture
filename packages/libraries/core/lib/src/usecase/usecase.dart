import 'package:core/src/utils/typedefs.dart';

/// Generic use case contract. `Params` is the input; use
/// [UseCaseWithoutParams] when a use case takes no arguments. Use cases live in
/// the DOMAIN layer.
// A single-method contract is intentional here: use cases are deliberate
// domain abstractions, not a substitute for a bare function type.
// ignore: one_member_abstracts
abstract interface class UseCaseWithParams<T, Params> {
  const UseCaseWithParams();

  ResultFuture<T> call(Params params);
}

// A single-method contract is intentional here: use cases are deliberate
// domain abstractions, not a substitute for a bare function type.
// ignore: one_member_abstracts
abstract class UseCaseWithoutParams<T> {
  const UseCaseWithoutParams();

  ResultFuture<T> call();
}
