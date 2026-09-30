import 'package:material_ui/material_ui.dart';

import 'package:ui_components/src/constants/app_constants.dart';

/// Generic error view with an optional retry callback. Feature-agnostic:
/// callers pass a human-readable [message].
class AppErrorView extends StatelessWidget {
  const AppErrorView({required this.message, super.key, this.onRetry});

  final String message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(kSpacing),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 48),
            const SizedBox(height: kSpacing / 2),
            Text(message, textAlign: TextAlign.center),
            if (onRetry != null) ...[
              const SizedBox(height: kSpacing),
              FilledButton.tonal(
                onPressed: onRetry,
                child: const Text('Retry'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
