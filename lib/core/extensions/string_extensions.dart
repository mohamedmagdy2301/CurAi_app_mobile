// ignore_for_file: lines_longer_than_80_chars, document_ignores

import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension StringExtension on String {
  /// Checks if the string is in Arabic format.
  bool get isArabicFormat {
    if (isEmpty) return false;
    // Check if the average character is Arabic
    final arabicCharCount = runes.where((rune) {
      final character = String.fromCharCode(rune);
      return RegExp(r'[\u0600-\u06FF]').hasMatch(character);
    }).length;
    final englishCharCount = runes.where((rune) {
      final character = String.fromCharCode(rune);
      return RegExp('[a-zA-Z]').hasMatch(character);
    }).length;
    return arabicCharCount > englishCharCount;
  }

  /// Capitalizes the first letter of each word in the string.
  ///
  /// Example:
  /// `"hello world"` → `"Hello World"`
  String get capitalizeFirstChar => trim()
      .split(' ')
      .where((word) => word.isNotEmpty)
      .map((word) => word[0].toUpperCase() + word.substring(1))
      .join(' ');

  /// Converts all words in the string to uppercase.
  ///
  /// Example:
  /// `"hello world"` → `"HELLO WORLD"`
  String get capitalizeWord =>
      split(' ').map((word) => word.toUpperCase()).join(' ');

  /// Converts date string to a readable format like "Nov 10, 2025" or "نوفمبر 10, 2025".
  String toReadableDate(BuildContext context) => _format('MMM d, y', context);

  /// Converts date string to a long format like "November 10, 2025" or "نوفمبر 10, 2025".
  String toFullMonthDate(BuildContext context) => _format('MMMM d, y', context);

  /// Converts date to a format like "10 Nov 2025" or "10 نوفمبر 2025".
  String toDayMonthYear(BuildContext context) => _format('d MMM y', context);

  /// Converts date to a format like "Monday, Nov 10, 2025" or "الاثنين، 10 نوفمبر 2025".
  String toFullWithWeekday(BuildContext context) =>
      _format('EEEE، d MMMM y', context);

  /// Converts date to a format like "Monday, Nov 10, 2025" or "الاثنين، 10 نوفمبر 2025".
  String toFullWithWeekdayTwoLine(BuildContext context) =>
      _format('EEEE\nd MMMM y', context);

  /// Converts date to ISO-like format "2025-11-10".
  String toIsoLikeDate(BuildContext context) => _format('y-MM-dd', context);

  /// Converts date to slashed format like "10/11/2025".
  String toSlashDate(BuildContext context) => _format('dd/MM/yyyy', context);

  /// Converts date + time to readable format like "10 Nov 2025 at 12:30 PM" or "10 نوفمبر 2025 في 12:30 م".
  String toDateWithTime12H(BuildContext context, {String time = '12:30'}) =>
      context.isStateArabic
          ? _formatWithTime("d MMM y 'في الساعة' h:mm a", time, context)
          : _formatWithTime("d MMM y 'at' h:mm a", time, context);

  /// Converts date + time to ISO-like 24-hour format "2025-11-10 14:00".
  String toIsoWithTime24H(BuildContext context, {String time = '14:00'}) =>
      _formatWithTime('y-MM-dd HH:mm', time, context);

  /// Converts to localized short format like "11/10/2025" or "١٠/١١/٢٠٢٥".
  String toLocalizedShort(BuildContext context) {
    final locale = context.isStateArabic ? 'ar' : 'en';
    return _formatLocalized(
      context: context,
      formatter: DateFormat.yMd(locale),
    );
  }

  /// Converts to localized full format like "Monday, November 10, 2025" or "الاثنين، 10 نوفمبر 2025".
  String toLocalizedFull(BuildContext context) {
    final locale = context.isStateArabic ? 'ar' : 'en';
    return _formatLocalized(
      context: context,
      formatter: DateFormat.yMMMMEEEEd(locale),
    );
  }

  /// Converts a time string like "14:30" into localized format like "2:30 PM" or "٢:٣٠ م".
  ///
  /// Requires a [BuildContext] to determine the language (via context.isStateArabic).
  ///
  /// Returns an empty string if parsing fails.
  ///
  /// Example:
  /// ```dart
  /// final formatted = "14:30".toLocalizedTime(context); // ٢:٣٠ م or 2:30 PM
  /// ```
  String toLocalizedTime(BuildContext context, {bool? isTwoLine}) {
    // Split the string by ':' to handle hour, minute, and optional second
    final parts = split(':');

    // Ensure at least hour and minute are present
    if (parts.length < 2) return '';

    final hour = int.tryParse(parts[0]) ?? 0;
    final minute = int.tryParse(parts[1]) ?? 0;
    final second = (parts.length == 3)
        ? int.tryParse(parts[2]) ?? 0
        : 0; // Handle optional seconds

    // Get the current date and create a DateTime object with the provided time
    final now = DateTime.now();
    final dateTime =
        DateTime(now.year, now.month, now.day, hour, minute, second);

    // Determine the locale based on the context (Arabic or English)
    final locale = context.isStateArabic ? 'ar' : 'en';

    // Return the formatted time (e.g., "2:30 " or "٢:٣٠ م")
    return DateFormat(isTwoLine ?? false ? 'hh:mm\na' : 'hh:mm a', locale)
        .format(dateTime);
  }

  String toLocalizedTimeWordDay(BuildContext context, {bool? isTwoLine}) {
    // Split the string by ':' to handle hour, minute, and optional second
    final parts = split(':');

    // Ensure at least hour and minute are present
    if (parts.length < 2) return '';

    final hour = int.tryParse(parts[0]) ?? 0;
    final minute = int.tryParse(parts[1]) ?? 0;
    final second = (parts.length == 3) ? int.tryParse(parts[2]) ?? 0 : 0;

    // Get the current date and create a DateTime object with the provided time
    final now = DateTime.now();
    final dateTime =
        DateTime(now.year, now.month, now.day, hour, minute, second);

    // Determine the locale based on the context (Arabic or English)
    final isArabic = context.isStateArabic;
    final locale = isArabic ? 'ar' : 'en';

    // Format the time without the period (AM/PM)
    final timeFormat =
        DateFormat(isTwoLine ?? false ? 'h:mm' : 'hh:mm', locale);
    final formattedTime = timeFormat.format(dateTime);

    // Decide full period string
    final isAm = dateTime.hour < 12;
    final period =
        isArabic ? (isAm ? 'صباحًا' : 'مساءً') : (isAm ? 'Morning' : 'Night');

    return isTwoLine ?? false
        ? '$formattedTime\n$period'
        : '$formattedTime $period';
  }

  // ============== Helper Methods ============== //

  /// Tries to parse a string into a DateTime object using common formats.
  ///
  /// Supported input formats:
  /// - "dd-MM-yyyy"
  /// - "yyyy-MM-dd"
  /// - "MM/dd/yyyy"
  /// - "d/M/yyyy"
  DateTime? _tryParseDate() {
    // Handle common ISO format directly
    final parsedFromIso = DateTime.tryParse(this);
    if (parsedFromIso != null) return parsedFromIso;

    final formats = [
      'dd-MM-yyyy',
      'yyyy-MM-dd',
      'MM/dd/yyyy',
      'd/M/yyyy',
    ];

    for (final format in formats) {
      try {
        return DateFormat(format).parse(this);
      } on FormatException catch (_) {
        continue;
      } on Exception catch (_) {
        continue;
      }
    }

    return null;
  }

  /// Generic formatter helper based on output [pattern] and [context] flag.
  String _format(String pattern, BuildContext context) {
    final locale = context.isStateArabic ? 'ar' : 'en';
    final date = _tryParseDate();
    if (date == null) return this;
    return DateFormat(pattern, locale).format(date);
  }

  /// Formats date + time together using given [pattern], [time], and [context].
  ///
  /// Time must be in 24-hour format like `"14:00"`.
  String _formatWithTime(
    String pattern,
    String time,
    BuildContext context,
  ) {
    final locale = context.isStateArabic ? 'ar' : 'en';
    final date = _tryParseDate();
    if (date == null) return this;

    try {
      final full = '${DateFormat('yyyy-MM-dd').format(date)} $time';
      final parsed = DateFormat('yyyy-MM-dd HH:mm').parse(full);
      return DateFormat(pattern, locale).format(parsed);
    } on FormatException catch (_) {
      return this;
    } on Exception catch (_) {
      return this;
    }
  }

  /// Formats the parsed date using a [DateFormat] object (for full/short localization).
  String _formatLocalized({
    required BuildContext context,
    required DateFormat formatter,
  }) {
    final date = _tryParseDate();
    if (date == null) return this;
    return formatter.format(date);
  }

  /// Converts time string like "7:12 am", "12:22 PM", "7:12 ص", or "7:12 م"
  /// into a 24-hour format: "HH:mm:ss".
  ///
  /// Examples:
  /// `"7:12 am"` → `"07:12:00"`
  /// `"7:12 م"`  → `"19:12:00"`
  String to24HourTimeFormat() {
    final normalized = toLowerCase()
        .replaceAll('ص', 'am')
        .replaceAll('م', 'pm')
        .replaceAll('٫', ':') // for Arabic decimal separator if used
        .trim();

    final regex = RegExp(r'^(\d{1,2}):(\d{1,2})(?::(\d{1,2}))?\s*(am|pm)?$');
    final match = regex.firstMatch(normalized);
    if (match == null) return this;

    var hour = int.parse(match.group(1)!);
    final minute = int.parse(match.group(2)!);
    final second = match.group(3) != null ? int.parse(match.group(3)!) : 0;
    final period = match.group(4);

    if (period == 'pm' && hour != 12) {
      hour += 12;
    } else if (period == 'am' && hour == 12) {
      hour = 0;
    }

    final hh = hour.toString().padLeft(2, '0');
    final mm = minute.toString().padLeft(2, '0');
    final ss = second.toString().padLeft(2, '0');
    return '$hh:$mm:$ss';
  }

  /// Converts time string like "7:12 am", "12:22 PM", "7:12 ص", or "7:12 م"
  /// into a 12-hour format: "h:mm:ss a".
  ///
  /// Examples:
  /// `"7:12 am"` → `"7:12:00 AM"`
  /// `"7:12 م"`  → `"7:12:00 ص"`
  String to12HourTimeFormat() => to24HourTimeFormat().to12HourTimeFormat();
}
