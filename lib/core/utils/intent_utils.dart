import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// Helpers for launching Android system intents.
class IntentUtils {
  IntentUtils._();

  /// Opens the phone dialer pre-filled with [phoneNumber].
  static Future<void> launchDialer(
      BuildContext context, String phoneNumber) async {
    final uri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not open dialer')),
        );
      }
    }
  }

  /// Opens the SMS app pre-filled with [phoneNumber].
  static Future<void> launchSms(
      BuildContext context, String phoneNumber) async {
    final uri = Uri(scheme: 'sms', path: phoneNumber);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not open SMS app')),
        );
      }
    }
  }

  /// Opens the Add Contact screen pre-filled with [phoneNumber].
  /// Uses a tel: URI which prompts "Add to contacts" on most Android ROMs.
  static Future<void> launchAddContact(
      BuildContext context, String phoneNumber) async {
    final telUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(telUri)) {
      await launchUrl(telUri, mode: LaunchMode.externalApplication);
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not open contacts')),
        );
      }
    }
  }
}
