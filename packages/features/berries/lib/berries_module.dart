import 'package:feature_berries/src/presentation/pages/berry_detail_page.dart';
import 'package:feature_berries/src/presentation/pages/berry_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

export 'src/domain/entities/berry.dart';
export 'src/domain/entities/berry_detail.dart';
export 'src/presentation/pages/berry_detail_page.dart';
export 'src/presentation/pages/berry_page.dart';

class BerriesModule extends Module {
  @override
  void routes(RouteManager r) {
    // /berries
    r.child('/', child: (_) => const BerryPage());

    // /berries/:name
    r.child(
      '/:name',
      child: (context) {
        final name = r.args.params['name'] as String;
        return BerryDetailPage(name: name);
      },
    );
  }
}
