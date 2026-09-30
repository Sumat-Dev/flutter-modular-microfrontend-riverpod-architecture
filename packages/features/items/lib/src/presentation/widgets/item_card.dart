import 'package:feature_items/src/domain/entities/item.dart';
import 'package:material_ui/material_ui.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({required this.item, required this.onTap, super.key});

  final Item item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: ListTile(
        leading: Image.network(
          item.imageUrl,
          width: 40,
          height: 40,
          errorBuilder: (_, _, _) => const Icon(Icons.inventory_2),
        ),
        title: Text(item.name),
        subtitle: Text('#${item.id}'),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
