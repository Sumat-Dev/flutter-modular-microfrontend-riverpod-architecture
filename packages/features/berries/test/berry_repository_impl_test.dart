import 'package:core/core.dart';
import 'package:feature_berries/src/data/datasources/berry_local_data_source.dart';
import 'package:feature_berries/src/data/datasources/berry_remote_data_source.dart';
import 'package:feature_berries/src/data/models/berry_detail_model.dart';
import 'package:feature_berries/src/data/models/berry_model.dart';
import 'package:feature_berries/src/data/repositories/berry_repository_impl.dart';
import 'package:feature_berries/src/domain/entities/berry.dart';
import 'package:feature_berries/src/domain/entities/berry_detail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockRemote extends Mock implements BerryRemoteDataSource {}

class _MockLocal extends Mock implements BerryLocalDataSource {}

class _FakeDetailModel extends Fake implements BerryDetailModel {}

BerryDetailModel _detailModel() => const BerryDetailModel(
  id: 1,
  name: 'cheri',
  growthTime: 3,
  maxHarvest: 5,
  naturalGiftPower: 60,
  size: 20,
  smoothness: 25,
  soilDryness: 15,
  firmness: 'soft',
  naturalGiftType: 'fire',
  flavors: [BerryFlavorModel(flavor: 'spicy', potency: 10)],
);

void main() {
  setUpAll(() {
    registerFallbackValue(_FakeDetailModel());
  });

  late _MockRemote remote;
  late _MockLocal local;
  late BerryRepositoryImpl repo;

  setUp(() {
    remote = _MockRemote();
    local = _MockLocal();
    repo = BerryRepositoryImpl(remote: remote, local: local);
  });

  group('getBerryList', () {
    test('maps remote result into paginated entities', () async {
      when(
        () => remote.fetchBerryList(offset: 0, limit: 20),
      ).thenAnswer(
        (_) async => (
          count: 1,
          next: 'next-url',
          previous: null,
          items: [const BerryModel(id: 1, name: 'cheri')],
        ),
      );

      final result = await repo.getBerryList(const PageRequest());

      expect(result.isRight(), isTrue);
      final page = (result as Right).value as PaginatedResult<Berry>;
      expect(page.count, 1);
      expect(page.items.single, const Berry(id: 1, name: 'cheri'));
    });

    test('maps AppException to Failure', () async {
      when(
        () => remote.fetchBerryList(offset: 0, limit: 20),
      ).thenThrow(const NetworkException(message: 'offline'));

      final result = await repo.getBerryList(const PageRequest());

      expect(result.isLeft(), isTrue);
      expect((result as Left).value, isA<NetworkFailure>());
    });

    test('maps unexpected error to UnexpectedFailure', () async {
      when(
        () => remote.fetchBerryList(offset: 0, limit: 20),
      ).thenThrow(Exception('boom'));

      final result = await repo.getBerryList(const PageRequest());

      expect(result.isLeft(), isTrue);
      expect((result as Left).value, isA<UnexpectedFailure>());
    });
  });

  group('getBerry (cache strategy §11)', () {
    test('returns cached entity on cache hit without hitting remote', () async {
      when(
        () => local.readBerry('cheri'),
      ).thenAnswer((_) async => _detailModel());

      final result = await repo.getBerry('cheri');

      expect(result.isRight(), isTrue);
      expect(((result as Right).value as BerryDetail).name, 'cheri');
      verifyNever(() => remote.fetchBerry(any()));
    });

    test('falls back to remote on cache miss and saves to cache', () async {
      when(() => local.readBerry('cheri')).thenAnswer((_) async => null);
      when(
        () => remote.fetchBerry('cheri'),
      ).thenAnswer((_) async => _detailModel());
      when(() => local.writeBerry(any())).thenAnswer((_) async {});

      final result = await repo.getBerry('cheri');

      expect(result.isRight(), isTrue);
      expect(((result as Right).value as BerryDetail).name, 'cheri');
      verify(() => remote.fetchBerry('cheri')).called(1);
      verify(() => local.writeBerry(any())).called(1);
    });

    test(
      'recovers from cache read failure by falling through to remote',
      () async {
        when(
          () => local.readBerry('cheri'),
        ).thenThrow(const CacheException(message: 'corrupt'));
        when(
          () => remote.fetchBerry('cheri'),
        ).thenAnswer((_) async => _detailModel());
        when(() => local.writeBerry(any())).thenAnswer((_) async {});

        final result = await repo.getBerry('cheri');

        expect(result.isRight(), isTrue);
        verify(() => remote.fetchBerry('cheri')).called(1);
      },
    );

    test('ignores cache write failure and still returns entity', () async {
      when(() => local.readBerry('cheri')).thenAnswer((_) async => null);
      when(
        () => remote.fetchBerry('cheri'),
      ).thenAnswer((_) async => _detailModel());
      when(
        () => local.writeBerry(any()),
      ).thenThrow(const CacheException(message: 'disk full'));

      final result = await repo.getBerry('cheri');

      expect(result.isRight(), isTrue);
      expect(((result as Right).value as BerryDetail).name, 'cheri');
    });

    test('maps remote AppException to Failure on cache miss', () async {
      when(() => local.readBerry('cheri')).thenAnswer((_) async => null);
      when(
        () => remote.fetchBerry('cheri'),
      ).thenThrow(const ServerException(message: '500', statusCode: 500));

      final result = await repo.getBerry('cheri');

      expect(result.isLeft(), isTrue);
      expect((result as Left).value, isA<ServerFailure>());
    });

    test('maps ParsingException to UnexpectedFailure', () async {
      when(() => local.readBerry('cheri')).thenAnswer((_) async => null);
      when(
        () => remote.fetchBerry('cheri'),
      ).thenThrow(const ParsingException(message: 'bad json'));

      final result = await repo.getBerry('cheri');

      expect(result.isLeft(), isTrue);
      expect((result as Left).value, isA<UnexpectedFailure>());
    });

    test('maps unexpected error to UnexpectedFailure', () async {
      when(() => local.readBerry('cheri')).thenAnswer((_) async => null);
      when(() => remote.fetchBerry('cheri')).thenThrow(Exception('boom'));

      final result = await repo.getBerry('cheri');

      expect(result.isLeft(), isTrue);
      expect((result as Left).value, isA<UnexpectedFailure>());
    });
  });
}
