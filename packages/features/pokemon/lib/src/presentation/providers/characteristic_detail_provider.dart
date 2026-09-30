import 'package:feature_pokemon/src/domain/entities/characteristic.dart';
import 'package:feature_pokemon/src/presentation/providers/resource_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'characteristic_detail_provider.g.dart';

@Riverpod(keepAlive: true)
Future<Characteristic> characteristicDetail(Ref ref, int id) async {
  final useCase = ref.watch(getCharacteristicProvider);
  final result = await useCase(id);
  // Rethrow the domain Failure so Riverpod surfaces it via
  // AsyncValue.error.
  // ignore: only_throw_errors
  return result.fold((f) => throw f, (d) => d);
}
