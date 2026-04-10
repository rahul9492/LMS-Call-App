// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'call_log_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CallLogModel {

 String get id; String get phoneNumber; String? get contactName; String? get contactPhotoUri; CallTypeEnum get callType; DateTime get timestamp;/// Total call duration in seconds (connected time)
 int get durationSeconds;/// How long the phone rang before answered/missed (seconds)
 int get ringDurationSeconds; SyncStatus get syncStatus; String? get simDisplayName; int? get simSlot; String? get cachedNumberType; String? get cachedNumberLabel; DateTime? get lastSyncAttempt; String? get syncError;
/// Create a copy of CallLogModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CallLogModelCopyWith<CallLogModel> get copyWith => _$CallLogModelCopyWithImpl<CallLogModel>(this as CallLogModel, _$identity);

  /// Serializes this CallLogModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CallLogModel&&(identical(other.id, id) || other.id == id)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.contactName, contactName) || other.contactName == contactName)&&(identical(other.contactPhotoUri, contactPhotoUri) || other.contactPhotoUri == contactPhotoUri)&&(identical(other.callType, callType) || other.callType == callType)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.durationSeconds, durationSeconds) || other.durationSeconds == durationSeconds)&&(identical(other.ringDurationSeconds, ringDurationSeconds) || other.ringDurationSeconds == ringDurationSeconds)&&(identical(other.syncStatus, syncStatus) || other.syncStatus == syncStatus)&&(identical(other.simDisplayName, simDisplayName) || other.simDisplayName == simDisplayName)&&(identical(other.simSlot, simSlot) || other.simSlot == simSlot)&&(identical(other.cachedNumberType, cachedNumberType) || other.cachedNumberType == cachedNumberType)&&(identical(other.cachedNumberLabel, cachedNumberLabel) || other.cachedNumberLabel == cachedNumberLabel)&&(identical(other.lastSyncAttempt, lastSyncAttempt) || other.lastSyncAttempt == lastSyncAttempt)&&(identical(other.syncError, syncError) || other.syncError == syncError));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,phoneNumber,contactName,contactPhotoUri,callType,timestamp,durationSeconds,ringDurationSeconds,syncStatus,simDisplayName,simSlot,cachedNumberType,cachedNumberLabel,lastSyncAttempt,syncError);

@override
String toString() {
  return 'CallLogModel(id: $id, phoneNumber: $phoneNumber, contactName: $contactName, contactPhotoUri: $contactPhotoUri, callType: $callType, timestamp: $timestamp, durationSeconds: $durationSeconds, ringDurationSeconds: $ringDurationSeconds, syncStatus: $syncStatus, simDisplayName: $simDisplayName, simSlot: $simSlot, cachedNumberType: $cachedNumberType, cachedNumberLabel: $cachedNumberLabel, lastSyncAttempt: $lastSyncAttempt, syncError: $syncError)';
}


}

/// @nodoc
abstract mixin class $CallLogModelCopyWith<$Res>  {
  factory $CallLogModelCopyWith(CallLogModel value, $Res Function(CallLogModel) _then) = _$CallLogModelCopyWithImpl;
@useResult
$Res call({
 String id, String phoneNumber, String? contactName, String? contactPhotoUri, CallTypeEnum callType, DateTime timestamp, int durationSeconds, int ringDurationSeconds, SyncStatus syncStatus, String? simDisplayName, int? simSlot, String? cachedNumberType, String? cachedNumberLabel, DateTime? lastSyncAttempt, String? syncError
});




}
/// @nodoc
class _$CallLogModelCopyWithImpl<$Res>
    implements $CallLogModelCopyWith<$Res> {
  _$CallLogModelCopyWithImpl(this._self, this._then);

  final CallLogModel _self;
  final $Res Function(CallLogModel) _then;

/// Create a copy of CallLogModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? phoneNumber = null,Object? contactName = freezed,Object? contactPhotoUri = freezed,Object? callType = null,Object? timestamp = null,Object? durationSeconds = null,Object? ringDurationSeconds = null,Object? syncStatus = null,Object? simDisplayName = freezed,Object? simSlot = freezed,Object? cachedNumberType = freezed,Object? cachedNumberLabel = freezed,Object? lastSyncAttempt = freezed,Object? syncError = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,contactName: freezed == contactName ? _self.contactName : contactName // ignore: cast_nullable_to_non_nullable
as String?,contactPhotoUri: freezed == contactPhotoUri ? _self.contactPhotoUri : contactPhotoUri // ignore: cast_nullable_to_non_nullable
as String?,callType: null == callType ? _self.callType : callType // ignore: cast_nullable_to_non_nullable
as CallTypeEnum,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,durationSeconds: null == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as int,ringDurationSeconds: null == ringDurationSeconds ? _self.ringDurationSeconds : ringDurationSeconds // ignore: cast_nullable_to_non_nullable
as int,syncStatus: null == syncStatus ? _self.syncStatus : syncStatus // ignore: cast_nullable_to_non_nullable
as SyncStatus,simDisplayName: freezed == simDisplayName ? _self.simDisplayName : simDisplayName // ignore: cast_nullable_to_non_nullable
as String?,simSlot: freezed == simSlot ? _self.simSlot : simSlot // ignore: cast_nullable_to_non_nullable
as int?,cachedNumberType: freezed == cachedNumberType ? _self.cachedNumberType : cachedNumberType // ignore: cast_nullable_to_non_nullable
as String?,cachedNumberLabel: freezed == cachedNumberLabel ? _self.cachedNumberLabel : cachedNumberLabel // ignore: cast_nullable_to_non_nullable
as String?,lastSyncAttempt: freezed == lastSyncAttempt ? _self.lastSyncAttempt : lastSyncAttempt // ignore: cast_nullable_to_non_nullable
as DateTime?,syncError: freezed == syncError ? _self.syncError : syncError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CallLogModel].
extension CallLogModelPatterns on CallLogModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CallLogModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CallLogModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CallLogModel value)  $default,){
final _that = this;
switch (_that) {
case _CallLogModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CallLogModel value)?  $default,){
final _that = this;
switch (_that) {
case _CallLogModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String phoneNumber,  String? contactName,  String? contactPhotoUri,  CallTypeEnum callType,  DateTime timestamp,  int durationSeconds,  int ringDurationSeconds,  SyncStatus syncStatus,  String? simDisplayName,  int? simSlot,  String? cachedNumberType,  String? cachedNumberLabel,  DateTime? lastSyncAttempt,  String? syncError)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CallLogModel() when $default != null:
return $default(_that.id,_that.phoneNumber,_that.contactName,_that.contactPhotoUri,_that.callType,_that.timestamp,_that.durationSeconds,_that.ringDurationSeconds,_that.syncStatus,_that.simDisplayName,_that.simSlot,_that.cachedNumberType,_that.cachedNumberLabel,_that.lastSyncAttempt,_that.syncError);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String phoneNumber,  String? contactName,  String? contactPhotoUri,  CallTypeEnum callType,  DateTime timestamp,  int durationSeconds,  int ringDurationSeconds,  SyncStatus syncStatus,  String? simDisplayName,  int? simSlot,  String? cachedNumberType,  String? cachedNumberLabel,  DateTime? lastSyncAttempt,  String? syncError)  $default,) {final _that = this;
switch (_that) {
case _CallLogModel():
return $default(_that.id,_that.phoneNumber,_that.contactName,_that.contactPhotoUri,_that.callType,_that.timestamp,_that.durationSeconds,_that.ringDurationSeconds,_that.syncStatus,_that.simDisplayName,_that.simSlot,_that.cachedNumberType,_that.cachedNumberLabel,_that.lastSyncAttempt,_that.syncError);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String phoneNumber,  String? contactName,  String? contactPhotoUri,  CallTypeEnum callType,  DateTime timestamp,  int durationSeconds,  int ringDurationSeconds,  SyncStatus syncStatus,  String? simDisplayName,  int? simSlot,  String? cachedNumberType,  String? cachedNumberLabel,  DateTime? lastSyncAttempt,  String? syncError)?  $default,) {final _that = this;
switch (_that) {
case _CallLogModel() when $default != null:
return $default(_that.id,_that.phoneNumber,_that.contactName,_that.contactPhotoUri,_that.callType,_that.timestamp,_that.durationSeconds,_that.ringDurationSeconds,_that.syncStatus,_that.simDisplayName,_that.simSlot,_that.cachedNumberType,_that.cachedNumberLabel,_that.lastSyncAttempt,_that.syncError);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CallLogModel implements CallLogModel {
  const _CallLogModel({required this.id, required this.phoneNumber, this.contactName, this.contactPhotoUri, required this.callType, required this.timestamp, required this.durationSeconds, required this.ringDurationSeconds, required this.syncStatus, this.simDisplayName, this.simSlot, this.cachedNumberType, this.cachedNumberLabel, this.lastSyncAttempt, this.syncError});
  factory _CallLogModel.fromJson(Map<String, dynamic> json) => _$CallLogModelFromJson(json);

@override final  String id;
@override final  String phoneNumber;
@override final  String? contactName;
@override final  String? contactPhotoUri;
@override final  CallTypeEnum callType;
@override final  DateTime timestamp;
/// Total call duration in seconds (connected time)
@override final  int durationSeconds;
/// How long the phone rang before answered/missed (seconds)
@override final  int ringDurationSeconds;
@override final  SyncStatus syncStatus;
@override final  String? simDisplayName;
@override final  int? simSlot;
@override final  String? cachedNumberType;
@override final  String? cachedNumberLabel;
@override final  DateTime? lastSyncAttempt;
@override final  String? syncError;

/// Create a copy of CallLogModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CallLogModelCopyWith<_CallLogModel> get copyWith => __$CallLogModelCopyWithImpl<_CallLogModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CallLogModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CallLogModel&&(identical(other.id, id) || other.id == id)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.contactName, contactName) || other.contactName == contactName)&&(identical(other.contactPhotoUri, contactPhotoUri) || other.contactPhotoUri == contactPhotoUri)&&(identical(other.callType, callType) || other.callType == callType)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.durationSeconds, durationSeconds) || other.durationSeconds == durationSeconds)&&(identical(other.ringDurationSeconds, ringDurationSeconds) || other.ringDurationSeconds == ringDurationSeconds)&&(identical(other.syncStatus, syncStatus) || other.syncStatus == syncStatus)&&(identical(other.simDisplayName, simDisplayName) || other.simDisplayName == simDisplayName)&&(identical(other.simSlot, simSlot) || other.simSlot == simSlot)&&(identical(other.cachedNumberType, cachedNumberType) || other.cachedNumberType == cachedNumberType)&&(identical(other.cachedNumberLabel, cachedNumberLabel) || other.cachedNumberLabel == cachedNumberLabel)&&(identical(other.lastSyncAttempt, lastSyncAttempt) || other.lastSyncAttempt == lastSyncAttempt)&&(identical(other.syncError, syncError) || other.syncError == syncError));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,phoneNumber,contactName,contactPhotoUri,callType,timestamp,durationSeconds,ringDurationSeconds,syncStatus,simDisplayName,simSlot,cachedNumberType,cachedNumberLabel,lastSyncAttempt,syncError);

@override
String toString() {
  return 'CallLogModel(id: $id, phoneNumber: $phoneNumber, contactName: $contactName, contactPhotoUri: $contactPhotoUri, callType: $callType, timestamp: $timestamp, durationSeconds: $durationSeconds, ringDurationSeconds: $ringDurationSeconds, syncStatus: $syncStatus, simDisplayName: $simDisplayName, simSlot: $simSlot, cachedNumberType: $cachedNumberType, cachedNumberLabel: $cachedNumberLabel, lastSyncAttempt: $lastSyncAttempt, syncError: $syncError)';
}


}

/// @nodoc
abstract mixin class _$CallLogModelCopyWith<$Res> implements $CallLogModelCopyWith<$Res> {
  factory _$CallLogModelCopyWith(_CallLogModel value, $Res Function(_CallLogModel) _then) = __$CallLogModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String phoneNumber, String? contactName, String? contactPhotoUri, CallTypeEnum callType, DateTime timestamp, int durationSeconds, int ringDurationSeconds, SyncStatus syncStatus, String? simDisplayName, int? simSlot, String? cachedNumberType, String? cachedNumberLabel, DateTime? lastSyncAttempt, String? syncError
});




}
/// @nodoc
class __$CallLogModelCopyWithImpl<$Res>
    implements _$CallLogModelCopyWith<$Res> {
  __$CallLogModelCopyWithImpl(this._self, this._then);

  final _CallLogModel _self;
  final $Res Function(_CallLogModel) _then;

/// Create a copy of CallLogModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? phoneNumber = null,Object? contactName = freezed,Object? contactPhotoUri = freezed,Object? callType = null,Object? timestamp = null,Object? durationSeconds = null,Object? ringDurationSeconds = null,Object? syncStatus = null,Object? simDisplayName = freezed,Object? simSlot = freezed,Object? cachedNumberType = freezed,Object? cachedNumberLabel = freezed,Object? lastSyncAttempt = freezed,Object? syncError = freezed,}) {
  return _then(_CallLogModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,contactName: freezed == contactName ? _self.contactName : contactName // ignore: cast_nullable_to_non_nullable
as String?,contactPhotoUri: freezed == contactPhotoUri ? _self.contactPhotoUri : contactPhotoUri // ignore: cast_nullable_to_non_nullable
as String?,callType: null == callType ? _self.callType : callType // ignore: cast_nullable_to_non_nullable
as CallTypeEnum,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,durationSeconds: null == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as int,ringDurationSeconds: null == ringDurationSeconds ? _self.ringDurationSeconds : ringDurationSeconds // ignore: cast_nullable_to_non_nullable
as int,syncStatus: null == syncStatus ? _self.syncStatus : syncStatus // ignore: cast_nullable_to_non_nullable
as SyncStatus,simDisplayName: freezed == simDisplayName ? _self.simDisplayName : simDisplayName // ignore: cast_nullable_to_non_nullable
as String?,simSlot: freezed == simSlot ? _self.simSlot : simSlot // ignore: cast_nullable_to_non_nullable
as int?,cachedNumberType: freezed == cachedNumberType ? _self.cachedNumberType : cachedNumberType // ignore: cast_nullable_to_non_nullable
as String?,cachedNumberLabel: freezed == cachedNumberLabel ? _self.cachedNumberLabel : cachedNumberLabel // ignore: cast_nullable_to_non_nullable
as String?,lastSyncAttempt: freezed == lastSyncAttempt ? _self.lastSyncAttempt : lastSyncAttempt // ignore: cast_nullable_to_non_nullable
as DateTime?,syncError: freezed == syncError ? _self.syncError : syncError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$CallLogGroup {

 String get phoneNumber; String? get contactName; String? get contactPhotoUri; List<CallLogModel> get calls; DateTime get lastCallTime; CallTypeEnum get lastCallType;
/// Create a copy of CallLogGroup
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CallLogGroupCopyWith<CallLogGroup> get copyWith => _$CallLogGroupCopyWithImpl<CallLogGroup>(this as CallLogGroup, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CallLogGroup&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.contactName, contactName) || other.contactName == contactName)&&(identical(other.contactPhotoUri, contactPhotoUri) || other.contactPhotoUri == contactPhotoUri)&&const DeepCollectionEquality().equals(other.calls, calls)&&(identical(other.lastCallTime, lastCallTime) || other.lastCallTime == lastCallTime)&&(identical(other.lastCallType, lastCallType) || other.lastCallType == lastCallType));
}


@override
int get hashCode => Object.hash(runtimeType,phoneNumber,contactName,contactPhotoUri,const DeepCollectionEquality().hash(calls),lastCallTime,lastCallType);

@override
String toString() {
  return 'CallLogGroup(phoneNumber: $phoneNumber, contactName: $contactName, contactPhotoUri: $contactPhotoUri, calls: $calls, lastCallTime: $lastCallTime, lastCallType: $lastCallType)';
}


}

/// @nodoc
abstract mixin class $CallLogGroupCopyWith<$Res>  {
  factory $CallLogGroupCopyWith(CallLogGroup value, $Res Function(CallLogGroup) _then) = _$CallLogGroupCopyWithImpl;
@useResult
$Res call({
 String phoneNumber, String? contactName, String? contactPhotoUri, List<CallLogModel> calls, DateTime lastCallTime, CallTypeEnum lastCallType
});




}
/// @nodoc
class _$CallLogGroupCopyWithImpl<$Res>
    implements $CallLogGroupCopyWith<$Res> {
  _$CallLogGroupCopyWithImpl(this._self, this._then);

  final CallLogGroup _self;
  final $Res Function(CallLogGroup) _then;

/// Create a copy of CallLogGroup
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? phoneNumber = null,Object? contactName = freezed,Object? contactPhotoUri = freezed,Object? calls = null,Object? lastCallTime = null,Object? lastCallType = null,}) {
  return _then(_self.copyWith(
phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,contactName: freezed == contactName ? _self.contactName : contactName // ignore: cast_nullable_to_non_nullable
as String?,contactPhotoUri: freezed == contactPhotoUri ? _self.contactPhotoUri : contactPhotoUri // ignore: cast_nullable_to_non_nullable
as String?,calls: null == calls ? _self.calls : calls // ignore: cast_nullable_to_non_nullable
as List<CallLogModel>,lastCallTime: null == lastCallTime ? _self.lastCallTime : lastCallTime // ignore: cast_nullable_to_non_nullable
as DateTime,lastCallType: null == lastCallType ? _self.lastCallType : lastCallType // ignore: cast_nullable_to_non_nullable
as CallTypeEnum,
  ));
}

}


/// Adds pattern-matching-related methods to [CallLogGroup].
extension CallLogGroupPatterns on CallLogGroup {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CallLogGroup value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CallLogGroup() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CallLogGroup value)  $default,){
final _that = this;
switch (_that) {
case _CallLogGroup():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CallLogGroup value)?  $default,){
final _that = this;
switch (_that) {
case _CallLogGroup() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String phoneNumber,  String? contactName,  String? contactPhotoUri,  List<CallLogModel> calls,  DateTime lastCallTime,  CallTypeEnum lastCallType)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CallLogGroup() when $default != null:
return $default(_that.phoneNumber,_that.contactName,_that.contactPhotoUri,_that.calls,_that.lastCallTime,_that.lastCallType);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String phoneNumber,  String? contactName,  String? contactPhotoUri,  List<CallLogModel> calls,  DateTime lastCallTime,  CallTypeEnum lastCallType)  $default,) {final _that = this;
switch (_that) {
case _CallLogGroup():
return $default(_that.phoneNumber,_that.contactName,_that.contactPhotoUri,_that.calls,_that.lastCallTime,_that.lastCallType);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String phoneNumber,  String? contactName,  String? contactPhotoUri,  List<CallLogModel> calls,  DateTime lastCallTime,  CallTypeEnum lastCallType)?  $default,) {final _that = this;
switch (_that) {
case _CallLogGroup() when $default != null:
return $default(_that.phoneNumber,_that.contactName,_that.contactPhotoUri,_that.calls,_that.lastCallTime,_that.lastCallType);case _:
  return null;

}
}

}

/// @nodoc


class _CallLogGroup extends CallLogGroup {
  const _CallLogGroup({required this.phoneNumber, this.contactName, this.contactPhotoUri, required final  List<CallLogModel> calls, required this.lastCallTime, required this.lastCallType}): _calls = calls,super._();
  

@override final  String phoneNumber;
@override final  String? contactName;
@override final  String? contactPhotoUri;
 final  List<CallLogModel> _calls;
@override List<CallLogModel> get calls {
  if (_calls is EqualUnmodifiableListView) return _calls;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_calls);
}

@override final  DateTime lastCallTime;
@override final  CallTypeEnum lastCallType;

/// Create a copy of CallLogGroup
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CallLogGroupCopyWith<_CallLogGroup> get copyWith => __$CallLogGroupCopyWithImpl<_CallLogGroup>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CallLogGroup&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.contactName, contactName) || other.contactName == contactName)&&(identical(other.contactPhotoUri, contactPhotoUri) || other.contactPhotoUri == contactPhotoUri)&&const DeepCollectionEquality().equals(other._calls, _calls)&&(identical(other.lastCallTime, lastCallTime) || other.lastCallTime == lastCallTime)&&(identical(other.lastCallType, lastCallType) || other.lastCallType == lastCallType));
}


@override
int get hashCode => Object.hash(runtimeType,phoneNumber,contactName,contactPhotoUri,const DeepCollectionEquality().hash(_calls),lastCallTime,lastCallType);

@override
String toString() {
  return 'CallLogGroup(phoneNumber: $phoneNumber, contactName: $contactName, contactPhotoUri: $contactPhotoUri, calls: $calls, lastCallTime: $lastCallTime, lastCallType: $lastCallType)';
}


}

/// @nodoc
abstract mixin class _$CallLogGroupCopyWith<$Res> implements $CallLogGroupCopyWith<$Res> {
  factory _$CallLogGroupCopyWith(_CallLogGroup value, $Res Function(_CallLogGroup) _then) = __$CallLogGroupCopyWithImpl;
@override @useResult
$Res call({
 String phoneNumber, String? contactName, String? contactPhotoUri, List<CallLogModel> calls, DateTime lastCallTime, CallTypeEnum lastCallType
});




}
/// @nodoc
class __$CallLogGroupCopyWithImpl<$Res>
    implements _$CallLogGroupCopyWith<$Res> {
  __$CallLogGroupCopyWithImpl(this._self, this._then);

  final _CallLogGroup _self;
  final $Res Function(_CallLogGroup) _then;

/// Create a copy of CallLogGroup
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? phoneNumber = null,Object? contactName = freezed,Object? contactPhotoUri = freezed,Object? calls = null,Object? lastCallTime = null,Object? lastCallType = null,}) {
  return _then(_CallLogGroup(
phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,contactName: freezed == contactName ? _self.contactName : contactName // ignore: cast_nullable_to_non_nullable
as String?,contactPhotoUri: freezed == contactPhotoUri ? _self.contactPhotoUri : contactPhotoUri // ignore: cast_nullable_to_non_nullable
as String?,calls: null == calls ? _self._calls : calls // ignore: cast_nullable_to_non_nullable
as List<CallLogModel>,lastCallTime: null == lastCallTime ? _self.lastCallTime : lastCallTime // ignore: cast_nullable_to_non_nullable
as DateTime,lastCallType: null == lastCallType ? _self.lastCallType : lastCallType // ignore: cast_nullable_to_non_nullable
as CallTypeEnum,
  ));
}


}

/// @nodoc
mixin _$SyncSummary {

 int get totalPending; int get totalSynced; int get totalFailed; DateTime? get lastSyncTime;
/// Create a copy of SyncSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SyncSummaryCopyWith<SyncSummary> get copyWith => _$SyncSummaryCopyWithImpl<SyncSummary>(this as SyncSummary, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SyncSummary&&(identical(other.totalPending, totalPending) || other.totalPending == totalPending)&&(identical(other.totalSynced, totalSynced) || other.totalSynced == totalSynced)&&(identical(other.totalFailed, totalFailed) || other.totalFailed == totalFailed)&&(identical(other.lastSyncTime, lastSyncTime) || other.lastSyncTime == lastSyncTime));
}


@override
int get hashCode => Object.hash(runtimeType,totalPending,totalSynced,totalFailed,lastSyncTime);

@override
String toString() {
  return 'SyncSummary(totalPending: $totalPending, totalSynced: $totalSynced, totalFailed: $totalFailed, lastSyncTime: $lastSyncTime)';
}


}

/// @nodoc
abstract mixin class $SyncSummaryCopyWith<$Res>  {
  factory $SyncSummaryCopyWith(SyncSummary value, $Res Function(SyncSummary) _then) = _$SyncSummaryCopyWithImpl;
@useResult
$Res call({
 int totalPending, int totalSynced, int totalFailed, DateTime? lastSyncTime
});




}
/// @nodoc
class _$SyncSummaryCopyWithImpl<$Res>
    implements $SyncSummaryCopyWith<$Res> {
  _$SyncSummaryCopyWithImpl(this._self, this._then);

  final SyncSummary _self;
  final $Res Function(SyncSummary) _then;

/// Create a copy of SyncSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalPending = null,Object? totalSynced = null,Object? totalFailed = null,Object? lastSyncTime = freezed,}) {
  return _then(_self.copyWith(
totalPending: null == totalPending ? _self.totalPending : totalPending // ignore: cast_nullable_to_non_nullable
as int,totalSynced: null == totalSynced ? _self.totalSynced : totalSynced // ignore: cast_nullable_to_non_nullable
as int,totalFailed: null == totalFailed ? _self.totalFailed : totalFailed // ignore: cast_nullable_to_non_nullable
as int,lastSyncTime: freezed == lastSyncTime ? _self.lastSyncTime : lastSyncTime // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [SyncSummary].
extension SyncSummaryPatterns on SyncSummary {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SyncSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SyncSummary() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SyncSummary value)  $default,){
final _that = this;
switch (_that) {
case _SyncSummary():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SyncSummary value)?  $default,){
final _that = this;
switch (_that) {
case _SyncSummary() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int totalPending,  int totalSynced,  int totalFailed,  DateTime? lastSyncTime)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SyncSummary() when $default != null:
return $default(_that.totalPending,_that.totalSynced,_that.totalFailed,_that.lastSyncTime);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int totalPending,  int totalSynced,  int totalFailed,  DateTime? lastSyncTime)  $default,) {final _that = this;
switch (_that) {
case _SyncSummary():
return $default(_that.totalPending,_that.totalSynced,_that.totalFailed,_that.lastSyncTime);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int totalPending,  int totalSynced,  int totalFailed,  DateTime? lastSyncTime)?  $default,) {final _that = this;
switch (_that) {
case _SyncSummary() when $default != null:
return $default(_that.totalPending,_that.totalSynced,_that.totalFailed,_that.lastSyncTime);case _:
  return null;

}
}

}

/// @nodoc


class _SyncSummary extends SyncSummary {
  const _SyncSummary({required this.totalPending, required this.totalSynced, required this.totalFailed, this.lastSyncTime}): super._();
  

@override final  int totalPending;
@override final  int totalSynced;
@override final  int totalFailed;
@override final  DateTime? lastSyncTime;

/// Create a copy of SyncSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SyncSummaryCopyWith<_SyncSummary> get copyWith => __$SyncSummaryCopyWithImpl<_SyncSummary>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SyncSummary&&(identical(other.totalPending, totalPending) || other.totalPending == totalPending)&&(identical(other.totalSynced, totalSynced) || other.totalSynced == totalSynced)&&(identical(other.totalFailed, totalFailed) || other.totalFailed == totalFailed)&&(identical(other.lastSyncTime, lastSyncTime) || other.lastSyncTime == lastSyncTime));
}


@override
int get hashCode => Object.hash(runtimeType,totalPending,totalSynced,totalFailed,lastSyncTime);

@override
String toString() {
  return 'SyncSummary(totalPending: $totalPending, totalSynced: $totalSynced, totalFailed: $totalFailed, lastSyncTime: $lastSyncTime)';
}


}

/// @nodoc
abstract mixin class _$SyncSummaryCopyWith<$Res> implements $SyncSummaryCopyWith<$Res> {
  factory _$SyncSummaryCopyWith(_SyncSummary value, $Res Function(_SyncSummary) _then) = __$SyncSummaryCopyWithImpl;
@override @useResult
$Res call({
 int totalPending, int totalSynced, int totalFailed, DateTime? lastSyncTime
});




}
/// @nodoc
class __$SyncSummaryCopyWithImpl<$Res>
    implements _$SyncSummaryCopyWith<$Res> {
  __$SyncSummaryCopyWithImpl(this._self, this._then);

  final _SyncSummary _self;
  final $Res Function(_SyncSummary) _then;

/// Create a copy of SyncSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalPending = null,Object? totalSynced = null,Object? totalFailed = null,Object? lastSyncTime = freezed,}) {
  return _then(_SyncSummary(
totalPending: null == totalPending ? _self.totalPending : totalPending // ignore: cast_nullable_to_non_nullable
as int,totalSynced: null == totalSynced ? _self.totalSynced : totalSynced // ignore: cast_nullable_to_non_nullable
as int,totalFailed: null == totalFailed ? _self.totalFailed : totalFailed // ignore: cast_nullable_to_non_nullable
as int,lastSyncTime: freezed == lastSyncTime ? _self.lastSyncTime : lastSyncTime // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
