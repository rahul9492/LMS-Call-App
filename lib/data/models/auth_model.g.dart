// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AuthUser _$AuthUserFromJson(Map<String, dynamic> json) => _AuthUser(
  userId: json['userId'] as String,
  mobileNumber: json['mobileNumber'] as String,
  token: json['token'] as String,
);

Map<String, dynamic> _$AuthUserToJson(_AuthUser instance) => <String, dynamic>{
  'userId': instance.userId,
  'mobileNumber': instance.mobileNumber,
  'token': instance.token,
};
