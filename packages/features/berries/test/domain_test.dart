import 'package:core/core.dart';
import 'package:feature_berries/src/domain/entities/berry.dart';
import 'package:feature_berries/src/domain/entities/berry_detail.dart';
import 'package:feature_berries/src/domain/repositories/berry_repository.dart';
import 'package:feature_berries/src/domain/usecases/get_berry.dart';
import 'package:feature_berries/src/domain/usecases/get_berry_list.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockRepo extends Mock implements BerryRepository {}

class _FakePageRequest extends Fake implements PageRequest {}

BerryDetail _detail() => const BerryDetail(
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
  flavors: [BerryFlavor(flavor: 'spicy', potency: 10)],
);

void main() {
  setUpAll(() {
    registerFallbackValue(_FakePageRequest());
  });

  late _MockRepo repo;

  setUp(() {
    repo = _MockRepo();
  });

  group('GetBerryList use case', () {
    test('delegates to repository and returns its result', () async {
      const page = PaginatedResult<Berry>(
        count: 1,
        items: [Berry(id: 1, name: 'cheri')],
      );
      when(
        () => repo.getBerryList(any()),
      ).thenAnswer((_) async => const Right(page));

      final result = await GetBerryList(repo)(const PageRequest());

      expect(result.isRight(), isTrue);
      expect((result as Right).value, page);
      verify(() => repo.getBerryList(const PageRequest())).called(1);
    });

    test('propagates failure from repository', () async {
      when(
        () => repo.getBerryList(any()),
      ).thenAnswer((_) async => const Left(NetworkFailure(message: 'x')));

      final result = await GetBerryList(repo)(const PageRequest(offset: 20));

      expect(result.isLeft(), isTrue);
      expect((result as Left).value, isA<NetworkFailure>());
    });
  });

  group('GetBerry use case', () {
    test('delegates to repository and returns detail', () async {
      when(
        () => repo.getBerry(any()),
      ).thenAnswer((_) async => Right(_detail()));

      final result = await GetBerry(repo)('cheri');

      expect(result.isRight(), isTrue);
      expect(((result as Right).value as BerryDetail).name, 'cheri');
      verify(() => repo.getBerry('cheri')).called(1);
    });

    test('propagates failure from repository', () async {
      when(
        () => repo.getBerry(any()),
      ).thenAnswer((_) async => const Left(ServerFailure(message: 'x')));

      final result = await GetBerry(repo)('missing');

      expect(result.isLeft(), isTrue);
      expect((result as Left).value, isA<ServerFailure>());
    });
  });

  group('Berry entity', () {
    test('value equality via Equatable props', () {
      expect(
        const Berry(id: 1, name: 'cheri'),
        const Berry(id: 1, name: 'cheri'),
      );
      expect(
        const Berry(id: 1, name: 'cheri'),
        isNot(const Berry(id: 2, name: 'chesto')),
      );
    });
  });

  group('BerryDetail entity', () {
    test('summary maps to a Berry', () {
      expect(_detail().summary, const Berry(id: 1, name: 'cheri'));
    });

    test('value equality via Equatable props', () {
      expect(_detail(), _detail());
    });

    test('BerryFlavor value equality', () {
      expect(
        const BerryFlavor(flavor: 'spicy', potency: 10),
        const BerryFlavor(flavor: 'spicy', potency: 10),
      );
      expect(
        const BerryFlavor(flavor: 'spicy', potency: 10),
        isNot(const BerryFlavor(flavor: 'dry', potency: 5)),
      );
    });
  });
}
