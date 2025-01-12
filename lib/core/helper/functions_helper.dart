import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//! Hide keyboard
void hideKeyboard() => FocusManager.instance.primaryFocus?.unfocus();

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
