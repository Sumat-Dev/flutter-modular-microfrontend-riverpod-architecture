import 'package:library_core/library_core.dart';
import 'package:test/test.dart';

void main() {
  group('Result', () {
    test('success folds to success branch', () {
      const Result<int> r = Result.success(42);
      expect(r.isSuccess, isTrue);
      final out = r.when(success: (v) => v * 2, failure: (_) => -1);
      expect(out, 84);
    });

    test('failure folds to failure branch', () {
      const Result<int> r = Result.failure(CacheFailure('boom'));
      expect(r.isFailure, isTrue);
      final out = r.when(success: (v) => v, failure: (f) => f.message);
      expect(out, 'boom');
    });
  });

  group('PageRequest', () {
    test('next advances offset by limit', () {
      const req = PageRequest(offset: 0, limit: 20);
      expect(req.next().offset, 20);
      expect(req.next().limit, 20);
    });
  });

  group('PaginatedResult', () {
    test('map transforms items and preserves paging', () {
      const page = PaginatedResult<int>(count: 2, items: [1, 2], next: 'n');
      final mapped = page.map((i) => i.toString());
      expect(mapped.items, ['1', '2']);
      expect(mapped.hasMore, isTrue);
    });
  });
}
