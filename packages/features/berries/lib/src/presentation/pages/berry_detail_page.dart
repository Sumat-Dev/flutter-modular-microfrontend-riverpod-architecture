import 'package:feature_berries/src/presentation/providers/berry_detail_provider.dart';
import 'package:feature_berries/src/presentation/utils/failure_message.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:ui_components/ui_components.dart';

class BerryDetailPage extends ConsumerWidget {
  const BerryDetailPage({required this.name, super.key});

  final String name;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detail = ref.watch(berryDetailProvider(name));
    return Scaffold(
      appBar: AppBar(title: Text(name)),
      body: AppAsyncView(
        isLoading: detail.isLoading,
        hasError: detail.hasError,
        data: detail.value,
        errorMessage: detail.hasError ? failureToMessage(detail.error!) : null,
        onRetry: () => ref.invalidate(berryDetailProvider(name)),
        dataBuilder: (context, berry) => SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '#${berry.id}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              AppChipWrap(
                labels: [
                  'firmness: ${berry.firmness}',
                  'type: ${berry.naturalGiftType}',
                ],
              ),
              const SizedBox(height: 16),
              Text('Growth time: ${berry.growthTime}'),
              Text('Max harvest: ${berry.maxHarvest}'),
              Text('Natural gift power: ${berry.naturalGiftPower}'),
              Text('Size: ${berry.size}'),
              Text('Smoothness: ${berry.smoothness}'),
              Text('Soil dryness: ${berry.soilDryness}'),
              const AppSectionHeader(title: 'Flavors'),
              AppChipWrap(
                runSpacing: 8,
                labels: [
                  for (final flavor in berry.flavors)
                    '${flavor.flavor} · ${flavor.potency}',
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
