import 'package:flutter/foundation.dart';
import 'package:workmanager/workmanager.dart';

import '../../../core/constants/app_constants.dart';
import '../../../data/database/app_database.dart';
import '../../../data/repositories/call_log_repository.dart';
import '../../../data/services/api_service.dart';
import '../../../data/services/call_log_service.dart';
import '../../../data/services/connectivity_service.dart';
import '../services/sync_service.dart';

/// Called by WorkManager in the background (separate isolate).
/// Must be a top-level function.
@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((taskName, inputData) async {
    debugPrint('[BackgroundSync] Task started: $taskName');
    try {
      final db = AppDatabase();
      final callLogSvc = CallLogService();
      final apiSvc = ApiService();
      final connectivitySvc = ConnectivityService();
      final repo = CallLogRepository(db, callLogSvc);
      final syncSvc = SyncService(repo, apiSvc, connectivitySvc);

      final result = await syncSvc.runSync();
      debugPrint('[BackgroundSync] Result: $result');
      return true;
    } catch (e, st) {
      debugPrint('[BackgroundSync] Error: $e\n$st');
      return false;
    }
  });
}

/// Registers the periodic WorkManager background sync task.
class BackgroundSyncManager {
  static Future<void> initialize() async {
    // isInDebugMode removed in workmanager 0.9.x
    await Workmanager().initialize(callbackDispatcher);
  }

  static Future<void> registerPeriodicSync() async {
    await Workmanager().registerPeriodicTask(
      AppConstants.syncWorkName,
      AppConstants.syncWorkName,
      frequency: AppConstants.syncInterval,
      constraints: Constraints(
        networkType: NetworkType.connected,
      ),
      // 0.9.x uses ExistingPeriodicWorkPolicy for periodic tasks
      existingWorkPolicy: ExistingPeriodicWorkPolicy.keep,
      backoffPolicy: BackoffPolicy.exponential,
      backoffPolicyDelay: const Duration(minutes: 5),
    );
    debugPrint('[BackgroundSyncManager] Periodic sync registered');
  }

  static Future<void> cancelAll() async {
    await Workmanager().cancelAll();
    debugPrint('[BackgroundSyncManager] All sync tasks cancelled');
  }

  /// Trigger an immediate one-off sync (e.g. when app comes to foreground).
  static Future<void> triggerImmediateSync() async {
    await Workmanager().registerOneOffTask(
      '${AppConstants.syncWorkName}_immediate',
      AppConstants.syncWorkName,
      constraints: Constraints(
        networkType: NetworkType.connected,
      ),
      existingWorkPolicy: ExistingWorkPolicy.replace,
    );
  }
}
