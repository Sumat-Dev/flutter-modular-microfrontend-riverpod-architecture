import 'package:core/core.dart';
import 'package:test/test.dart';

void main() {
  group('Failure.fromException', () {
    test('maps NetworkException to NetworkFailure', () {
      final f = Failure.fromException(
        const NetworkException(message: 'no net', statusCode: 0),
      );
      expect(f, isA<NetworkFailure>());
      expect(f.message, 'no net');
      expect(f.statusCode, 0);
    });

    test('maps ServerException to ServerFailure', () {
      final f = Failure.fromException(
        const ServerException(message: 'boom', statusCode: 500),
      );
      expect(f, isA<ServerFailure>());
      expect(f.message, 'boom');
      expect(f.statusCode, 500);
    });

    test('maps CacheException to CacheFailure', () {
      final f = Failure.fromException(const CacheException(message: 'cache'));
      expect(f, isA<CacheFailure>());
      expect(f.message, 'cache');
    });

    test('maps ParsingException to UnexpectedFailure', () {
      final f = Failure.fromException(const ParsingException(message: 'parse'));
      expect(f, isA<UnexpectedFailure>());
      expect(f.message, 'parse');
    });
  });

  group('Failure.userMessage', () {
    test('network', () {
      expect(
        const NetworkFailure(message: 'x').userMessage,
        'No internet connection. Please try again.',
      );
    });

    test('server', () {
      expect(
        const ServerFailure(message: 'x').userMessage,
        'The server is unavailable right now.',
      );
    });

    test('cache', () {
      expect(
        const CacheFailure(message: 'x').userMessage,
        'Could not read local data.',
      );
    });

    test('unexpected', () {
      expect(
        const UnexpectedFailure(message: 'x').userMessage,
        'Something went wrong.',
      );
    });
  });
}
