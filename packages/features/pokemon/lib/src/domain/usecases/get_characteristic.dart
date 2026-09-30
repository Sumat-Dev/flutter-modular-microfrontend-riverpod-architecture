import 'package:core/core.dart';

import 'package:feature_pokemon/src/domain/entities/characteristic.dart';
import 'package:feature_pokemon/src/domain/repositories/characteristic_repository.dart';

class GetCharacteristic implements UseCaseWithParams<Characteristic, int> {
  const GetCharacteristic(this._repository);

  final CharacteristicRepository _repository;

  @override
  ResultFuture<Characteristic> call(int params) =>
      _repository.getCharacteristic(params);
}
