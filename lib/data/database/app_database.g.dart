// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $CallLogsTable extends CallLogs with TableInfo<$CallLogsTable, CallLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CallLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _phoneNumberMeta = const VerificationMeta(
    'phoneNumber',
  );
  @override
  late final GeneratedColumn<String> phoneNumber = GeneratedColumn<String>(
    'phone_number',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contactNameMeta = const VerificationMeta(
    'contactName',
  );
  @override
  late final GeneratedColumn<String> contactName = GeneratedColumn<String>(
    'contact_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _contactPhotoUriMeta = const VerificationMeta(
    'contactPhotoUri',
  );
  @override
  late final GeneratedColumn<String> contactPhotoUri = GeneratedColumn<String>(
    'contact_photo_uri',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _callTypeMeta = const VerificationMeta(
    'callType',
  );
  @override
  late final GeneratedColumn<String> callType = GeneratedColumn<String>(
    'call_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _timestampMsMeta = const VerificationMeta(
    'timestampMs',
  );
  @override
  late final GeneratedColumn<int> timestampMs = GeneratedColumn<int>(
    'timestamp_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _durationSecondsMeta = const VerificationMeta(
    'durationSeconds',
  );
  @override
  late final GeneratedColumn<int> durationSeconds = GeneratedColumn<int>(
    'duration_seconds',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _ringDurationSecondsMeta =
      const VerificationMeta('ringDurationSeconds');
  @override
  late final GeneratedColumn<int> ringDurationSeconds = GeneratedColumn<int>(
    'ring_duration_seconds',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pending'),
  );
  static const VerificationMeta _simDisplayNameMeta = const VerificationMeta(
    'simDisplayName',
  );
  @override
  late final GeneratedColumn<String> simDisplayName = GeneratedColumn<String>(
    'sim_display_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _simSlotMeta = const VerificationMeta(
    'simSlot',
  );
  @override
  late final GeneratedColumn<int> simSlot = GeneratedColumn<int>(
    'sim_slot',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _cachedNumberTypeMeta = const VerificationMeta(
    'cachedNumberType',
  );
  @override
  late final GeneratedColumn<String> cachedNumberType = GeneratedColumn<String>(
    'cached_number_type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _cachedNumberLabelMeta = const VerificationMeta(
    'cachedNumberLabel',
  );
  @override
  late final GeneratedColumn<String> cachedNumberLabel =
      GeneratedColumn<String>(
        'cached_number_label',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _lastSyncAttemptMsMeta = const VerificationMeta(
    'lastSyncAttemptMs',
  );
  @override
  late final GeneratedColumn<int> lastSyncAttemptMs = GeneratedColumn<int>(
    'last_sync_attempt_ms',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _syncErrorMeta = const VerificationMeta(
    'syncError',
  );
  @override
  late final GeneratedColumn<String> syncError = GeneratedColumn<String>(
    'sync_error',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    phoneNumber,
    contactName,
    contactPhotoUri,
    callType,
    timestampMs,
    durationSeconds,
    ringDurationSeconds,
    syncStatus,
    simDisplayName,
    simSlot,
    cachedNumberType,
    cachedNumberLabel,
    lastSyncAttemptMs,
    syncError,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'call_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<CallLog> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('phone_number')) {
      context.handle(
        _phoneNumberMeta,
        phoneNumber.isAcceptableOrUnknown(
          data['phone_number']!,
          _phoneNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_phoneNumberMeta);
    }
    if (data.containsKey('contact_name')) {
      context.handle(
        _contactNameMeta,
        contactName.isAcceptableOrUnknown(
          data['contact_name']!,
          _contactNameMeta,
        ),
      );
    }
    if (data.containsKey('contact_photo_uri')) {
      context.handle(
        _contactPhotoUriMeta,
        contactPhotoUri.isAcceptableOrUnknown(
          data['contact_photo_uri']!,
          _contactPhotoUriMeta,
        ),
      );
    }
    if (data.containsKey('call_type')) {
      context.handle(
        _callTypeMeta,
        callType.isAcceptableOrUnknown(data['call_type']!, _callTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_callTypeMeta);
    }
    if (data.containsKey('timestamp_ms')) {
      context.handle(
        _timestampMsMeta,
        timestampMs.isAcceptableOrUnknown(
          data['timestamp_ms']!,
          _timestampMsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_timestampMsMeta);
    }
    if (data.containsKey('duration_seconds')) {
      context.handle(
        _durationSecondsMeta,
        durationSeconds.isAcceptableOrUnknown(
          data['duration_seconds']!,
          _durationSecondsMeta,
        ),
      );
    }
    if (data.containsKey('ring_duration_seconds')) {
      context.handle(
        _ringDurationSecondsMeta,
        ringDurationSeconds.isAcceptableOrUnknown(
          data['ring_duration_seconds']!,
          _ringDurationSecondsMeta,
        ),
      );
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    if (data.containsKey('sim_display_name')) {
      context.handle(
        _simDisplayNameMeta,
        simDisplayName.isAcceptableOrUnknown(
          data['sim_display_name']!,
          _simDisplayNameMeta,
        ),
      );
    }
    if (data.containsKey('sim_slot')) {
      context.handle(
        _simSlotMeta,
        simSlot.isAcceptableOrUnknown(data['sim_slot']!, _simSlotMeta),
      );
    }
    if (data.containsKey('cached_number_type')) {
      context.handle(
        _cachedNumberTypeMeta,
        cachedNumberType.isAcceptableOrUnknown(
          data['cached_number_type']!,
          _cachedNumberTypeMeta,
        ),
      );
    }
    if (data.containsKey('cached_number_label')) {
      context.handle(
        _cachedNumberLabelMeta,
        cachedNumberLabel.isAcceptableOrUnknown(
          data['cached_number_label']!,
          _cachedNumberLabelMeta,
        ),
      );
    }
    if (data.containsKey('last_sync_attempt_ms')) {
      context.handle(
        _lastSyncAttemptMsMeta,
        lastSyncAttemptMs.isAcceptableOrUnknown(
          data['last_sync_attempt_ms']!,
          _lastSyncAttemptMsMeta,
        ),
      );
    }
    if (data.containsKey('sync_error')) {
      context.handle(
        _syncErrorMeta,
        syncError.isAcceptableOrUnknown(data['sync_error']!, _syncErrorMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CallLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CallLog(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      phoneNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone_number'],
      )!,
      contactName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}contact_name'],
      ),
      contactPhotoUri: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}contact_photo_uri'],
      ),
      callType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}call_type'],
      )!,
      timestampMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}timestamp_ms'],
      )!,
      durationSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration_seconds'],
      )!,
      ringDurationSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ring_duration_seconds'],
      )!,
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
      simDisplayName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sim_display_name'],
      ),
      simSlot: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sim_slot'],
      ),
      cachedNumberType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cached_number_type'],
      ),
      cachedNumberLabel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cached_number_label'],
      ),
      lastSyncAttemptMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}last_sync_attempt_ms'],
      ),
      syncError: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_error'],
      ),
    );
  }

  @override
  $CallLogsTable createAlias(String alias) {
    return $CallLogsTable(attachedDatabase, alias);
  }
}

class CallLog extends DataClass implements Insertable<CallLog> {
  final String id;
  final String phoneNumber;
  final String? contactName;
  final String? contactPhotoUri;
  final String callType;
  final int timestampMs;
  final int durationSeconds;
  final int ringDurationSeconds;
  final String syncStatus;
  final String? simDisplayName;
  final int? simSlot;
  final String? cachedNumberType;
  final String? cachedNumberLabel;
  final int? lastSyncAttemptMs;
  final String? syncError;
  const CallLog({
    required this.id,
    required this.phoneNumber,
    this.contactName,
    this.contactPhotoUri,
    required this.callType,
    required this.timestampMs,
    required this.durationSeconds,
    required this.ringDurationSeconds,
    required this.syncStatus,
    this.simDisplayName,
    this.simSlot,
    this.cachedNumberType,
    this.cachedNumberLabel,
    this.lastSyncAttemptMs,
    this.syncError,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['phone_number'] = Variable<String>(phoneNumber);
    if (!nullToAbsent || contactName != null) {
      map['contact_name'] = Variable<String>(contactName);
    }
    if (!nullToAbsent || contactPhotoUri != null) {
      map['contact_photo_uri'] = Variable<String>(contactPhotoUri);
    }
    map['call_type'] = Variable<String>(callType);
    map['timestamp_ms'] = Variable<int>(timestampMs);
    map['duration_seconds'] = Variable<int>(durationSeconds);
    map['ring_duration_seconds'] = Variable<int>(ringDurationSeconds);
    map['sync_status'] = Variable<String>(syncStatus);
    if (!nullToAbsent || simDisplayName != null) {
      map['sim_display_name'] = Variable<String>(simDisplayName);
    }
    if (!nullToAbsent || simSlot != null) {
      map['sim_slot'] = Variable<int>(simSlot);
    }
    if (!nullToAbsent || cachedNumberType != null) {
      map['cached_number_type'] = Variable<String>(cachedNumberType);
    }
    if (!nullToAbsent || cachedNumberLabel != null) {
      map['cached_number_label'] = Variable<String>(cachedNumberLabel);
    }
    if (!nullToAbsent || lastSyncAttemptMs != null) {
      map['last_sync_attempt_ms'] = Variable<int>(lastSyncAttemptMs);
    }
    if (!nullToAbsent || syncError != null) {
      map['sync_error'] = Variable<String>(syncError);
    }
    return map;
  }

  CallLogsCompanion toCompanion(bool nullToAbsent) {
    return CallLogsCompanion(
      id: Value(id),
      phoneNumber: Value(phoneNumber),
      contactName: contactName == null && nullToAbsent
          ? const Value.absent()
          : Value(contactName),
      contactPhotoUri: contactPhotoUri == null && nullToAbsent
          ? const Value.absent()
          : Value(contactPhotoUri),
      callType: Value(callType),
      timestampMs: Value(timestampMs),
      durationSeconds: Value(durationSeconds),
      ringDurationSeconds: Value(ringDurationSeconds),
      syncStatus: Value(syncStatus),
      simDisplayName: simDisplayName == null && nullToAbsent
          ? const Value.absent()
          : Value(simDisplayName),
      simSlot: simSlot == null && nullToAbsent
          ? const Value.absent()
          : Value(simSlot),
      cachedNumberType: cachedNumberType == null && nullToAbsent
          ? const Value.absent()
          : Value(cachedNumberType),
      cachedNumberLabel: cachedNumberLabel == null && nullToAbsent
          ? const Value.absent()
          : Value(cachedNumberLabel),
      lastSyncAttemptMs: lastSyncAttemptMs == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSyncAttemptMs),
      syncError: syncError == null && nullToAbsent
          ? const Value.absent()
          : Value(syncError),
    );
  }

  factory CallLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CallLog(
      id: serializer.fromJson<String>(json['id']),
      phoneNumber: serializer.fromJson<String>(json['phoneNumber']),
      contactName: serializer.fromJson<String?>(json['contactName']),
      contactPhotoUri: serializer.fromJson<String?>(json['contactPhotoUri']),
      callType: serializer.fromJson<String>(json['callType']),
      timestampMs: serializer.fromJson<int>(json['timestampMs']),
      durationSeconds: serializer.fromJson<int>(json['durationSeconds']),
      ringDurationSeconds: serializer.fromJson<int>(
        json['ringDurationSeconds'],
      ),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      simDisplayName: serializer.fromJson<String?>(json['simDisplayName']),
      simSlot: serializer.fromJson<int?>(json['simSlot']),
      cachedNumberType: serializer.fromJson<String?>(json['cachedNumberType']),
      cachedNumberLabel: serializer.fromJson<String?>(
        json['cachedNumberLabel'],
      ),
      lastSyncAttemptMs: serializer.fromJson<int?>(json['lastSyncAttemptMs']),
      syncError: serializer.fromJson<String?>(json['syncError']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'phoneNumber': serializer.toJson<String>(phoneNumber),
      'contactName': serializer.toJson<String?>(contactName),
      'contactPhotoUri': serializer.toJson<String?>(contactPhotoUri),
      'callType': serializer.toJson<String>(callType),
      'timestampMs': serializer.toJson<int>(timestampMs),
      'durationSeconds': serializer.toJson<int>(durationSeconds),
      'ringDurationSeconds': serializer.toJson<int>(ringDurationSeconds),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'simDisplayName': serializer.toJson<String?>(simDisplayName),
      'simSlot': serializer.toJson<int?>(simSlot),
      'cachedNumberType': serializer.toJson<String?>(cachedNumberType),
      'cachedNumberLabel': serializer.toJson<String?>(cachedNumberLabel),
      'lastSyncAttemptMs': serializer.toJson<int?>(lastSyncAttemptMs),
      'syncError': serializer.toJson<String?>(syncError),
    };
  }

  CallLog copyWith({
    String? id,
    String? phoneNumber,
    Value<String?> contactName = const Value.absent(),
    Value<String?> contactPhotoUri = const Value.absent(),
    String? callType,
    int? timestampMs,
    int? durationSeconds,
    int? ringDurationSeconds,
    String? syncStatus,
    Value<String?> simDisplayName = const Value.absent(),
    Value<int?> simSlot = const Value.absent(),
    Value<String?> cachedNumberType = const Value.absent(),
    Value<String?> cachedNumberLabel = const Value.absent(),
    Value<int?> lastSyncAttemptMs = const Value.absent(),
    Value<String?> syncError = const Value.absent(),
  }) => CallLog(
    id: id ?? this.id,
    phoneNumber: phoneNumber ?? this.phoneNumber,
    contactName: contactName.present ? contactName.value : this.contactName,
    contactPhotoUri: contactPhotoUri.present
        ? contactPhotoUri.value
        : this.contactPhotoUri,
    callType: callType ?? this.callType,
    timestampMs: timestampMs ?? this.timestampMs,
    durationSeconds: durationSeconds ?? this.durationSeconds,
    ringDurationSeconds: ringDurationSeconds ?? this.ringDurationSeconds,
    syncStatus: syncStatus ?? this.syncStatus,
    simDisplayName: simDisplayName.present
        ? simDisplayName.value
        : this.simDisplayName,
    simSlot: simSlot.present ? simSlot.value : this.simSlot,
    cachedNumberType: cachedNumberType.present
        ? cachedNumberType.value
        : this.cachedNumberType,
    cachedNumberLabel: cachedNumberLabel.present
        ? cachedNumberLabel.value
        : this.cachedNumberLabel,
    lastSyncAttemptMs: lastSyncAttemptMs.present
        ? lastSyncAttemptMs.value
        : this.lastSyncAttemptMs,
    syncError: syncError.present ? syncError.value : this.syncError,
  );
  CallLog copyWithCompanion(CallLogsCompanion data) {
    return CallLog(
      id: data.id.present ? data.id.value : this.id,
      phoneNumber: data.phoneNumber.present
          ? data.phoneNumber.value
          : this.phoneNumber,
      contactName: data.contactName.present
          ? data.contactName.value
          : this.contactName,
      contactPhotoUri: data.contactPhotoUri.present
          ? data.contactPhotoUri.value
          : this.contactPhotoUri,
      callType: data.callType.present ? data.callType.value : this.callType,
      timestampMs: data.timestampMs.present
          ? data.timestampMs.value
          : this.timestampMs,
      durationSeconds: data.durationSeconds.present
          ? data.durationSeconds.value
          : this.durationSeconds,
      ringDurationSeconds: data.ringDurationSeconds.present
          ? data.ringDurationSeconds.value
          : this.ringDurationSeconds,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      simDisplayName: data.simDisplayName.present
          ? data.simDisplayName.value
          : this.simDisplayName,
      simSlot: data.simSlot.present ? data.simSlot.value : this.simSlot,
      cachedNumberType: data.cachedNumberType.present
          ? data.cachedNumberType.value
          : this.cachedNumberType,
      cachedNumberLabel: data.cachedNumberLabel.present
          ? data.cachedNumberLabel.value
          : this.cachedNumberLabel,
      lastSyncAttemptMs: data.lastSyncAttemptMs.present
          ? data.lastSyncAttemptMs.value
          : this.lastSyncAttemptMs,
      syncError: data.syncError.present ? data.syncError.value : this.syncError,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CallLog(')
          ..write('id: $id, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('contactName: $contactName, ')
          ..write('contactPhotoUri: $contactPhotoUri, ')
          ..write('callType: $callType, ')
          ..write('timestampMs: $timestampMs, ')
          ..write('durationSeconds: $durationSeconds, ')
          ..write('ringDurationSeconds: $ringDurationSeconds, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('simDisplayName: $simDisplayName, ')
          ..write('simSlot: $simSlot, ')
          ..write('cachedNumberType: $cachedNumberType, ')
          ..write('cachedNumberLabel: $cachedNumberLabel, ')
          ..write('lastSyncAttemptMs: $lastSyncAttemptMs, ')
          ..write('syncError: $syncError')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    phoneNumber,
    contactName,
    contactPhotoUri,
    callType,
    timestampMs,
    durationSeconds,
    ringDurationSeconds,
    syncStatus,
    simDisplayName,
    simSlot,
    cachedNumberType,
    cachedNumberLabel,
    lastSyncAttemptMs,
    syncError,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CallLog &&
          other.id == this.id &&
          other.phoneNumber == this.phoneNumber &&
          other.contactName == this.contactName &&
          other.contactPhotoUri == this.contactPhotoUri &&
          other.callType == this.callType &&
          other.timestampMs == this.timestampMs &&
          other.durationSeconds == this.durationSeconds &&
          other.ringDurationSeconds == this.ringDurationSeconds &&
          other.syncStatus == this.syncStatus &&
          other.simDisplayName == this.simDisplayName &&
          other.simSlot == this.simSlot &&
          other.cachedNumberType == this.cachedNumberType &&
          other.cachedNumberLabel == this.cachedNumberLabel &&
          other.lastSyncAttemptMs == this.lastSyncAttemptMs &&
          other.syncError == this.syncError);
}

class CallLogsCompanion extends UpdateCompanion<CallLog> {
  final Value<String> id;
  final Value<String> phoneNumber;
  final Value<String?> contactName;
  final Value<String?> contactPhotoUri;
  final Value<String> callType;
  final Value<int> timestampMs;
  final Value<int> durationSeconds;
  final Value<int> ringDurationSeconds;
  final Value<String> syncStatus;
  final Value<String?> simDisplayName;
  final Value<int?> simSlot;
  final Value<String?> cachedNumberType;
  final Value<String?> cachedNumberLabel;
  final Value<int?> lastSyncAttemptMs;
  final Value<String?> syncError;
  final Value<int> rowid;
  const CallLogsCompanion({
    this.id = const Value.absent(),
    this.phoneNumber = const Value.absent(),
    this.contactName = const Value.absent(),
    this.contactPhotoUri = const Value.absent(),
    this.callType = const Value.absent(),
    this.timestampMs = const Value.absent(),
    this.durationSeconds = const Value.absent(),
    this.ringDurationSeconds = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.simDisplayName = const Value.absent(),
    this.simSlot = const Value.absent(),
    this.cachedNumberType = const Value.absent(),
    this.cachedNumberLabel = const Value.absent(),
    this.lastSyncAttemptMs = const Value.absent(),
    this.syncError = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CallLogsCompanion.insert({
    required String id,
    required String phoneNumber,
    this.contactName = const Value.absent(),
    this.contactPhotoUri = const Value.absent(),
    required String callType,
    required int timestampMs,
    this.durationSeconds = const Value.absent(),
    this.ringDurationSeconds = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.simDisplayName = const Value.absent(),
    this.simSlot = const Value.absent(),
    this.cachedNumberType = const Value.absent(),
    this.cachedNumberLabel = const Value.absent(),
    this.lastSyncAttemptMs = const Value.absent(),
    this.syncError = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       phoneNumber = Value(phoneNumber),
       callType = Value(callType),
       timestampMs = Value(timestampMs);
  static Insertable<CallLog> custom({
    Expression<String>? id,
    Expression<String>? phoneNumber,
    Expression<String>? contactName,
    Expression<String>? contactPhotoUri,
    Expression<String>? callType,
    Expression<int>? timestampMs,
    Expression<int>? durationSeconds,
    Expression<int>? ringDurationSeconds,
    Expression<String>? syncStatus,
    Expression<String>? simDisplayName,
    Expression<int>? simSlot,
    Expression<String>? cachedNumberType,
    Expression<String>? cachedNumberLabel,
    Expression<int>? lastSyncAttemptMs,
    Expression<String>? syncError,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (phoneNumber != null) 'phone_number': phoneNumber,
      if (contactName != null) 'contact_name': contactName,
      if (contactPhotoUri != null) 'contact_photo_uri': contactPhotoUri,
      if (callType != null) 'call_type': callType,
      if (timestampMs != null) 'timestamp_ms': timestampMs,
      if (durationSeconds != null) 'duration_seconds': durationSeconds,
      if (ringDurationSeconds != null)
        'ring_duration_seconds': ringDurationSeconds,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (simDisplayName != null) 'sim_display_name': simDisplayName,
      if (simSlot != null) 'sim_slot': simSlot,
      if (cachedNumberType != null) 'cached_number_type': cachedNumberType,
      if (cachedNumberLabel != null) 'cached_number_label': cachedNumberLabel,
      if (lastSyncAttemptMs != null) 'last_sync_attempt_ms': lastSyncAttemptMs,
      if (syncError != null) 'sync_error': syncError,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CallLogsCompanion copyWith({
    Value<String>? id,
    Value<String>? phoneNumber,
    Value<String?>? contactName,
    Value<String?>? contactPhotoUri,
    Value<String>? callType,
    Value<int>? timestampMs,
    Value<int>? durationSeconds,
    Value<int>? ringDurationSeconds,
    Value<String>? syncStatus,
    Value<String?>? simDisplayName,
    Value<int?>? simSlot,
    Value<String?>? cachedNumberType,
    Value<String?>? cachedNumberLabel,
    Value<int?>? lastSyncAttemptMs,
    Value<String?>? syncError,
    Value<int>? rowid,
  }) {
    return CallLogsCompanion(
      id: id ?? this.id,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      contactName: contactName ?? this.contactName,
      contactPhotoUri: contactPhotoUri ?? this.contactPhotoUri,
      callType: callType ?? this.callType,
      timestampMs: timestampMs ?? this.timestampMs,
      durationSeconds: durationSeconds ?? this.durationSeconds,
      ringDurationSeconds: ringDurationSeconds ?? this.ringDurationSeconds,
      syncStatus: syncStatus ?? this.syncStatus,
      simDisplayName: simDisplayName ?? this.simDisplayName,
      simSlot: simSlot ?? this.simSlot,
      cachedNumberType: cachedNumberType ?? this.cachedNumberType,
      cachedNumberLabel: cachedNumberLabel ?? this.cachedNumberLabel,
      lastSyncAttemptMs: lastSyncAttemptMs ?? this.lastSyncAttemptMs,
      syncError: syncError ?? this.syncError,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (phoneNumber.present) {
      map['phone_number'] = Variable<String>(phoneNumber.value);
    }
    if (contactName.present) {
      map['contact_name'] = Variable<String>(contactName.value);
    }
    if (contactPhotoUri.present) {
      map['contact_photo_uri'] = Variable<String>(contactPhotoUri.value);
    }
    if (callType.present) {
      map['call_type'] = Variable<String>(callType.value);
    }
    if (timestampMs.present) {
      map['timestamp_ms'] = Variable<int>(timestampMs.value);
    }
    if (durationSeconds.present) {
      map['duration_seconds'] = Variable<int>(durationSeconds.value);
    }
    if (ringDurationSeconds.present) {
      map['ring_duration_seconds'] = Variable<int>(ringDurationSeconds.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (simDisplayName.present) {
      map['sim_display_name'] = Variable<String>(simDisplayName.value);
    }
    if (simSlot.present) {
      map['sim_slot'] = Variable<int>(simSlot.value);
    }
    if (cachedNumberType.present) {
      map['cached_number_type'] = Variable<String>(cachedNumberType.value);
    }
    if (cachedNumberLabel.present) {
      map['cached_number_label'] = Variable<String>(cachedNumberLabel.value);
    }
    if (lastSyncAttemptMs.present) {
      map['last_sync_attempt_ms'] = Variable<int>(lastSyncAttemptMs.value);
    }
    if (syncError.present) {
      map['sync_error'] = Variable<String>(syncError.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CallLogsCompanion(')
          ..write('id: $id, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('contactName: $contactName, ')
          ..write('contactPhotoUri: $contactPhotoUri, ')
          ..write('callType: $callType, ')
          ..write('timestampMs: $timestampMs, ')
          ..write('durationSeconds: $durationSeconds, ')
          ..write('ringDurationSeconds: $ringDurationSeconds, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('simDisplayName: $simDisplayName, ')
          ..write('simSlot: $simSlot, ')
          ..write('cachedNumberType: $cachedNumberType, ')
          ..write('cachedNumberLabel: $cachedNumberLabel, ')
          ..write('lastSyncAttemptMs: $lastSyncAttemptMs, ')
          ..write('syncError: $syncError, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $CallLogsTable callLogs = $CallLogsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [callLogs];
}

typedef $$CallLogsTableCreateCompanionBuilder =
    CallLogsCompanion Function({
      required String id,
      required String phoneNumber,
      Value<String?> contactName,
      Value<String?> contactPhotoUri,
      required String callType,
      required int timestampMs,
      Value<int> durationSeconds,
      Value<int> ringDurationSeconds,
      Value<String> syncStatus,
      Value<String?> simDisplayName,
      Value<int?> simSlot,
      Value<String?> cachedNumberType,
      Value<String?> cachedNumberLabel,
      Value<int?> lastSyncAttemptMs,
      Value<String?> syncError,
      Value<int> rowid,
    });
typedef $$CallLogsTableUpdateCompanionBuilder =
    CallLogsCompanion Function({
      Value<String> id,
      Value<String> phoneNumber,
      Value<String?> contactName,
      Value<String?> contactPhotoUri,
      Value<String> callType,
      Value<int> timestampMs,
      Value<int> durationSeconds,
      Value<int> ringDurationSeconds,
      Value<String> syncStatus,
      Value<String?> simDisplayName,
      Value<int?> simSlot,
      Value<String?> cachedNumberType,
      Value<String?> cachedNumberLabel,
      Value<int?> lastSyncAttemptMs,
      Value<String?> syncError,
      Value<int> rowid,
    });

class $$CallLogsTableFilterComposer
    extends Composer<_$AppDatabase, $CallLogsTable> {
  $$CallLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phoneNumber => $composableBuilder(
    column: $table.phoneNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contactName => $composableBuilder(
    column: $table.contactName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contactPhotoUri => $composableBuilder(
    column: $table.contactPhotoUri,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get callType => $composableBuilder(
    column: $table.callType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get timestampMs => $composableBuilder(
    column: $table.timestampMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get durationSeconds => $composableBuilder(
    column: $table.durationSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get ringDurationSeconds => $composableBuilder(
    column: $table.ringDurationSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get simDisplayName => $composableBuilder(
    column: $table.simDisplayName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get simSlot => $composableBuilder(
    column: $table.simSlot,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cachedNumberType => $composableBuilder(
    column: $table.cachedNumberType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cachedNumberLabel => $composableBuilder(
    column: $table.cachedNumberLabel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lastSyncAttemptMs => $composableBuilder(
    column: $table.lastSyncAttemptMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncError => $composableBuilder(
    column: $table.syncError,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CallLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $CallLogsTable> {
  $$CallLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phoneNumber => $composableBuilder(
    column: $table.phoneNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contactName => $composableBuilder(
    column: $table.contactName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contactPhotoUri => $composableBuilder(
    column: $table.contactPhotoUri,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get callType => $composableBuilder(
    column: $table.callType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get timestampMs => $composableBuilder(
    column: $table.timestampMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durationSeconds => $composableBuilder(
    column: $table.durationSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get ringDurationSeconds => $composableBuilder(
    column: $table.ringDurationSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get simDisplayName => $composableBuilder(
    column: $table.simDisplayName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get simSlot => $composableBuilder(
    column: $table.simSlot,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cachedNumberType => $composableBuilder(
    column: $table.cachedNumberType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cachedNumberLabel => $composableBuilder(
    column: $table.cachedNumberLabel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lastSyncAttemptMs => $composableBuilder(
    column: $table.lastSyncAttemptMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncError => $composableBuilder(
    column: $table.syncError,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CallLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CallLogsTable> {
  $$CallLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get phoneNumber => $composableBuilder(
    column: $table.phoneNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get contactName => $composableBuilder(
    column: $table.contactName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get contactPhotoUri => $composableBuilder(
    column: $table.contactPhotoUri,
    builder: (column) => column,
  );

  GeneratedColumn<String> get callType =>
      $composableBuilder(column: $table.callType, builder: (column) => column);

  GeneratedColumn<int> get timestampMs => $composableBuilder(
    column: $table.timestampMs,
    builder: (column) => column,
  );

  GeneratedColumn<int> get durationSeconds => $composableBuilder(
    column: $table.durationSeconds,
    builder: (column) => column,
  );

  GeneratedColumn<int> get ringDurationSeconds => $composableBuilder(
    column: $table.ringDurationSeconds,
    builder: (column) => column,
  );

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  GeneratedColumn<String> get simDisplayName => $composableBuilder(
    column: $table.simDisplayName,
    builder: (column) => column,
  );

  GeneratedColumn<int> get simSlot =>
      $composableBuilder(column: $table.simSlot, builder: (column) => column);

  GeneratedColumn<String> get cachedNumberType => $composableBuilder(
    column: $table.cachedNumberType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get cachedNumberLabel => $composableBuilder(
    column: $table.cachedNumberLabel,
    builder: (column) => column,
  );

  GeneratedColumn<int> get lastSyncAttemptMs => $composableBuilder(
    column: $table.lastSyncAttemptMs,
    builder: (column) => column,
  );

  GeneratedColumn<String> get syncError =>
      $composableBuilder(column: $table.syncError, builder: (column) => column);
}

class $$CallLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CallLogsTable,
          CallLog,
          $$CallLogsTableFilterComposer,
          $$CallLogsTableOrderingComposer,
          $$CallLogsTableAnnotationComposer,
          $$CallLogsTableCreateCompanionBuilder,
          $$CallLogsTableUpdateCompanionBuilder,
          (CallLog, BaseReferences<_$AppDatabase, $CallLogsTable, CallLog>),
          CallLog,
          PrefetchHooks Function()
        > {
  $$CallLogsTableTableManager(_$AppDatabase db, $CallLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CallLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CallLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CallLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> phoneNumber = const Value.absent(),
                Value<String?> contactName = const Value.absent(),
                Value<String?> contactPhotoUri = const Value.absent(),
                Value<String> callType = const Value.absent(),
                Value<int> timestampMs = const Value.absent(),
                Value<int> durationSeconds = const Value.absent(),
                Value<int> ringDurationSeconds = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<String?> simDisplayName = const Value.absent(),
                Value<int?> simSlot = const Value.absent(),
                Value<String?> cachedNumberType = const Value.absent(),
                Value<String?> cachedNumberLabel = const Value.absent(),
                Value<int?> lastSyncAttemptMs = const Value.absent(),
                Value<String?> syncError = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CallLogsCompanion(
                id: id,
                phoneNumber: phoneNumber,
                contactName: contactName,
                contactPhotoUri: contactPhotoUri,
                callType: callType,
                timestampMs: timestampMs,
                durationSeconds: durationSeconds,
                ringDurationSeconds: ringDurationSeconds,
                syncStatus: syncStatus,
                simDisplayName: simDisplayName,
                simSlot: simSlot,
                cachedNumberType: cachedNumberType,
                cachedNumberLabel: cachedNumberLabel,
                lastSyncAttemptMs: lastSyncAttemptMs,
                syncError: syncError,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String phoneNumber,
                Value<String?> contactName = const Value.absent(),
                Value<String?> contactPhotoUri = const Value.absent(),
                required String callType,
                required int timestampMs,
                Value<int> durationSeconds = const Value.absent(),
                Value<int> ringDurationSeconds = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<String?> simDisplayName = const Value.absent(),
                Value<int?> simSlot = const Value.absent(),
                Value<String?> cachedNumberType = const Value.absent(),
                Value<String?> cachedNumberLabel = const Value.absent(),
                Value<int?> lastSyncAttemptMs = const Value.absent(),
                Value<String?> syncError = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CallLogsCompanion.insert(
                id: id,
                phoneNumber: phoneNumber,
                contactName: contactName,
                contactPhotoUri: contactPhotoUri,
                callType: callType,
                timestampMs: timestampMs,
                durationSeconds: durationSeconds,
                ringDurationSeconds: ringDurationSeconds,
                syncStatus: syncStatus,
                simDisplayName: simDisplayName,
                simSlot: simSlot,
                cachedNumberType: cachedNumberType,
                cachedNumberLabel: cachedNumberLabel,
                lastSyncAttemptMs: lastSyncAttemptMs,
                syncError: syncError,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CallLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CallLogsTable,
      CallLog,
      $$CallLogsTableFilterComposer,
      $$CallLogsTableOrderingComposer,
      $$CallLogsTableAnnotationComposer,
      $$CallLogsTableCreateCompanionBuilder,
      $$CallLogsTableUpdateCompanionBuilder,
      (CallLog, BaseReferences<_$AppDatabase, $CallLogsTable, CallLog>),
      CallLog,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CallLogsTableTableManager get callLogs =>
      $$CallLogsTableTableManager(_db, _db.callLogs);
}
