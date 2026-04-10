import 'package:freezed_annotation/freezed_annotation.dart';

part 'call_log_model.freezed.dart';
part 'call_log_model.g.dart';

enum CallTypeEnum {
  incoming,
  outgoing,
  missed,
  rejected,
  unknown,
}

enum SyncStatus {
  pending,
  syncing,
  synced,
  failed,
}

@freezed
abstract class CallLogModel with _$CallLogModel {
  const factory CallLogModel({
    required String id,
    required String phoneNumber,
    String? contactName,
    String? contactPhotoUri,
    required CallTypeEnum callType,
    required DateTime timestamp,

    /// Total call duration in seconds (connected time)
    required int durationSeconds,

    /// How long the phone rang before answered/missed (seconds)
    required int ringDurationSeconds,

    required SyncStatus syncStatus,
    String? simDisplayName,
    int? simSlot,
    String? cachedNumberType,
    String? cachedNumberLabel,
    DateTime? lastSyncAttempt,
    String? syncError,
  }) = _CallLogModel;

  factory CallLogModel.fromJson(Map<String, dynamic> json) =>
      _$CallLogModelFromJson(json);
}

@freezed
abstract class CallLogGroup with _$CallLogGroup {
  const CallLogGroup._();

  const factory CallLogGroup({
    required String phoneNumber,
    String? contactName,
    String? contactPhotoUri,
    required List<CallLogModel> calls,
    required DateTime lastCallTime,
    required CallTypeEnum lastCallType,
  }) = _CallLogGroup;

  int get totalCalls => calls.length;
  int get missedCount => calls.where((c) => c.callType == CallTypeEnum.missed).length;
  bool get hasMissed => missedCount > 0;
}

@freezed
abstract class SyncSummary with _$SyncSummary {
  const SyncSummary._();

  const factory SyncSummary({
    required int totalPending,
    required int totalSynced,
    required int totalFailed,
    DateTime? lastSyncTime,
  }) = _SyncSummary;

  bool get hasUnsynced => totalPending > 0 || totalFailed > 0;
}
