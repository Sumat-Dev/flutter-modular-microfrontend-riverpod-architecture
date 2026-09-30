import 'package:feature_pokemon/src/presentation/providers/characteristic_detail_provider.dart';
import 'package:feature_pokemon/src/presentation/utils/failure_message.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:ui_components/ui_components.dart';

class CharacteristicDetailPage extends ConsumerWidget {
  const CharacteristicDetailPage({required this.id, super.key});

  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detail = ref.watch(characteristicDetailProvider(id));
    return Scaffold(
      appBar: AppBar(title: Text('#$id')),
      body: AppAsyncView(
        isLoading: detail.isLoading,
        hasError: detail.hasError,
        data: detail.value,
        errorMessage: detail.hasError ? failureToMessage(detail.error!) : null,
        onRetry: () => ref.invalidate(characteristicDetailProvider(id)),
        dataBuilder: (context, characteristic) {
          final values = characteristic.possibleValues.join(', ');
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (characteristic.description != null) ...[
                  Text(characteristic.description!),
                  const SizedBox(height: 12),
                ],
                Text(
                  'Highest stat: '
                  '${characteristic.highestStat.name}',
                ),
                Text('Gene modulo: ${characteristic.geneModulo}'),
                Text('Possible values: $values'),
              ],
            ),
          );
        },
      ),
    );
  }
}
