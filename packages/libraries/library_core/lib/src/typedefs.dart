import 'utils/result.dart';

/// Convenience typedef for an async repository/use case result.
typedef FutureResult<T> = Future<Result<T>>;

/// A decoded JSON object.
typedef JsonMap = Map<String, dynamic>;
