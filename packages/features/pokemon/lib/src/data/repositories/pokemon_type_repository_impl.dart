import 'package:core/core.dart';
import 'package:feature_pokemon/src/data/datasources/resource_list_remote_data_source.dart';
import 'package:feature_pokemon/src/data/models/pokemon_type_model.dart';
import 'package:feature_pokemon/src/domain/entities/pokemon_type.dart';
import 'package:feature_pokemon/src/domain/repositories/pokemon_type_repository.dart';

class PokemonTypeRepositoryImpl implements PokemonTypeRepository {
  const PokemonTypeRepositoryImpl(this._remote);

  final ResourceListRemoteDataSource _remote;

  @override
  ResultFuture<PokemonType> getPokemonType(String idOrName) async {
    try {
      final json = await _remote.fetchDetail(
        path: 'type',
        idOrName: idOrName,
      );
      try {
        return Right(PokemonTypeModel.fromJson(json).toEntity());
      } on Object catch (e) {
        return Left(
          UnexpectedFailure(message: 'Parse pokemon type failed: $e'),
        );
      }
    } on AppException catch (e) {
      return Left(Failure.fromException(e));
    } on Object catch (e) {
      return Left(UnexpectedFailure(message: '$e'));
    }
  }
}
