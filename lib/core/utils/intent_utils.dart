import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
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

  /// Opens the Android "Add Contact" screen pre-filled with [phoneNumber]
  /// and optionally [name]. Uses flutter_contacts to launch the native
  /// contacts insert UI.
  static Future<void> launchAddContact(
      BuildContext context, String phoneNumber, {String? name}) async {
    try {
      final contact = Contact()
        ..phones = [Phone(phoneNumber)];
      if (name != null && name.trim().isNotEmpty) {
        final parts = name.trim().split(' ');
        contact.name.first = parts.first;
        if (parts.length > 1) {
          contact.name.last = parts.skip(1).join(' ');
        }
      }
      await FlutterContacts.openExternalInsert(contact);
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not open contacts')),
        );
      }
    }
  }
}
