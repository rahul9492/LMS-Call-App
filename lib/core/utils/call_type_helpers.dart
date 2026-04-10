import 'package:flutter/material.dart';

import '../../data/models/call_log_model.dart';
import '../theme/app_theme.dart';

/// Shared helpers for call type — colour, icon, label, initials.
/// Single source of truth used by call_log_tile, call_detail_screen, etc.
class CallTypeHelpers {
  CallTypeHelpers._();

  static Color colorForType(CallTypeEnum type) {
    switch (type) {
      case CallTypeEnum.incoming:
        return AppColors.incoming;
      case CallTypeEnum.outgoing:
        return AppColors.outgoing;
      case CallTypeEnum.missed:
        return AppColors.missed;
      case CallTypeEnum.rejected:
        return AppColors.rejected;
      default:
        return AppColors.textSecondary;
    }
  }

  static IconData iconForType(CallTypeEnum type) {
    switch (type) {
      case CallTypeEnum.incoming:
        return Icons.call_received_rounded;
      case CallTypeEnum.outgoing:
        return Icons.call_made_rounded;
      case CallTypeEnum.missed:
        return Icons.call_missed_rounded;
      case CallTypeEnum.rejected:
        return Icons.call_end_rounded;
      default:
        return Icons.phone_rounded;
    }
  }

  static String labelForType(CallTypeEnum type) {
    switch (type) {
      case CallTypeEnum.incoming:
        return 'Incoming';
      case CallTypeEnum.outgoing:
        return 'Outgoing';
      case CallTypeEnum.missed:
        return 'Missed';
      case CallTypeEnum.rejected:
        return 'Rejected';
      default:
        return 'Unknown';
    }
  }

  static String fullLabelForType(CallTypeEnum type) =>
      '${labelForType(type)} call';

  /// Returns 1–2 uppercase initials from [name].
  /// Handles empty strings, whitespace-only, and single characters safely.
  static String initials(String name) {
    final trimmed = name.trim();
    if (trimmed.isEmpty) return '?';
    final parts = trimmed.split(RegExp(r'\s+'));
    if (parts.length >= 2 &&
        parts[0].isNotEmpty &&
        parts[1].isNotEmpty) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    if (trimmed.length >= 2) return trimmed.substring(0, 2).toUpperCase();
    return trimmed.toUpperCase();
  }
}
