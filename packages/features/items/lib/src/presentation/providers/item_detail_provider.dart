import 'package:feature_items/src/domain/entities/item_detail.dart';
import 'package:feature_items/src/presentation/providers/item_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'item_detail_provider.g.dart';

@Riverpod(keepAlive: true)
Future<ItemDetail> itemDetail(Ref ref, String name) async {
  final useCase = ref.watch(getItemProvider);
  final result = await useCase(name);
  // Deliberately rethrow the domain Failure so Riverpod surfaces it via
  // AsyncValue.error.
  // ignore: only_throw_errors
  return result.fold((f) => throw f, (detail) => detail);
}
