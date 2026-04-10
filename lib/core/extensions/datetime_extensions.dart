import 'package:intl/intl.dart';

extension DateTimeExtensions on DateTime {
  String get timeFormatted => DateFormat.jm().format(this);

  String get dateFormatted => DateFormat('MMM d, yyyy').format(this);

  String get dateShort => DateFormat('MMM d').format(this);

  String get dateTimeFormatted => DateFormat('MMM d, yyyy • h:mm a').format(this);

  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return year == yesterday.year && month == yesterday.month && day == yesterday.day;
  }

  bool get isThisWeek {
    final now = DateTime.now();
    final weekStart = now.subtract(Duration(days: now.weekday - 1));
    return isAfter(weekStart.subtract(const Duration(seconds: 1)));
  }

  String get relativeLabel {
    if (isToday) return 'Today';
    if (isYesterday) return 'Yesterday';
    return dateFormatted;
  }
}

extension DurationExtensions on Duration {
  String get callDurationFormatted {
    if (inSeconds == 0) return '0s';
    if (inSeconds < 60) return '${inSeconds}s';
    final minutes = inMinutes;
    final seconds = inSeconds % 60;
    if (seconds == 0) return '${minutes}m';
    return '${minutes}m ${seconds}s';
  }

  String get ringDurationFormatted {
    if (inSeconds == 0) return 'Instant';
    return 'Rang for ${inSeconds}s';
  }
}

extension IntDurationExtension on int {
  /// Converts seconds to formatted duration string
  String get secondsToCallDuration => Duration(seconds: this).callDurationFormatted;

  /// Ring duration label
  String get secondsToRingDuration => Duration(seconds: this).ringDurationFormatted;
}
