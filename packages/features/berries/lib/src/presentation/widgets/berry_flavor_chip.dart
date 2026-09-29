import 'package:feature_berries/src/domain/entities/berry_detail.dart';
import 'package:material_ui/material_ui.dart';

class BerryFlavorChip extends StatelessWidget {
  const BerryFlavorChip({required this.flavor, super.key});

  final BerryFlavor flavor;

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text('${flavor.flavor} · ${flavor.potency}'),
      visualDensity: VisualDensity.compact,
    );
  }
}
