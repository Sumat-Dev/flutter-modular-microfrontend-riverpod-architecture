import 'package:core/core.dart';
import 'package:feature_pokemon/src/data/datasources/resource_list_remote_data_source.dart';
import 'package:feature_pokemon/src/data/models/characteristic_model.dart';
import 'package:feature_pokemon/src/domain/entities/characteristic.dart';
import 'package:feature_pokemon/src/domain/repositories/characteristic_repository.dart';

class CharacteristicRepositoryImpl implements CharacteristicRepository {
  const CharacteristicRepositoryImpl(this._remote);

  final ResourceListRemoteDataSource _remote;

  @override
  ResultFuture<Characteristic> getCharacteristic(int id) async {
    try {
      final json = await _remote.fetchDetail(
        path: 'characteristic',
        idOrName: '$id',
      );
      try {
        return Right(CharacteristicModel.fromJson(json).toEntity());
      } on Object catch (e) {
        return Left(
          UnexpectedFailure(message: 'Parse characteristic failed: $e'),
        );
      }
    } on AppException catch (e) {
      return Left(_mapException(e));
    } on Object catch (e) {
      return Left(UnexpectedFailure(message: '$e'));
    }
  }

  Failure _mapException(AppException e) => switch (e) {
    NetworkException() => NetworkFailure.fromException(e),
    ServerException() => ServerFailure.fromException(e),
    CacheException() => CacheFailure.fromException(e),
    ParsingException() => UnexpectedFailure(message: e.message),
  };
}
