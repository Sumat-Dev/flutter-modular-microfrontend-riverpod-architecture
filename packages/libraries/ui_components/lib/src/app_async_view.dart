import 'package:material_ui/material_ui.dart';
import 'package:ui_components/src/app_error_view.dart';
import 'package:ui_components/src/app_loading_view.dart';

/// Renders the three states of an asynchronous value (loading / error / data)
/// with the shared loading and error views, removing the
/// `when(loading:, error:, data:)` boilerplate duplicated across feature pages.
///
/// This widget is intentionally decoupled from Riverpod: callers pass the
/// already-resolved data, error and [isLoading] flags (typically derived
/// from an `AsyncValue`). This keeps `ui_components` free of feature/state
/// dependencies.
class AppAsyncView<T> extends StatelessWidget {
  const AppAsyncView({
    required this.isLoading,
    required this.hasError,
    required this.data,
    required this.dataBuilder,
    super.key,
    this.errorMessage,
    this.onRetry,
    this.loadingMessage,
  });

  /// Whether the async operation is currently loading.
  final bool isLoading;

  /// Whether the async operation completed with an error.
  final bool hasError;

  /// The resolved data. Only read when [isLoading] and [hasError] are false.
  final T? data;

  /// Builds the success UI from the resolved [data].
  final Widget Function(BuildContext context, T data) dataBuilder;

  /// Human-readable error message shown when [hasError] is true.
  final String? errorMessage;

  /// Optional retry callback surfaced by the error view.
  final VoidCallback? onRetry;

  /// Optional message shown alongside the loading indicator.
  final String? loadingMessage;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return AppLoadingView(message: loadingMessage);
    }
    if (hasError) {
      return AppErrorView(
        message: errorMessage ?? 'Something went wrong.',
        onRetry: onRetry,
      );
    }
    final value = data;
    if (value == null) {
      return const AppLoadingView();
    }
    return dataBuilder(context, value);
  }
}
