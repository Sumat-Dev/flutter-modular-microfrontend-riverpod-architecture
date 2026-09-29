import 'package:feature_berries/src/domain/entities/berry_detail.dart';
import 'package:feature_berries/src/presentation/providers/berry_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'berry_detail_provider.g.dart';

@Riverpod(keepAlive: true)
Future<BerryDetail> berryDetail(Ref ref, String name) async {
  final useCase = ref.watch(getBerryProvider);
  final result = await useCase(name);
  // Deliberately rethrow the domain Failure so Riverpod surfaces it via
  // AsyncValue.error.
  // ignore: only_throw_errors
  return result.fold((f) => throw f, (detail) => detail);
}
