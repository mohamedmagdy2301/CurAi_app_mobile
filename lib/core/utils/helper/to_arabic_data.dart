import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/utils/helper/to_arabic_number.dart';
import 'package:flutter/cupertino.dart';

String toFormattedDate({required BuildContext context, required String date}) {
  if (date.isEmpty) {
    return context.isStateArabic ? 'تاريخ غير متوفر' : 'Date not available';
  }

  final dateTime = DateTime.parse(date);
  final formattedDate = '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  final arabicDate = formattedDate.replaceAllMapped(
    RegExp(r'\d'),
    (match) => toArabicNumber(match.group(0) ?? ''),
  );

  bool isSameDate(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final targetDate = DateTime(dateTime.year, dateTime.month, dateTime.day);

  if (isSameDate(targetDate, today)) {
    return context.isStateArabic ? 'اليوم' : 'Today';
  } else if (isSameDate(targetDate, today.subtract(const Duration(days: 1)))) {
    return context.isStateArabic ? 'أمس' : 'Yesterday';
  } else if (isSameDate(targetDate, today.add(const Duration(days: 1)))) {
    return context.isStateArabic ? 'غدًا' : 'Tomorrow';
  }

  return context.isStateArabic ? arabicDate : formattedDate;
}
