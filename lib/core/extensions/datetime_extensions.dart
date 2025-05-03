import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension TimeFormattingDateTimeExtension on DateTime {
  /// Formats the current DateTime into localized time like "8:00 AM" or "٨:٠٠ ص"
  ///
  /// Example:
  /// ```dart
  /// DateTime.now().toLocalizedTime(context);
  /// ```
  String toLocalizedTime(BuildContext context) {
    final locale = context.isStateArabic ? 'ar' : 'en';
    return DateFormat('hh:mm a', locale).format(this);
  }
}
