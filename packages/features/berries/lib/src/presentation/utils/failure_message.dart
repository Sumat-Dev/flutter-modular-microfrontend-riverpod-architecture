import 'package:core/core.dart';

String failureToMessage(Object error) {
  if (error is Failure) {
    return switch (error) {
      NetworkFailure() => 'No internet connection. Please try again.',
      ServerFailure() => 'The server is unavailable right now.',
      CacheFailure() => 'Could not read local data.',
      UnexpectedFailure() => 'Something went wrong.',
    };
  }
  return 'Something went wrong.';
}
