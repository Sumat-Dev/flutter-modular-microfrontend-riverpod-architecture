import 'package:library_core/library_core.dart';

/// Presentation-layer helper that turns a domain [Failure] into a message the
/// user can read. Keeping this in presentation avoids leaking UI strings into
/// the domain.
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
