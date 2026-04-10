import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import '../../core/constants/app_constants.dart';
import '../../data/models/call_log_model.dart';

part 'app_database.g.dart';

// ──────────────────────────────────────────────
// Table definition
// ──────────────────────────────────────────────
class CallLogs extends Table {
  TextColumn get id => text()();
  TextColumn get phoneNumber => text()();
  TextColumn get contactName => text().nullable()();
  TextColumn get contactPhotoUri => text().nullable()();
  TextColumn get callType => text()(); // stored as string enum
  IntColumn get timestampMs => integer()(); // milliseconds since epoch
  IntColumn get durationSeconds => integer().withDefault(const Constant(0))();
  IntColumn get ringDurationSeconds => integer().withDefault(const Constant(0))();
  TextColumn get syncStatus => text().withDefault(const Constant('pending'))();
  TextColumn get simDisplayName => text().nullable()();
  IntColumn get simSlot => integer().nullable()();
  TextColumn get cachedNumberType => text().nullable()();
  TextColumn get cachedNumberLabel => text().nullable()();
  IntColumn get lastSyncAttemptMs => integer().nullable()();
  TextColumn get syncError => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

// ──────────────────────────────────────────────
// Database
// ──────────────────────────────────────────────
@DriftDatabase(tables: [CallLogs])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => AppConstants.dbVersion;

  // ── Queries ──────────────────────────────────

  /// All call logs ordered newest first
  Future<List<CallLog>> getAllCallLogs() =>
      (select(callLogs)..orderBy([(t) => OrderingTerm.desc(t.timestampMs)])).get();

  /// Stream of all call logs (live updates)
  Stream<List<CallLog>> watchAllCallLogs() =>
      (select(callLogs)..orderBy([(t) => OrderingTerm.desc(t.timestampMs)])).watch();

  /// Only pending / failed entries that need syncing
  Future<List<CallLog>> getUnsyncedCallLogs() => (select(callLogs)
        ..where((t) =>
            t.syncStatus.equals('pending') | t.syncStatus.equals('failed'))
        ..orderBy([(t) => OrderingTerm.asc(t.timestampMs)])
        ..limit(AppConstants.syncBatchSize))
      .get();

  /// Upsert a single call log
  Future<void> upsertCallLog(CallLogsCompanion entry) =>
      into(callLogs).insertOnConflictUpdate(entry);

  /// Upsert many call logs efficiently
  Future<void> upsertCallLogs(List<CallLogsCompanion> entries) =>
      batch((b) => b.insertAllOnConflictUpdate(callLogs, entries));

  /// Mark a list of ids as synced
  Future<void> markAsSynced(List<String> ids) async {
    await (update(callLogs)..where((t) => t.id.isIn(ids))).write(
      CallLogsCompanion(
        syncStatus: const Value('synced'),
        syncError: const Value(null),
        lastSyncAttemptMs: Value(DateTime.now().millisecondsSinceEpoch),
      ),
    );
  }

  /// Mark a list of ids as failed with an error message
  Future<void> markAsFailed(List<String> ids, String error) async {
    await (update(callLogs)..where((t) => t.id.isIn(ids))).write(
      CallLogsCompanion(
        syncStatus: const Value('failed'),
        syncError: Value(error),
        lastSyncAttemptMs: Value(DateTime.now().millisecondsSinceEpoch),
      ),
    );
  }

  /// Mark as syncing (in-flight)
  Future<void> markAsSyncing(List<String> ids) async {
    await (update(callLogs)..where((t) => t.id.isIn(ids))).write(
      const CallLogsCompanion(syncStatus: Value('syncing')),
    );
  }

  /// Counts per sync status
  Future<Map<String, int>> getSyncStatusCounts() async {
    final rows = await customSelect(
      'SELECT sync_status, COUNT(*) as cnt FROM call_logs GROUP BY sync_status',
      readsFrom: {callLogs},
    ).get();
    return {for (final row in rows) row.read<String>('sync_status'): row.read<int>('cnt')};
  }

  /// Reset all failed logs back to pending so they can be retried
  Future<void> resetFailedToPending() async {
    await (update(callLogs)..where((t) => t.syncStatus.equals('failed'))).write(
      const CallLogsCompanion(
        syncStatus: Value('pending'),
        syncError: Value(null),
      ),
    );
  }

  /// Delete all logs (for reset)
  Future<void> clearAll() => delete(callLogs).go();
}

// ──────────────────────────────────────────────
// Connection helper
// ──────────────────────────────────────────────
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, AppConstants.dbName));
    return NativeDatabase.createInBackground(file);
  });
}

// ──────────────────────────────────────────────
// Mapper: Drift row → domain model
// ──────────────────────────────────────────────
extension CallLogMapper on CallLog {
  CallLogModel toModel() {
    return CallLogModel(
      id: id,
      phoneNumber: phoneNumber,
      contactName: contactName,
      contactPhotoUri: contactPhotoUri,
      callType: _parseCallType(callType),
      timestamp: DateTime.fromMillisecondsSinceEpoch(timestampMs),
      durationSeconds: durationSeconds,
      ringDurationSeconds: ringDurationSeconds,
      syncStatus: _parseSyncStatus(syncStatus),
      simDisplayName: simDisplayName,
      simSlot: simSlot,
      cachedNumberType: cachedNumberType,
      cachedNumberLabel: cachedNumberLabel,
      lastSyncAttempt: lastSyncAttemptMs != null
          ? DateTime.fromMillisecondsSinceEpoch(lastSyncAttemptMs!)
          : null,
      syncError: syncError,
    );
  }

  static CallTypeEnum _parseCallType(String value) {
    return CallTypeEnum.values.firstWhere(
      (e) => e.name == value,
      orElse: () => CallTypeEnum.unknown,
    );
  }

  static SyncStatus _parseSyncStatus(String value) {
    return SyncStatus.values.firstWhere(
      (e) => e.name == value,
      orElse: () => SyncStatus.pending,
    );
  }
}

// ──────────────────────────────────────────────
// Mapper: domain model → Drift companion
// ──────────────────────────────────────────────
extension CallLogModelMapper on CallLogModel {
  CallLogsCompanion toCompanion() {
    return CallLogsCompanion(
      id: Value(id),
      phoneNumber: Value(phoneNumber),
      contactName: Value(contactName),
      contactPhotoUri: Value(contactPhotoUri),
      callType: Value(callType.name),
      timestampMs: Value(timestamp.millisecondsSinceEpoch),
      durationSeconds: Value(durationSeconds),
      ringDurationSeconds: Value(ringDurationSeconds),
      syncStatus: Value(syncStatus.name),
      simDisplayName: Value(simDisplayName),
      simSlot: Value(simSlot),
      cachedNumberType: Value(cachedNumberType),
      cachedNumberLabel: Value(cachedNumberLabel),
      lastSyncAttemptMs: Value(lastSyncAttempt?.millisecondsSinceEpoch),
      syncError: Value(syncError),
    );
  }
}
