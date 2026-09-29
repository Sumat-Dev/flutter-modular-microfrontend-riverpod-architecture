import 'package:feature_berries/src/domain/entities/berry.dart';
import 'package:material_ui/material_ui.dart';

class BerryCard extends StatelessWidget {
  const BerryCard({required this.berry, required this.onTap, super.key});

  final Berry berry;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: ListTile(
        leading: const CircleAvatar(child: Icon(Icons.spa)),
        title: Text(berry.name),
        subtitle: Text('#${berry.id}'),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
