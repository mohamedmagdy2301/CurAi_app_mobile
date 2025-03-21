import 'package:curai_app_mobile/core/extensions/context_system_extansions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String formattedTime(BuildContext context, DateTime dateTime) {
  if (context.isStateArabic) {
    return DateFormat('hh:mm a', 'ar').format(dateTime);
  } else {
    return DateFormat('hh:mm a').format(dateTime);
  }
}
