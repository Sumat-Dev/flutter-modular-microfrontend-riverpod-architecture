import 'package:feature_items/src/presentation/pages/item_detail_page.dart';
import 'package:feature_items/src/presentation/pages/item_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

export 'src/domain/entities/item.dart';
export 'src/domain/entities/item_detail.dart';
export 'src/presentation/pages/item_detail_page.dart';
export 'src/presentation/pages/item_page.dart';

class ItemsModule extends Module {
  @override
  void routes(RouteManager r) {
    // /items
    r.child('/', child: (_) => const ItemPage());

    // /items/:name
    r.child(
      '/:name',
      child: (context) {
        final name = r.args.params['name'] as String;
        return ItemDetailPage(name: name);
      },
    );
  }
}
