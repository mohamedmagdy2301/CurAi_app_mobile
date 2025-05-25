import 'package:curai_app_mobile/core/extensions/string_extensions.dart';
import 'package:flutter/material.dart';

TextDirection textDirection(String text) {
  return text.isArabicFormat ? TextDirection.rtl : TextDirection.ltr;
}
