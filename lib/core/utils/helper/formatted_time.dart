import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String formattedTime(BuildContext context, {DateTime? dateTime, String? time}) {
  if (time != null) {
    dateTime = DateTime.parse(time);
  }
  if (dateTime == null) {
    return '';
  }
  if (context.isStateArabic) {
    return DateFormat('hh:mm a', 'ar').format(dateTime);
  } else {
    return DateFormat('hh:mm a').format(dateTime);
  }
}
