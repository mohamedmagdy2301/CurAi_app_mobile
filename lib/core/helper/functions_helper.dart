import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:curai_app_mobile/core/local_storage/shared_pref_key.dart';
import 'package:curai_app_mobile/core/local_storage/shared_preferences_manager.dart';
import 'package:curai_app_mobile/core/utils/constants.dart';

//! Hide keyboard
void hideKeyboard() => FocusManager.instance.primaryFocus?.unfocus();

//! Check if the keyboard is visible
bool isKeyboardVisible() => FocusManager.instance.primaryFocus != null;

//! Space widget
Widget spaceHeight(double height) => SizedBox(height: height.h);
Widget spaceWidth(double width) => SizedBox(width: width.w);

//! Padding symetric
EdgeInsets padding({double? horizontal, double? vertical}) {
  return EdgeInsets.symmetric(
    horizontal: horizontal?.w ?? 0,
    vertical: vertical?.h ?? 0,
  );
}

//! Check if the language is Arabic
bool isArabic() {
  if ((SharedPrefManager.getString(SharedPrefKey.language) ??
          kDefaultLanguage) ==
      'ar') {
    return true;
  }
  return false;
}
