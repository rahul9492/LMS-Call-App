import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constants/app_constants.dart';
import '../../../data/database/app_database.dart';
import '../../../data/models/call_log_model.dart';
import '../../../data/repositories/call_log_repository.dart';
import '../../../data/services/call_log_service.dart';
import '../../../data/services/connectivity_service.dart';
import '../../../data/services/api_service.dart';

part 'call_log_providers.g.dart';

// ── Infrastructure providers ──────────────────────────────────────────────

@Riverpod(keepAlive: true)
AppDatabase appDatabase(Ref ref) => AppDatabase();

@Riverpod(keepAlive: true)
CallLogService callLogService(Ref ref) => CallLogService();

@Riverpod(keepAlive: true)
ApiService apiService(Ref ref) => ApiService();

@Riverpod(keepAlive: true)
ConnectivityService connectivityService(Ref ref) => ConnectivityService();

@Riverpod(keepAlive: true)
CallLogRepository callLogRepository(Ref ref) {
  final db = ref.watch(appDatabaseProvider);
  final svc = ref.watch(callLogServiceProvider);
  return CallLogRepository(db, svc);
}

// ── Connectivity state ────────────────────────────────────────────────────

@riverpod
Stream<bool> connectivityStream(Ref ref) {
  final svc = ref.watch(connectivityServiceProvider);
  return svc.onConnectivityChanged;
}

@riverpod
Future<bool> isOnline(Ref ref) async {
  final svc = ref.watch(connectivityServiceProvider);
  return svc.isConnected;
}

// ── Call log streams ──────────────────────────────────────────────────────

@riverpod
Stream<List<CallLogGroup>> groupedCallLogs(Ref ref) {
  final repo = ref.watch(callLogRepositoryProvider);
  return repo.watchGroupedCallLogs();
}

@riverpod
Stream<List<CallLogModel>> allCallLogs(Ref ref) {
  final repo = ref.watch(callLogRepositoryProvider);
  return repo.watchCallLogs();
}

// ── Filter state ──────────────────────────────────────────────────────────

enum CallFilter { all, incoming, outgoing, missed }

@riverpod
class ActiveCallFilter extends _$ActiveCallFilter {
  @override
  CallFilter build() => CallFilter.all;

  void setFilter(CallFilter filter) => state = filter;
}

@riverpod
Stream<List<CallLogGroup>> filteredCallLogs(Ref ref) {
  final groups = ref.watch(groupedCallLogsProvider);
  final filter = ref.watch(activeCallFilterProvider);

  return groups.when(
    data: (groupList) {
      if (filter == CallFilter.all) {
        return Stream.value(groupList);
      }
      final targetType = _filterToType(filter);
      final filtered = groupList
          .map((g) {
            final filteredCalls =
                g.calls.where((c) => c.callType == targetType).toList();
            if (filteredCalls.isEmpty) return null;
            return g.copyWith(
              calls: filteredCalls,
              lastCallTime: filteredCalls.first.timestamp,
              lastCallType: filteredCalls.first.callType,
            );
          })
          .whereType<CallLogGroup>()
          .toList();
      return Stream.value(filtered);
    },
    loading: () => const Stream.empty(),
    error: (e, _) => Stream.error(e),
  );
}

CallTypeEnum _filterToType(CallFilter f) {
  switch (f) {
    case CallFilter.incoming:
      return CallTypeEnum.incoming;
    case CallFilter.outgoing:
      return CallTypeEnum.outgoing;
    case CallFilter.missed:
      return CallTypeEnum.missed;
    case CallFilter.all:
      return CallTypeEnum.unknown;
  }
}

// ── Call log fetch days ───────────────────────────────────────────────────

@riverpod
class CallLogFetchDays extends _$CallLogFetchDays {
  @override
  Future<int> build() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(AppConstants.prefCallLogFetchDays) ??
        AppConstants.callLogFetchDays;
  }

  Future<void> setDays(int days) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(AppConstants.prefCallLogFetchDays, days);
    state = AsyncValue.data(days);
  }
}

// ── Sync summary ──────────────────────────────────────────────────────────

@riverpod
Future<SyncSummary> syncSummary(Ref ref) async {
  final repo = ref.watch(callLogRepositoryProvider);
  final prefs = await SharedPreferences.getInstance();
  final lastSyncMs = prefs.getInt('last_sync_time');

  final summary = await repo.getSyncSummary();
  return summary.copyWith(
    lastSyncTime: lastSyncMs != null
        ? DateTime.fromMillisecondsSinceEpoch(lastSyncMs)
        : null,
  );
}

// ── Device sync action ────────────────────────────────────────────────────

@riverpod
class DeviceSyncNotifier extends _$DeviceSyncNotifier {
  @override
  AsyncValue<int> build() => const AsyncValue.data(0);

  Future<void> syncFromDevice() async {
    state = const AsyncValue.loading();
    try {
      final repo = ref.read(callLogRepositoryProvider);
      final count = await repo.syncFromDevice();
      state = AsyncValue.data(count);
      ref.invalidate(groupedCallLogsProvider);
      ref.invalidate(syncSummaryProvider);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
