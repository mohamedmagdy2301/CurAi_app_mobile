import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//! Hide keyboard
void hideKeyboard() => FocusManager.instance.primaryFocus?.unfocus();

//! Check if the keyboard is visible
bool isKeyboardVisible() => FocusManager.instance.primaryFocus != null;

//! Space widget
Widget spaceHeight(double height) => SizedBox(height: height.h);
Widget spaceWidth(double width) => SizedBox(width: width.w);

EdgeInsets padding({double? horizontal, double? vertical}) {
  return EdgeInsets.symmetric(
    horizontal: horizontal?.w ?? 0,
    vertical: vertical?.h ?? 0,
  );
}
