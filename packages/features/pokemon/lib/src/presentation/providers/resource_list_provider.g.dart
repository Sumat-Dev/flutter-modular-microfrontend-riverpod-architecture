// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resource_list_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Generic paginated list notifier, one instance per resource [path]
/// (e.g. 'ability', 'type', 'nature').

@ProviderFor(ResourceList)
const resourceListProvider = ResourceListFamily._();

/// Generic paginated list notifier, one instance per resource [path]
/// (e.g. 'ability', 'type', 'nature').
final class ResourceListProvider
    extends $AsyncNotifierProvider<ResourceList, ResourceListState> {
  /// Generic paginated list notifier, one instance per resource [path]
  /// (e.g. 'ability', 'type', 'nature').
  const ResourceListProvider._({
    required ResourceListFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'resourceListProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$resourceListHash();

  @override
  String toString() {
    return r'resourceListProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ResourceList create() => ResourceList();

  @override
  bool operator ==(Object other) {
    return other is ResourceListProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$resourceListHash() => r'23b8393d5dfbe7b548767da39e3fc4c9a3950932';

/// Generic paginated list notifier, one instance per resource [path]
/// (e.g. 'ability', 'type', 'nature').

final class ResourceListFamily extends $Family
    with
        $ClassFamilyOverride<
          ResourceList,
          AsyncValue<ResourceListState>,
          ResourceListState,
          FutureOr<ResourceListState>,
          String
        > {
  const ResourceListFamily._()
    : super(
        retry: null,
        name: r'resourceListProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Generic paginated list notifier, one instance per resource [path]
  /// (e.g. 'ability', 'type', 'nature').

  ResourceListProvider call(String path) =>
      ResourceListProvider._(argument: path, from: this);

  @override
  String toString() => r'resourceListProvider';
}

/// Generic paginated list notifier, one instance per resource [path]
/// (e.g. 'ability', 'type', 'nature').

abstract class _$ResourceList extends $AsyncNotifier<ResourceListState> {
  late final _$args = ref.$arg as String;
  String get path => _$args;

  FutureOr<ResourceListState> build(String path);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref =
        this.ref as $Ref<AsyncValue<ResourceListState>, ResourceListState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<ResourceListState>, ResourceListState>,
              AsyncValue<ResourceListState>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
