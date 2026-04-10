import 'package:flutter/foundation.dart';

import '../database/app_database.dart';
import '../models/call_log_model.dart';
import '../services/call_log_service.dart';

/// Single source of truth for call log data.
/// Reads from device → writes to local DB → exposes streams for UI.
class CallLogRepository {
  final AppDatabase _db;
  final CallLogService _callLogService;

  CallLogRepository(this._db, this._callLogService);

  // ── Streams ───────────────────────────────────────────────────────────────

  /// Live stream of all call logs (newest first) from local DB.
  Stream<List<CallLogModel>> watchCallLogs() {
    return _db.watchAllCallLogs().map(
          (rows) => rows.map((r) => r.toModel()).toList(),
        );
  }

  /// Live stream grouped by phone number, newest group first.
  Stream<List<CallLogGroup>> watchGroupedCallLogs() {
    return watchCallLogs().map(_groupByNumber);
  }

  // ── Fetch & persist ───────────────────────────────────────────────────────

  /// Pull latest call logs from the device and save new ones to local DB.
  /// Returns the count of newly added logs.
  Future<int> syncFromDevice() async {
    try {
      final deviceLogs = await _callLogService.fetchDeviceCallLogs();
      if (deviceLogs.isEmpty) return 0;

      final companions = deviceLogs.map((l) => l.toCompanion()).toList();
      await _db.upsertCallLogs(companions);

      debugPrint('[CallLogRepository] Synced ${deviceLogs.length} logs from device');
      return deviceLogs.length;
    } catch (e, st) {
      debugPrint('[CallLogRepository] syncFromDevice error: $e\n$st');
      return 0;
    }
  }

  // ── Sync status helpers ───────────────────────────────────────────────────

  Future<List<CallLogModel>> getUnsyncedLogs() async {
    final rows = await _db.getUnsyncedCallLogs();
    return rows.map((r) => r.toModel()).toList();
  }

  Future<void> markAsSynced(List<String> ids) => _db.markAsSynced(ids);

  Future<void> markAsFailed(List<String> ids, String error) =>
      _db.markAsFailed(ids, error);

  Future<void> markAsSyncing(List<String> ids) => _db.markAsSyncing(ids);

  Future<SyncSummary> getSyncSummary() async {
    final counts = await _db.getSyncStatusCounts();
    return SyncSummary(
      totalPending: (counts['pending'] ?? 0) + (counts['syncing'] ?? 0),
      totalSynced: counts['synced'] ?? 0,
      totalFailed: counts['failed'] ?? 0,
      lastSyncTime: null, // populated from SharedPreferences in provider
    );
  }

  // ── Grouping ──────────────────────────────────────────────────────────────

  List<CallLogGroup> _groupByNumber(List<CallLogModel> logs) {
    final Map<String, List<CallLogModel>> map = {};
    for (final log in logs) {
      map.putIfAbsent(log.phoneNumber, () => []).add(log);
    }

    return map.entries.map((entry) {
      final calls = entry.value
        ..sort((a, b) => b.timestamp.compareTo(a.timestamp));
      return CallLogGroup(
        phoneNumber: entry.key,
        contactName: calls.first.contactName,
        contactPhotoUri: calls.first.contactPhotoUri,
        calls: calls,
        lastCallTime: calls.first.timestamp,
        lastCallType: calls.first.callType,
      );
    }).toList()
      ..sort((a, b) => b.lastCallTime.compareTo(a.lastCallTime));
  }
}
