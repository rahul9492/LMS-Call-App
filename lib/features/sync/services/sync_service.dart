import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constants/app_constants.dart';
import '../../../data/repositories/call_log_repository.dart';
import '../../../data/services/api_service.dart';
import '../../../data/services/connectivity_service.dart';
import '../../../data/services/notification_service.dart';

/// Orchestrates the full offline-first sync cycle:
/// 1. Fetch latest call logs from the device.
/// 2. Persist any new logs to local DB (always, even offline).
/// 3. When online, batch-upload pending logs to the API.
class SyncService {
  final CallLogRepository _repository;
  final ApiService _apiService;
  final ConnectivityService _connectivityService;

  SyncService(this._repository, this._apiService, this._connectivityService);

  /// Full sync cycle. Returns a [SyncResult] describing what happened.
  Future<SyncResult> runSync() async {
    // Step 1 – pull from device
    final newFromDevice = await _repository.syncFromDevice();

    // Step 2 – check connectivity
    final online = await _connectivityService.isConnected;
    if (!online) {
      debugPrint('[SyncService] Offline — skipping API upload');
      return SyncResult(
        newLogsFromDevice: newFromDevice,
        uploadedToApi: 0,
        failedToUpload: 0,
        wasOnline: false,
      );
    }

    // Step 3 – upload pending logs to API
    return _uploadPending(newFromDevice);
  }

  Future<SyncResult> _uploadPending(int newFromDevice) async {
    final pending = await _repository.getUnsyncedLogs();
    if (pending.isEmpty) {
      return SyncResult(
        newLogsFromDevice: newFromDevice,
        uploadedToApi: 0,
        failedToUpload: 0,
        wasOnline: true,
      );
    }

    int uploaded = 0;
    int failed = 0;

    // Batch into chunks to avoid huge payloads
    for (int i = 0; i < pending.length; i += AppConstants.syncBatchSize) {
      final batch = pending.skip(i).take(AppConstants.syncBatchSize).toList();
      final ids = batch.map((l) => l.id).toList();

      try {
        await _repository.markAsSyncing(ids);
        final acceptedIds = await _apiService.syncCallLogs(batch);
        await _repository.markAsSynced(acceptedIds);
        uploaded += acceptedIds.length;

        // Any ids not accepted → mark failed
        final notAccepted = ids.where((id) => !acceptedIds.contains(id)).toList();
        if (notAccepted.isNotEmpty) {
          await _repository.markAsFailed(notAccepted, 'Not accepted by server');
          failed += notAccepted.length;
        }
      } catch (e) {
        debugPrint('[SyncService] batch upload error: $e');
        await _repository.markAsFailed(ids, e.toString());
        failed += ids.length;
      }
    }

    // Persist last sync time
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(
      AppConstants.prefLastSyncTime,
      DateTime.now().millisecondsSinceEpoch,
    );

    debugPrint(
      '[SyncService] Sync complete — device: $newFromDevice, '
      'uploaded: $uploaded, failed: $failed',
    );

    // Show notification summarising the result
    if (failed > 0) {
      await NotificationService.showSyncFailure(failed: failed);
    } else {
      await NotificationService.showSyncSuccess(
        uploaded: uploaded,
        newFromDevice: newFromDevice,
      );
    }

    return SyncResult(
      newLogsFromDevice: newFromDevice,
      uploadedToApi: uploaded,
      failedToUpload: failed,
      wasOnline: true,
    );
  }
}

class SyncResult {
  final int newLogsFromDevice;
  final int uploadedToApi;
  final int failedToUpload;
  final bool wasOnline;

  const SyncResult({
    required this.newLogsFromDevice,
    required this.uploadedToApi,
    required this.failedToUpload,
    required this.wasOnline,
  });

  bool get hasErrors => failedToUpload > 0;

  @override
  String toString() =>
      'SyncResult(device: $newLogsFromDevice, uploaded: $uploadedToApi, '
      'failed: $failedToUpload, online: $wasOnline)';
}
