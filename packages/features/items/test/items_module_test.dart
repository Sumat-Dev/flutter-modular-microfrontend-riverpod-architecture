import 'package:feature_items/items_module.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('ItemsModule exposes the list and detail routes', () {
    final manager = RouteManager();
    ItemsModule().routes(manager);

    final names = manager.allRoutes.map((r) => r.name).toList();
    expect(names, contains('/'));
    expect(names, contains('/:name'));
  });
}
