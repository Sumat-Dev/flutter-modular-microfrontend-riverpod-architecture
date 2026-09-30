import 'package:core/core.dart';
import 'package:feature_items/src/data/datasources/item_local_data_source.dart';
import 'package:feature_items/src/data/datasources/item_remote_data_source.dart';
import 'package:feature_items/src/data/models/item_detail_model.dart';
import 'package:feature_items/src/data/models/item_model.dart';
import 'package:feature_items/src/data/repositories/item_repository_impl.dart';
import 'package:feature_items/src/domain/entities/item.dart';
import 'package:feature_items/src/domain/entities/item_detail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockRemote extends Mock implements ItemRemoteDataSource {}

class _MockLocal extends Mock implements ItemLocalDataSource {}

class _FakeDetailModel extends Fake implements ItemDetailModel {}

ItemDetailModel _detailModel() => const ItemDetailModel(
  id: 1,
  name: 'master-ball',
  cost: 0,
  category: 'standard-balls',
  attributes: ['holdable'],
  effect: 'Always catches.',
  spriteUrl: 'https://img/mb.png',
);

void main() {
  setUpAll(() {
    registerFallbackValue(_FakeDetailModel());
  });

  late _MockRemote remote;
  late _MockLocal local;
  late ItemRepositoryImpl repo;

  setUp(() {
    remote = _MockRemote();
    local = _MockLocal();
    repo = ItemRepositoryImpl(remote: remote, local: local);
  });

  group('getItemList', () {
    test('maps remote result into paginated entities', () async {
      when(() => remote.fetchItemList(offset: 0, limit: 20)).thenAnswer(
        (_) async => (
          count: 1,
          next: 'next-url',
          previous: null,
          items: [const ItemModel(id: 1, name: 'master-ball')],
        ),
      );

      final result = await repo.getItemList(const PageRequest());

      expect(result.isRight(), isTrue);
      final page = (result as Right).value as PaginatedResult<Item>;
      expect(page.count, 1);
      expect(page.items.single, const Item(id: 1, name: 'master-ball'));
    });

    test('maps AppException to Failure', () async {
      when(
        () => remote.fetchItemList(offset: 0, limit: 20),
      ).thenThrow(const NetworkException(message: 'offline'));

      final result = await repo.getItemList(const PageRequest());

      expect((result as Left).value, isA<NetworkFailure>());
    });

    test('maps unexpected error to UnexpectedFailure', () async {
      when(
        () => remote.fetchItemList(offset: 0, limit: 20),
      ).thenThrow(Exception('boom'));

      final result = await repo.getItemList(const PageRequest());

      expect((result as Left).value, isA<UnexpectedFailure>());
    });
  });

  group('getItem (cache strategy §11)', () {
    test('returns cached entity on cache hit without hitting remote', () async {
      when(
        () => local.readItem('master-ball'),
      ).thenAnswer((_) async => _detailModel());

      final result = await repo.getItem('master-ball');

      expect(result.isRight(), isTrue);
      expect(((result as Right).value as ItemDetail).name, 'master-ball');
      verifyNever(() => remote.fetchItem(any()));
    });

    test('falls back to remote on cache miss and saves to cache', () async {
      when(() => local.readItem('master-ball')).thenAnswer((_) async => null);
      when(
        () => remote.fetchItem('master-ball'),
      ).thenAnswer((_) async => _detailModel());
      when(() => local.writeItem(any())).thenAnswer((_) async {});

      final result = await repo.getItem('master-ball');

      expect(result.isRight(), isTrue);
      verify(() => remote.fetchItem('master-ball')).called(1);
      verify(() => local.writeItem(any())).called(1);
    });

    test(
      'recovers from cache read failure by falling through to remote',
      () async {
        when(
          () => local.readItem('master-ball'),
        ).thenThrow(const CacheException(message: 'corrupt'));
        when(
          () => remote.fetchItem('master-ball'),
        ).thenAnswer((_) async => _detailModel());
        when(() => local.writeItem(any())).thenAnswer((_) async {});

        final result = await repo.getItem('master-ball');

        expect(result.isRight(), isTrue);
        verify(() => remote.fetchItem('master-ball')).called(1);
      },
    );

    test('ignores cache write failure and still returns entity', () async {
      when(() => local.readItem('master-ball')).thenAnswer((_) async => null);
      when(
        () => remote.fetchItem('master-ball'),
      ).thenAnswer((_) async => _detailModel());
      when(
        () => local.writeItem(any()),
      ).thenThrow(const CacheException(message: 'disk full'));

      final result = await repo.getItem('master-ball');

      expect(result.isRight(), isTrue);
      expect(((result as Right).value as ItemDetail).name, 'master-ball');
    });

    test('maps remote AppException to Failure on cache miss', () async {
      when(() => local.readItem('master-ball')).thenAnswer((_) async => null);
      when(
        () => remote.fetchItem('master-ball'),
      ).thenThrow(const ServerException(message: '500', statusCode: 500));

      final result = await repo.getItem('master-ball');

      expect((result as Left).value, isA<ServerFailure>());
    });

    test('maps ParsingException to UnexpectedFailure', () async {
      when(() => local.readItem('master-ball')).thenAnswer((_) async => null);
      when(
        () => remote.fetchItem('master-ball'),
      ).thenThrow(const ParsingException(message: 'bad json'));

      final result = await repo.getItem('master-ball');

      expect((result as Left).value, isA<UnexpectedFailure>());
    });

    test('maps unexpected error to UnexpectedFailure', () async {
      when(() => local.readItem('master-ball')).thenAnswer((_) async => null);
      when(() => remote.fetchItem('master-ball')).thenThrow(Exception('boom'));

      final result = await repo.getItem('master-ball');

      expect((result as Left).value, isA<UnexpectedFailure>());
    });
  });
}
