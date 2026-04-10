import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// Manages local notifications for sync results.
class NotificationService {
  static final _plugin = FlutterLocalNotificationsPlugin();
  static bool _initialized = false;

  static const _channelId = 'lms_sync';
  static const _channelName = 'Sync Status';
  static const _channelDesc = 'Notifications for call log sync results';

  static Future<void> initialize() async {
    if (_initialized) return;
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const settings = InitializationSettings(android: android);
    await _plugin.initialize(settings);
    _initialized = true;
    debugPrint('[NotificationService] Initialized');
  }

  static Future<void> showSyncSuccess({
    required int uploaded,
    required int newFromDevice,
  }) async {
    await _ensureInit();
    final body = uploaded > 0
        ? '$uploaded log${uploaded == 1 ? '' : 's'} synced to server'
        : 'All logs are up to date';
    await _show(
      id: 1,
      title: 'Sync complete',
      body: body,
      icon: 'ic_launcher',
    );
  }

  static Future<void> showSyncFailure({required int failed}) async {
    await _ensureInit();
    await _show(
      id: 2,
      title: 'Sync failed',
      body: '$failed log${failed == 1 ? '' : 's'} failed to upload. Will retry automatically.',
      icon: 'ic_launcher',
    );
  }

  static Future<void> _show({
    required int id,
    required String title,
    required String body,
    required String icon,
  }) async {
    const details = NotificationDetails(
      android: AndroidNotificationDetails(
        _channelId,
        _channelName,
        channelDescription: _channelDesc,
        importance: Importance.defaultImportance,
        priority: Priority.defaultPriority,
        icon: '@mipmap/ic_launcher',
      ),
    );
    await _plugin.show(id, title, body, details);
  }

  static Future<void> _ensureInit() async {
    if (!_initialized) await initialize();
  }
}
