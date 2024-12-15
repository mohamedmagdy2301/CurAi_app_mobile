import 'package:curai_app_mobile/core/helper/functions_helper.dart';
import 'package:intl/intl.dart';

String formattedTime(DateTime dateTime) {
  if (isArabic()) {
    return DateFormat('hh:mm a', 'ar').format(dateTime);
  } else {
    return DateFormat('hh:mm a').format(dateTime);
  }
}
