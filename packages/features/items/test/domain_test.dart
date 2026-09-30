import 'package:core/core.dart';
import 'package:feature_items/src/domain/entities/item.dart';
import 'package:feature_items/src/domain/entities/item_detail.dart';
import 'package:feature_items/src/domain/repositories/item_repository.dart';
import 'package:feature_items/src/domain/usecases/get_item.dart';
import 'package:feature_items/src/domain/usecases/get_item_list.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockRepo extends Mock implements ItemRepository {}

class _FakePageRequest extends Fake implements PageRequest {}

ItemDetail _detail() => const ItemDetail(
  id: 1,
  name: 'master-ball',
  cost: 0,
  category: 'standard-balls',
  attributes: ['holdable'],
  effect: 'Always catches.',
  flingPower: 10,
  spriteUrl: 'https://img/mb.png',
);

void main() {
  setUpAll(() {
    registerFallbackValue(_FakePageRequest());
  });

  late _MockRepo repo;

  setUp(() {
    repo = _MockRepo();
  });

  group('GetItemList use case', () {
    test('delegates to repository and returns its result', () async {
      const page = PaginatedResult<Item>(
        count: 1,
        items: [Item(id: 1, name: 'master-ball')],
      );
      when(
        () => repo.getItemList(any()),
      ).thenAnswer((_) async => const Right(page));

      final result = await GetItemList(repo)(const PageRequest());

      expect(result.isRight(), isTrue);
      expect((result as Right).value, page);
      verify(() => repo.getItemList(const PageRequest())).called(1);
    });

    test('propagates failure from repository', () async {
      when(
        () => repo.getItemList(any()),
      ).thenAnswer((_) async => const Left(NetworkFailure(message: 'x')));

      final result = await GetItemList(repo)(const PageRequest(offset: 20));

      expect(result.isLeft(), isTrue);
      expect((result as Left).value, isA<NetworkFailure>());
    });
  });

  group('GetItem use case', () {
    test('delegates to repository and returns detail', () async {
      when(() => repo.getItem(any())).thenAnswer((_) async => Right(_detail()));

      final result = await GetItem(repo)('master-ball');

      expect(result.isRight(), isTrue);
      expect(((result as Right).value as ItemDetail).name, 'master-ball');
      verify(() => repo.getItem('master-ball')).called(1);
    });

    test('propagates failure from repository', () async {
      when(
        () => repo.getItem(any()),
      ).thenAnswer((_) async => const Left(ServerFailure(message: 'x')));

      final result = await GetItem(repo)('missing');

      expect(result.isLeft(), isTrue);
      expect((result as Left).value, isA<ServerFailure>());
    });
  });

  group('Item entity', () {
    test('imageUrl is derived from name', () {
      const item = Item(id: 1, name: 'master-ball');
      expect(item.imageUrl, contains('master-ball.png'));
    });

    test('value equality via Equatable props', () {
      expect(
        const Item(id: 1, name: 'master-ball'),
        const Item(id: 1, name: 'master-ball'),
      );
      expect(
        const Item(id: 1, name: 'master-ball'),
        isNot(const Item(id: 2, name: 'potion')),
      );
    });
  });

  group('ItemDetail entity', () {
    test('summary maps to an Item', () {
      expect(_detail().summary, const Item(id: 1, name: 'master-ball'));
    });

    test('imageUrl uses spriteUrl when present, else summary imageUrl', () {
      expect(_detail().imageUrl, 'https://img/mb.png');

      const noSprite = ItemDetail(
        id: 1,
        name: 'master-ball',
        cost: 0,
        category: 'standard-balls',
        attributes: ['holdable'],
        effect: 'e',
      );
      expect(noSprite.imageUrl, contains('master-ball.png'));
    });

    test('value equality via Equatable props', () {
      expect(_detail(), _detail());
    });
  });
}
