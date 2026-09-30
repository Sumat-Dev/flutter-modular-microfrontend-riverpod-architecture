import 'package:material_ui/material_ui.dart';

class ItemAttributeChip extends StatelessWidget {
  const ItemAttributeChip({required this.attribute, super.key});

  final String attribute;

  @override
  Widget build(BuildContext context) {
    return Chip(label: Text(attribute), visualDensity: VisualDensity.compact);
  }
}
