import 'package:core/core.dart';
import 'package:feature_pokemon/src/data/datasources/resource_list_remote_data_source.dart';
import 'package:feature_pokemon/src/data/models/pokemon_shape_model.dart';
import 'package:feature_pokemon/src/domain/entities/pokemon_shape.dart';
import 'package:feature_pokemon/src/domain/repositories/pokemon_shape_repository.dart';

class PokemonShapeRepositoryImpl implements PokemonShapeRepository {
  const PokemonShapeRepositoryImpl(this._remote);

  final ResourceListRemoteDataSource _remote;

  @override
  ResultFuture<PokemonShape> getPokemonShape(String idOrName) async {
    try {
      final json = await _remote.fetchDetail(
        path: 'pokemon-shape',
        idOrName: idOrName,
      );
      try {
        return Right(PokemonShapeModel.fromJson(json).toEntity());
      } on Object catch (e) {
        return Left(
          UnexpectedFailure(message: 'Parse pokemon shape failed: $e'),
        );
      }
    } on AppException catch (e) {
      return Left(Failure.fromException(e));
    } on Object catch (e) {
      return Left(UnexpectedFailure(message: '$e'));
    }
  }
}
