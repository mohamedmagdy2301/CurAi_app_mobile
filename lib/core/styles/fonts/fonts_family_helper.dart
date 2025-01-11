import 'package:curai_app_mobile/core/extensions/settings_context_extansions.dart';
import 'package:flutter/material.dart';

class FontsFamilyHelper {
  static const String cairoAr = 'Cairo';
  static const String poppinsEn = 'Poppins';
  static String getLocaledFontFamily(BuildContext context) {
    if (context.isStateArabic) {
      return cairoAr;
    } else {
      return poppinsEn;
    }
  }
}
