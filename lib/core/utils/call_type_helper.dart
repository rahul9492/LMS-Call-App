import 'package:call_log/call_log.dart';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class CallTypeHelper {
  CallTypeHelper._();

  static Color colorFromType(CallType? type) {
    switch (type) {
      case CallType.incoming:
        return AppColors.incoming;
      case CallType.outgoing:
        return AppColors.outgoing;
      case CallType.missed:
        return AppColors.missed;
      case CallType.rejected:
        return AppColors.rejected;
      default:
        return AppColors.textSecondary;
    }
  }

  static IconData iconFromType(CallType? type) {
    switch (type) {
      case CallType.incoming:
        return Icons.call_received_rounded;
      case CallType.outgoing:
        return Icons.call_made_rounded;
      case CallType.missed:
        return Icons.call_missed_rounded;
      case CallType.rejected:
        return Icons.call_end_rounded;
      default:
        return Icons.phone_rounded;
    }
  }

  static String labelFromType(CallType? type) {
    switch (type) {
      case CallType.incoming:
        return 'Incoming';
      case CallType.outgoing:
        return 'Outgoing';
      case CallType.missed:
        return 'Missed';
      case CallType.rejected:
        return 'Rejected';
      default:
        return 'Unknown';
    }
  }

  static String typeToString(CallType? type) {
    switch (type) {
      case CallType.incoming:
        return 'incoming';
      case CallType.outgoing:
        return 'outgoing';
      case CallType.missed:
        return 'missed';
      case CallType.rejected:
        return 'rejected';
      default:
        return 'unknown';
    }
  }

  static CallType? typeFromString(String? value) {
    switch (value) {
      case 'incoming':
        return CallType.incoming;
      case 'outgoing':
        return CallType.outgoing;
      case 'missed':
        return CallType.missed;
      case 'rejected':
        return CallType.rejected;
      default:
        return null;
    }
  }
}
