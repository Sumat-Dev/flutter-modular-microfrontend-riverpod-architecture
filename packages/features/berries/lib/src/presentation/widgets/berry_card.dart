import 'package:feature_berries/src/domain/entities/berry.dart';
import 'package:material_ui/material_ui.dart';
import 'package:ui_components/ui_components.dart';

class BerryCard extends StatelessWidget {
  const BerryCard({required this.berry, required this.onTap, super.key});

  final Berry berry;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AppEntityCard(
      leading: const CircleAvatar(child: Icon(Icons.spa)),
      title: berry.name,
      subtitle: '#${berry.id}',
      onTap: onTap,
    );
  }
}
