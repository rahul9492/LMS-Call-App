import 'package:call_log/call_log.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constants/app_constants.dart';
import '../models/call_log_model.dart';

/// Reads call logs from the native phone call log via the [call_log] package.
/// Also enriches logs with contact names from the device contacts book
/// using [flutter_contacts] for any number not already named in the call log.
class CallLogService {
  /// Fetch all call logs from the device for the past N days.
  /// Respects the user-configured fetch range stored in SharedPreferences.
  Future<List<CallLogModel>> fetchDeviceCallLogs() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final days = prefs.getInt(AppConstants.prefCallLogFetchDays) ??
          AppConstants.callLogFetchDays;
      final cutoff = DateTime.now()
          .subtract(Duration(days: days))
          .millisecondsSinceEpoch;

      final Iterable<CallLogEntry> entries = await CallLog.query(
        dateFrom: cutoff,
      );

      final logs = entries.map(_entryToModel).toList();

      // Enrich logs that have no contact name with a contacts lookup
      return await _enrichWithContactNames(logs);
    } catch (e, st) {
      debugPrint('[CallLogService] fetchDeviceCallLogs error: $e\n$st');
      return [];
    }
  }

  /// For logs missing a contact name, look up the number in the device
  /// contacts book and fill in the name if found.
  Future<List<CallLogModel>> _enrichWithContactNames(
      List<CallLogModel> logs) async {
    try {
      // Only proceed if we have permission
      final hasPermission = await FlutterContacts.requestPermission(readonly: true);
      if (!hasPermission) return logs;

      // Collect unique numbers that have no name
      final numbersToLookup = logs
          .where((l) => l.contactName == null && l.phoneNumber != 'Unknown')
          .map((l) => l.phoneNumber)
          .toSet();

      if (numbersToLookup.isEmpty) return logs;

      // Fetch all contacts with phone numbers in one call (faster than per-number lookup)
      final contacts = await FlutterContacts.getContacts(withProperties: true);

      // Build a map: normalized number → display name
      final Map<String, String> numberToName = {};
      for (final contact in contacts) {
        for (final phone in contact.phones) {
          final normalized = _normalizeNumber(phone.number);
          if (normalized != 'Unknown') {
            numberToName[normalized] = contact.displayName;
          }
        }
      }

      // Apply names to logs that were missing one
      return logs.map((log) {
        if (log.contactName != null) return log;
        final name = numberToName[log.phoneNumber];
        if (name == null || name.trim().isEmpty) return log;
        return log.copyWith(contactName: name);
      }).toList();
    } catch (e) {
      debugPrint('[CallLogService] _enrichWithContactNames error: $e');
      return logs; // graceful fallback — return unenriched logs
    }
  }

  /// Convert a native [CallLogEntry] to our domain [CallLogModel].
  CallLogModel _entryToModel(CallLogEntry entry) {
    final timestamp = entry.timestamp != null
        ? DateTime.fromMillisecondsSinceEpoch(entry.timestamp!)
        : DateTime.now();

    // Use a stable, unique id: number + timestamp millis
    final id = '${_normalizeNumber(entry.number)}_${entry.timestamp ?? 0}';

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
