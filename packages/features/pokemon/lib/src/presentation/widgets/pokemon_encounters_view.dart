import 'package:feature_pokemon/src/presentation/providers/encounters_provider.dart';
import 'package:feature_pokemon/src/presentation/utils/failure_message.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:ui_components/ui_components.dart';

class PokemonEncountersView extends ConsumerWidget {
  const PokemonEncountersView({required this.name, super.key});

  final String name;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final encountersValue = ref.watch(encountersProvider(name));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Location encounters', style: theme.textTheme.titleMedium),
        const SizedBox(height: 8),
        AppAsyncView(
          isLoading: encountersValue.isLoading,
          hasError: encountersValue.hasError,
          data: encountersValue.value,
          errorMessage: encountersValue.hasError
              ? failureToMessage(encountersValue.error!)
              : null,
          dataBuilder: (context, encounters) {
            if (encounters.isEmpty) {
              return const Text('No known encounters.');
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (final encounter in encounters)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        encounter.locationArea.name,
                        style: theme.textTheme.bodyLarge,
                      ),
                      for (final v in encounter.versionDetails)
                        Text(
                          '${v.version.name}: ${v.maxChance}%',
                          style: theme.textTheme.bodySmall,
                        ),
                      const SizedBox(height: 8),
                    ],
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}
