import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_model.freezed.dart';
part 'auth_model.g.dart';

@freezed
abstract class AuthUser with _$AuthUser {
  const factory AuthUser({
    required String userId,
    required String mobileNumber,
    required String token,
  }) = _AuthUser;

  factory AuthUser.fromJson(Map<String, dynamic> json) =>
      _$AuthUserFromJson(json);
}
