import 'package:core/core.dart';
import 'package:test/test.dart';

void main() {
  group('Either (dartz) result', () {
    test('right folds to the right branch', () {
      const ResultOr<int> r = Right(42);
      expect(r.isRight(), isTrue);
      final out = r.fold((_) => -1, (v) => v * 2);
      expect(out, 84);
    });

    test('left folds to the left branch', () {
      const ResultOr<int> r = Left(CacheFailure(message: 'boom'));
      expect(r.isLeft(), isTrue);
      final out = r.fold((f) => f.message, (v) => '$v');
      expect(out, 'boom');
    });
  });

  group('PageRequest', () {
    test('next advances offset by limit', () {
      const req = PageRequest();
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
