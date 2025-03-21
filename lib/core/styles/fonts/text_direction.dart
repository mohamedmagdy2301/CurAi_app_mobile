import 'package:curai_app_mobile/core/utils/helper/regex.dart';
import 'package:flutter/material.dart';

TextDirection textDirection(String text) {
  return isArabicFormat(text) ? TextDirection.rtl : TextDirection.ltr;
}
