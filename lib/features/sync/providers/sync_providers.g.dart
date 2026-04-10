// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sync_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(syncService)
const syncServiceProvider = SyncServiceProvider._();

final class SyncServiceProvider
    extends $FunctionalProvider<SyncService, SyncService, SyncService>
    with $Provider<SyncService> {
  const SyncServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'syncServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$syncServiceHash();

  @$internal
  @override
  $ProviderElement<SyncService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SyncService create(Ref ref) {
    return syncService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SyncService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SyncService>(value),
    );
  }
}

String _$syncServiceHash() => r'c7c9646ebc09d6db2aef3f9ec8ad77fcdcf6674e';

@ProviderFor(SyncNotifier)
const syncProvider = SyncNotifierProvider._();

final class SyncNotifierProvider
    extends $NotifierProvider<SyncNotifier, AsyncValue<SyncResult?>> {
  const SyncNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'syncProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$syncNotifierHash();

  @$internal
  @override
  SyncNotifier create() => SyncNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<SyncResult?> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<SyncResult?>>(value),
    );
  }
}

String _$syncNotifierHash() => r'8ac1991e24ea20b59c4f33996a75075210eb010f';

abstract class _$SyncNotifier extends $Notifier<AsyncValue<SyncResult?>> {
  AsyncValue<SyncResult?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<AsyncValue<SyncResult?>, AsyncValue<SyncResult?>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<SyncResult?>, AsyncValue<SyncResult?>>,
              AsyncValue<SyncResult?>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
