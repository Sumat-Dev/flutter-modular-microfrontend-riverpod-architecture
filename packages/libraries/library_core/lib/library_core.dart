/// library_core
///
/// Generic, framework-independent infrastructure shared by all features.
/// Contains NO feature-specific business logic and does NOT import Flutter,
/// Riverpod, or Dio.
library;

export 'src/error/exceptions.dart';
export 'src/error/failures.dart';
export 'src/pagination/page_request.dart';
export 'src/pagination/paginated_result.dart';
export 'src/typedefs.dart';
export 'src/usecase/usecase.dart';
export 'src/utils/result.dart';
