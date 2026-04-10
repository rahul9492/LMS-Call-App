import 'package:call_log/call_log.dart';
import 'package:flutter/foundation.dart';

import '../../core/constants/app_constants.dart';
import '../models/call_log_model.dart';

/// Reads call logs from the native phone call log via the [call_log] package.
/// This is the same approach used by Truecaller and similar apps —
/// they read from the system ContentProvider (READ_CALL_LOG permission).
class CallLogService {
  /// Fetch all call logs from the device for the past N days.
  Future<List<CallLogModel>> fetchDeviceCallLogs() async {
    try {
      final cutoff = DateTime.now()
          .subtract(Duration(days: AppConstants.callLogFetchDays))
          .millisecondsSinceEpoch;

      final Iterable<CallLogEntry> entries = await CallLog.query(
        dateFrom: cutoff,
      );

      return entries.map(_entryToModel).toList();
    } catch (e, st) {
      debugPrint('[CallLogService] fetchDeviceCallLogs error: $e\n$st');
      return [];
    }
  }

  /// Convert a native [CallLogEntry] to our domain [CallLogModel].
  CallLogModel _entryToModel(CallLogEntry entry) {
    final timestamp = entry.timestamp != null
        ? DateTime.fromMillisecondsSinceEpoch(entry.timestamp!)
        : DateTime.now();

    // Use a stable, unique id: number + timestamp millis
    final id = '${_normalizeNumber(entry.number)}_${entry.timestamp ?? 0}';

    // Ring duration: for missed calls the "duration" from call_log is 0,
    // but we can derive a ring duration heuristic using the cached duration
    // field (some ROMs expose it). Fall back to 0.
    final durationSec = entry.duration ?? 0;

    return CallLogModel(
      id: id,
      phoneNumber: _normalizeNumber(entry.number),
      contactName: (entry.name?.isNotEmpty == true) ? entry.name : null,
      callType: _mapCallType(entry.callType),
      timestamp: timestamp,
      durationSeconds: durationSec,
      ringDurationSeconds: 0,
      syncStatus: SyncStatus.pending,
      simDisplayName: entry.simDisplayName,
      simSlot: entry.phoneAccountId != null
          ? int.tryParse(entry.phoneAccountId ?? '')
          : null,
    );
  }

  String _normalizeNumber(String? raw) {
    if (raw == null || raw.trim().isEmpty) return 'Unknown';
    // Strip formatting characters, keep + prefix
    return raw.replaceAll(RegExp(r'[\s\-().]'), '');
  }

  CallTypeEnum _mapCallType(CallType? type) {
    switch (type) {
      case CallType.incoming:
        return CallTypeEnum.incoming;
      case CallType.outgoing:
        return CallTypeEnum.outgoing;
      case CallType.missed:
        return CallTypeEnum.missed;
      case CallType.rejected:
        return CallTypeEnum.rejected;
      default:
        return CallTypeEnum.unknown;
    }
  }
}
