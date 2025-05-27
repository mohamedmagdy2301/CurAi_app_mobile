import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension TimeFormattingDateTimeExtension on DateTime {
  DateTime get now => DateTime.now();

  ///Formats the current DateTime into localized time like "8:00 AM"or"٨:٠٠ ص"
  String toLocalizedTime(BuildContext context) {
    final locale = context.isStateArabic ? 'ar' : 'en';
    return DateFormat('hh:mm a', locale).format(this);
  }

  /// Formats the current DateTime into a localized date string
  ///  like " 1, Jan 8:00 AM" or "١، يناير ٨:٠٠ ص"
  String toLocalizedDateTime(BuildContext context) {
    final locale = context.isStateArabic ? 'ar' : 'en';
    return DateFormat('d, MMM  h:mm a', locale).format(this);
  }

  /// Checks if the current DateTime is today
  bool get isToday {
    return year == now.year && month == now.month && day == now.day;
  }

  /// Checks if the current DateTime is yesterday
  bool get isYesterday {
    final yesterday = now.subtract(const Duration(days: 1));
    return year == yesterday.year &&
        month == yesterday.month &&
        day == yesterday.day;
  }

  /// is the current DateTime is now
  bool get isNow {
    return year == now.year &&
        month == now.month &&
        day == now.day &&
        hour == now.hour &&
        minute == now.minute;
  }
}
