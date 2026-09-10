/// core
///
/// Generic, framework-independent infrastructure shared by all features.
/// Contains NO feature-specific business logic and does NOT import Flutter,
/// Riverpod, or Dio.
library;

export 'package:dartz/dartz.dart' show Either, Left, Right, Unit, unit;

export 'src/error/exceptions.dart';
export 'src/error/failures.dart';
export 'src/pagination/page_request.dart';
export 'src/pagination/paginated_result.dart';
export 'src/usecase/usecase.dart';
export 'src/utils/typedefs.dart';
