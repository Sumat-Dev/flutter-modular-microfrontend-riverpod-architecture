import 'package:feature_items/src/domain/entities/item.dart';
import 'package:material_ui/material_ui.dart';
import 'package:ui_components/ui_components.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({required this.item, required this.onTap, super.key});

  final Item item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AppEntityCard(
      leading: AppNetworkThumbnail(
        imageUrl: item.imageUrl,
        fallbackIcon: Icons.inventory_2,
        size: 40,
      ),
      title: item.name,
      subtitle: '#${item.id}',
      onTap: onTap,
    );
  }
}
