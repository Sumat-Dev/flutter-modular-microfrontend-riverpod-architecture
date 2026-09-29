import 'package:core/core.dart';
import 'package:feature_pokemon/src/presentation/utils/failure_message.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('failureToMessage', () {
    test('NetworkFailure -> connection message', () {
      expect(
        failureToMessage(const NetworkFailure(message: 'offline')),
        'No internet connection. Please try again.',
      );
    });

    test('ServerFailure -> server unavailable message', () {
      expect(
        failureToMessage(const ServerFailure(message: '500')),
        'The server is unavailable right now.',
      );
    });

    test('CacheFailure -> local data message', () {
      expect(
        failureToMessage(const CacheFailure(message: 'corrupt')),
        'Could not read local data.',
      );
    });

    test('UnexpectedFailure -> generic message', () {
      expect(
        failureToMessage(const UnexpectedFailure(message: 'boom')),
        'Something went wrong.',
      );
    });

    test('non-Failure error -> generic message', () {
      expect(failureToMessage(Exception('random')), 'Something went wrong.');
      expect(failureToMessage('a plain string'), 'Something went wrong.');
    });
  });
}
