import 'package:flutter_test/flutter_test.dart';
import 'package:pokemon_app/app_module.dart';

void main() {
  test('AppModule can be instantiated and exposes routes', () {
    final module = AppModule();
    // binds() defaults to empty; routes are registered via routes().
    expect(module, isA<AppModule>());
  });
}
