import 'package:core/core.dart';
import 'package:feature_pokemon/src/data/datasources/resource_list_remote_data_source.dart';
import 'package:feature_pokemon/src/data/models/pokemon_color_model.dart';
import 'package:feature_pokemon/src/domain/entities/pokemon_color.dart';
import 'package:feature_pokemon/src/domain/repositories/pokemon_color_repository.dart';

class PokemonColorRepositoryImpl implements PokemonColorRepository {
  const PokemonColorRepositoryImpl(this._remote);

  final ResourceListRemoteDataSource _remote;

  @override
  ResultFuture<PokemonColor> getPokemonColor(String idOrName) async {
    try {
      final json = await _remote.fetchDetail(
        path: 'pokemon-color',
        idOrName: idOrName,
      );
      try {
        return Right(PokemonColorModel.fromJson(json).toEntity());
      } on Object catch (e) {
        return Left(
          UnexpectedFailure(message: 'Parse pokemon color failed: $e'),
        );
      }
    } on AppException catch (e) {
      return Left(Failure.fromException(e));
    } on Object catch (e) {
      return Left(UnexpectedFailure(message: '$e'));
    }
  }
}
