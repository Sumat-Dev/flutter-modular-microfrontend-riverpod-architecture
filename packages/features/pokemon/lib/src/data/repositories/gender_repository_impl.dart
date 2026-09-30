import 'package:core/core.dart';
import 'package:feature_pokemon/src/data/datasources/resource_list_remote_data_source.dart';
import 'package:feature_pokemon/src/data/models/gender_model.dart';
import 'package:feature_pokemon/src/domain/entities/gender.dart';
import 'package:feature_pokemon/src/domain/repositories/gender_repository.dart';

class GenderRepositoryImpl implements GenderRepository {
  const GenderRepositoryImpl(this._remote);

  final ResourceListRemoteDataSource _remote;

  @override
  ResultFuture<Gender> getGender(String idOrName) async {
    try {
      final json = await _remote.fetchDetail(
        path: 'gender',
        idOrName: idOrName,
      );
      try {
        return Right(GenderModel.fromJson(json).toEntity());
      } on Object catch (e) {
        return Left(UnexpectedFailure(message: 'Parse gender failed: $e'));
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
