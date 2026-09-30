import 'package:core/core.dart';
import 'package:feature_pokemon/src/data/datasources/resource_list_remote_data_source.dart';
import 'package:feature_pokemon/src/data/models/pokemon_form_model.dart';
import 'package:feature_pokemon/src/domain/entities/pokemon_form.dart';
import 'package:feature_pokemon/src/domain/repositories/pokemon_form_repository.dart';

class PokemonFormRepositoryImpl implements PokemonFormRepository {
  const PokemonFormRepositoryImpl(this._remote);

  final ResourceListRemoteDataSource _remote;

  @override
  ResultFuture<PokemonForm> getPokemonForm(String idOrName) async {
    try {
      final json = await _remote.fetchDetail(
        path: 'pokemon-form',
        idOrName: idOrName,
      );
      try {
        return Right(PokemonFormModel.fromJson(json).toEntity());
      } on Object catch (e) {
        return Left(UnexpectedFailure(message: 'Parse form failed: $e'));
      }
    } on AppException catch (e) {
      return Left(Failure.fromException(e));
    } on Object catch (e) {
      return Left(UnexpectedFailure(message: '$e'));
    }
  }
}
