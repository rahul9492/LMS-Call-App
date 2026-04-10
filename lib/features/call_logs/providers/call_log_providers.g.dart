// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'call_log_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(appDatabase)
const appDatabaseProvider = AppDatabaseProvider._();

final class AppDatabaseProvider
    extends $FunctionalProvider<AppDatabase, AppDatabase, AppDatabase>
    with $Provider<AppDatabase> {
  const AppDatabaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appDatabaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appDatabaseHash();

  @$internal
  @override
  $ProviderElement<AppDatabase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AppDatabase create(Ref ref) {
    return appDatabase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppDatabase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppDatabase>(value),
    );
  }
}

String _$appDatabaseHash() => r'98a09c6cfd43966155dfbdb0787fa18c85438e13';

@ProviderFor(callLogService)
const callLogServiceProvider = CallLogServiceProvider._();

final class CallLogServiceProvider
    extends $FunctionalProvider<CallLogService, CallLogService, CallLogService>
    with $Provider<CallLogService> {
  const CallLogServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'callLogServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$callLogServiceHash();

  @$internal
  @override
  $ProviderElement<CallLogService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  CallLogService create(Ref ref) {
    return callLogService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CallLogService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CallLogService>(value),
    );
  }
}

String _$callLogServiceHash() => r'fdad2536fe299de3ebae30c9e708f47a715513c8';

@ProviderFor(apiService)
const apiServiceProvider = ApiServiceProvider._();

final class ApiServiceProvider
    extends $FunctionalProvider<ApiService, ApiService, ApiService>
    with $Provider<ApiService> {
  const ApiServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'apiServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$apiServiceHash();

  @$internal
  @override
  $ProviderElement<ApiService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ApiService create(Ref ref) {
    return apiService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ApiService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ApiService>(value),
    );
  }
}

String _$apiServiceHash() => r'93a7e3b4d3004741abc3061c4688239c3a72f9c4';

@ProviderFor(connectivityService)
const connectivityServiceProvider = ConnectivityServiceProvider._();

final class ConnectivityServiceProvider
    extends
        $FunctionalProvider<
          ConnectivityService,
          ConnectivityService,
          ConnectivityService
        >
    with $Provider<ConnectivityService> {
  const ConnectivityServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'connectivityServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$connectivityServiceHash();

  @$internal
  @override
  $ProviderElement<ConnectivityService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ConnectivityService create(Ref ref) {
    return connectivityService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ConnectivityService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ConnectivityService>(value),
    );
  }
}

String _$connectivityServiceHash() =>
    r'a41855a7e07cfa28457d4a8747cbc16077f207b4';

@ProviderFor(callLogRepository)
const callLogRepositoryProvider = CallLogRepositoryProvider._();

final class CallLogRepositoryProvider
    extends
        $FunctionalProvider<
          CallLogRepository,
          CallLogRepository,
          CallLogRepository
        >
    with $Provider<CallLogRepository> {
  const CallLogRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'callLogRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$callLogRepositoryHash();

  @$internal
  @override
  $ProviderElement<CallLogRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CallLogRepository create(Ref ref) {
    return callLogRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CallLogRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CallLogRepository>(value),
    );
  }
}

String _$callLogRepositoryHash() => r'467ebeffd5dd4cbe97f02954b09204a198568821';

@ProviderFor(connectivityStream)
const connectivityStreamProvider = ConnectivityStreamProvider._();

final class ConnectivityStreamProvider
    extends $FunctionalProvider<AsyncValue<bool>, bool, Stream<bool>>
    with $FutureModifier<bool>, $StreamProvider<bool> {
  const ConnectivityStreamProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'connectivityStreamProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$connectivityStreamHash();

  @$internal
  @override
  $StreamProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<bool> create(Ref ref) {
    return connectivityStream(ref);
  }
}

String _$connectivityStreamHash() =>
    r'40c6cb1b6b7e9c79b55451ec9251143071bcd17a';

@ProviderFor(isOnline)
const isOnlineProvider = IsOnlineProvider._();

final class IsOnlineProvider
    extends $FunctionalProvider<AsyncValue<bool>, bool, FutureOr<bool>>
    with $FutureModifier<bool>, $FutureProvider<bool> {
  const IsOnlineProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'isOnlineProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$isOnlineHash();

  @$internal
  @override
  $FutureProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<bool> create(Ref ref) {
    return isOnline(ref);
  }
}

String _$isOnlineHash() => r'bce828c033deaa04220f4261ef5b82cf4ee5d0fe';

@ProviderFor(groupedCallLogs)
const groupedCallLogsProvider = GroupedCallLogsProvider._();

final class GroupedCallLogsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<CallLogGroup>>,
          List<CallLogGroup>,
          Stream<List<CallLogGroup>>
        >
    with
        $FutureModifier<List<CallLogGroup>>,
        $StreamProvider<List<CallLogGroup>> {
  const GroupedCallLogsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'groupedCallLogsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$groupedCallLogsHash();

  @$internal
  @override
  $StreamProviderElement<List<CallLogGroup>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<CallLogGroup>> create(Ref ref) {
    return groupedCallLogs(ref);
  }
}

String _$groupedCallLogsHash() => r'dc0640f9644e67dc9dbceaf51448ca1e789c7ad5';

@ProviderFor(allCallLogs)
const allCallLogsProvider = AllCallLogsProvider._();

final class AllCallLogsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<CallLogModel>>,
          List<CallLogModel>,
          Stream<List<CallLogModel>>
        >
    with
        $FutureModifier<List<CallLogModel>>,
        $StreamProvider<List<CallLogModel>> {
  const AllCallLogsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'allCallLogsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$allCallLogsHash();

  @$internal
  @override
  $StreamProviderElement<List<CallLogModel>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<CallLogModel>> create(Ref ref) {
    return allCallLogs(ref);
  }
}

String _$allCallLogsHash() => r'120cd15b55ffdb6c814e2eccc8d4f4556182a495';

@ProviderFor(ActiveCallFilter)
const activeCallFilterProvider = ActiveCallFilterProvider._();

final class ActiveCallFilterProvider
    extends $NotifierProvider<ActiveCallFilter, CallFilter> {
  const ActiveCallFilterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'activeCallFilterProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$activeCallFilterHash();

  @$internal
  @override
  ActiveCallFilter create() => ActiveCallFilter();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CallFilter value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CallFilter>(value),
    );
  }
}

String _$activeCallFilterHash() => r'00ed18c387686958821a42f9e4628ebd90a41c1b';

abstract class _$ActiveCallFilter extends $Notifier<CallFilter> {
  CallFilter build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<CallFilter, CallFilter>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<CallFilter, CallFilter>,
              CallFilter,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(filteredCallLogs)
const filteredCallLogsProvider = FilteredCallLogsProvider._();

final class FilteredCallLogsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<CallLogGroup>>,
          List<CallLogGroup>,
          Stream<List<CallLogGroup>>
        >
    with
        $FutureModifier<List<CallLogGroup>>,
        $StreamProvider<List<CallLogGroup>> {
  const FilteredCallLogsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'filteredCallLogsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$filteredCallLogsHash();

  @$internal
  @override
  $StreamProviderElement<List<CallLogGroup>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<CallLogGroup>> create(Ref ref) {
    return filteredCallLogs(ref);
  }
}

String _$filteredCallLogsHash() => r'e65eea58c967031ab94b0b8df0c8ba9d9632c316';

@ProviderFor(syncSummary)
const syncSummaryProvider = SyncSummaryProvider._();

final class SyncSummaryProvider
    extends
        $FunctionalProvider<
          AsyncValue<SyncSummary>,
          SyncSummary,
          FutureOr<SyncSummary>
        >
    with $FutureModifier<SyncSummary>, $FutureProvider<SyncSummary> {
  const SyncSummaryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'syncSummaryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$syncSummaryHash();

  @$internal
  @override
  $FutureProviderElement<SyncSummary> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<SyncSummary> create(Ref ref) {
    return syncSummary(ref);
  }
}

String _$syncSummaryHash() => r'e851e23edf29f166c1c5fbcb34c55f604757538e';

@ProviderFor(DeviceSyncNotifier)
const deviceSyncProvider = DeviceSyncNotifierProvider._();

final class DeviceSyncNotifierProvider
    extends $NotifierProvider<DeviceSyncNotifier, AsyncValue<int>> {
  const DeviceSyncNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deviceSyncProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deviceSyncNotifierHash();

  @$internal
  @override
  DeviceSyncNotifier create() => DeviceSyncNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<int> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<int>>(value),
    );
  }
}

String _$deviceSyncNotifierHash() =>
    r'c0a110cf59aef9f6a35c3b2d85d1819b8c744dee';

abstract class _$DeviceSyncNotifier extends $Notifier<AsyncValue<int>> {
  AsyncValue<int> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<int>, AsyncValue<int>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<int>, AsyncValue<int>>,
              AsyncValue<int>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
