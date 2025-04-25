import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Converts a given time string (e.g. "08:00") or a DateTime object
/// into a localized, human-readable time string (e.g. "08:00 AM" or "٠٨:٠٠ ص").
///
/// - If [time] is provided, it will be parsed as a time (hour:minute) and
///   combined with today's date to construct a full [DateTime] object.
/// - If [dateTime] is provided instead, it will be formatted directly.
/// - If context.isStateArabic is true, Arabic time format will be used.
/// - If neither [time] nor [dateTime] is provided, an empty string is returned.
///
/// Example usage:
/// ```dart
/// final timeStr = formattedTime(context, time: "14:30"); // ٢:٣٠ م
/// ```
String formattedTime(BuildContext context, {DateTime? dateTime, String? time}) {
  /// If time string is provided, convert it to DateTime using today's date.
  if (time != null) {
    final now = DateTime.now();
    final parts = time.split(':');
    if (parts.length == 2) {
      final hour = int.tryParse(parts[0]) ?? 0;
      final minute = int.tryParse(parts[1]) ?? 0;
      dateTime = DateTime(now.year, now.month, now.day, hour, minute);
    }
  }

  /// If we still don't have a valid dateTime, return empty string.
  if (dateTime == null) {
    return '';
  }

  /// Return the time in localized format (Arabic or English).
  return DateFormat('hh:mm a', context.isStateArabic ? 'ar' : 'en')
      .format(dateTime);
}
