import 'package:material_ui/material_ui.dart';

import 'package:ui_components/src/constants/app_constants.dart';

/// Centered progress indicator used for loading states across features.
class AppLoadingView extends StatelessWidget {
  const AppLoadingView({super.key, this.message});

  final String? message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator.adaptive(),
          if (message != null) ...[
            const SizedBox(height: kSpacing / 2),
            Text(message!, textAlign: TextAlign.center),
          ],
        ],
      ),
    );
  }
}
