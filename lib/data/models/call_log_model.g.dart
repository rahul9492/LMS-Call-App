// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'call_log_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CallLogModel _$CallLogModelFromJson(Map<String, dynamic> json) =>
    _CallLogModel(
      id: json['id'] as String,
      phoneNumber: json['phoneNumber'] as String,
      contactName: json['contactName'] as String?,
      contactPhotoUri: json['contactPhotoUri'] as String?,
      callType: $enumDecode(_$CallTypeEnumEnumMap, json['callType']),
      timestamp: DateTime.parse(json['timestamp'] as String),
      durationSeconds: (json['durationSeconds'] as num).toInt(),
      ringDurationSeconds: (json['ringDurationSeconds'] as num).toInt(),
      syncStatus: $enumDecode(_$SyncStatusEnumMap, json['syncStatus']),
      simDisplayName: json['simDisplayName'] as String?,
      simSlot: (json['simSlot'] as num?)?.toInt(),
      cachedNumberType: json['cachedNumberType'] as String?,
      cachedNumberLabel: json['cachedNumberLabel'] as String?,
      lastSyncAttempt: json['lastSyncAttempt'] == null
          ? null
          : DateTime.parse(json['lastSyncAttempt'] as String),
      syncError: json['syncError'] as String?,
    );

Map<String, dynamic> _$CallLogModelToJson(_CallLogModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'phoneNumber': instance.phoneNumber,
      'contactName': instance.contactName,
      'contactPhotoUri': instance.contactPhotoUri,
      'callType': _$CallTypeEnumEnumMap[instance.callType]!,
      'timestamp': instance.timestamp.toIso8601String(),
      'durationSeconds': instance.durationSeconds,
      'ringDurationSeconds': instance.ringDurationSeconds,
      'syncStatus': _$SyncStatusEnumMap[instance.syncStatus]!,
      'simDisplayName': instance.simDisplayName,
      'simSlot': instance.simSlot,
      'cachedNumberType': instance.cachedNumberType,
      'cachedNumberLabel': instance.cachedNumberLabel,
      'lastSyncAttempt': instance.lastSyncAttempt?.toIso8601String(),
      'syncError': instance.syncError,
    };

const _$CallTypeEnumEnumMap = {
  CallTypeEnum.incoming: 'incoming',
  CallTypeEnum.outgoing: 'outgoing',
  CallTypeEnum.missed: 'missed',
  CallTypeEnum.rejected: 'rejected',
  CallTypeEnum.unknown: 'unknown',
};

const _$SyncStatusEnumMap = {
  SyncStatus.pending: 'pending',
  SyncStatus.syncing: 'syncing',
  SyncStatus.synced: 'synced',
  SyncStatus.failed: 'failed',
};
