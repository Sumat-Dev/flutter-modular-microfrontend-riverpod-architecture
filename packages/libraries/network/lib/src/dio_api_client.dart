import 'package:core/core.dart' show AppException;
import 'package:dio/dio.dart';

import 'api_client.dart';
import 'network_exception_mapper.dart';

/// Dio-backed [ApiClient]. Owns base URL/timeouts and translates
/// [DioException]s into domain-safe [AppException]s.
class DioApiClient implements ApiClient {
  DioApiClient({Dio? dio, String baseUrl = 'https://pokeapi.co/api/v2/'})
    : _dio =
          dio ??
          Dio(
            BaseOptions(
              baseUrl: baseUrl,
              connectTimeout: const Duration(seconds: 15),
              receiveTimeout: const Duration(seconds: 15),
            ),
          );

  final Dio _dio;

  @override
  Future<T> get<T>(String path, {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.get<T>(
        path,
        queryParameters: queryParameters,
      );
      final data = response.data;
      if (data == null) {
        throw const NetworkExceptionMapperFallback();
      }
      return data;
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }
}
