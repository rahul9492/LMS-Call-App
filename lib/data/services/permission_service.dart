import 'package:permission_handler/permission_handler.dart';

enum AppPermission { phone, callLog, contacts }

class PermissionService {
  /// Request all permissions the app needs, in order.
  Future<Map<AppPermission, PermissionStatus>> requestAllPermissions() async {
    final statuses = await [
      Permission.phone,
      Permission.contacts,
    ].request();

    // READ_CALL_LOG is a separate, more sensitive permission on Android 9+
    final callLogStatus = await Permission.phone.request();

    return {
      AppPermission.phone: statuses[Permission.phone] ?? PermissionStatus.denied,
      AppPermission.callLog: callLogStatus,
      AppPermission.contacts: statuses[Permission.contacts] ?? PermissionStatus.denied,
    };
  }

  Future<PermissionStatus> checkCallLogPermission() =>
      Permission.phone.status;

  Future<PermissionStatus> checkContactsPermission() =>
      Permission.contacts.status;

  Future<bool> get hasCallLogAccess async =>
      (await Permission.phone.status).isGranted;

  Future<bool> get hasContactsAccess async =>
      (await Permission.contacts.status).isGranted;

  Future<PermissionStatus> requestCallLog() => Permission.phone.request();

  Future<PermissionStatus> requestContacts() => Permission.contacts.request();

  Future<void> openSettings() => openAppSettings();
}
