import 'package:core/core.dart';
import 'package:dio/dio.dart';

/// Maps a [DioException] to a domain-safe [AppException] (see plan §12).
AppException mapDioException(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
    case DioExceptionType.connectionError:
      return NetworkException(
        message: e.message ?? 'Network connection error',
      );
    case DioExceptionType.badResponse:
      final status = e.response?.statusCode;
      return ServerException(
        message: 'Server responded with status $status',
        statusCode: status,
      );
    case DioExceptionType.cancel:
      return const NetworkException(message: 'Request cancelled');
    case DioExceptionType.badCertificate:
    case DioExceptionType.unknown:
    case DioExceptionType.transformTimeout:
      return NetworkException(message: e.message ?? 'Unknown network error');
  }
}

/// Thrown when a successful response contained no body.
class NetworkExceptionMapperFallback extends NetworkException {
  const NetworkExceptionMapperFallback()
    : super(message: 'Empty response body');
}
