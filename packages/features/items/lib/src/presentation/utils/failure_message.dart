import 'package:core/core.dart';

/// Maps an error into a short, user-facing message.
///
/// The per-[Failure] copy now lives in core ([Failure.userMessage]) so every
/// feature stays consistent; this thin wrapper keeps a feature-local entry
/// point and handles non-[Failure] errors defensively.
String failureToMessage(Object error) =>
    error is Failure ? error.userMessage : 'Something went wrong.';
