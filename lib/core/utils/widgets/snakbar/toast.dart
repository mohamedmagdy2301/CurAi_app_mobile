import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast({@required String? text, @required ToastStates? state}) =>
    Fluttertoast.showToast(
      msg: text!,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 7,
      backgroundColor: toastColor(state!),
      textColor: state == ToastStates.warning ? Colors.black : Colors.white,
      fontSize: 16.sp,
    );

enum ToastStates { success, error, warning }

Color? color;

Color? toastColor(ToastStates state) {
  switch (state) {
    case ToastStates.success:
      color = Colors.green;
      break;
    case ToastStates.error:
      color = Colors.red;
      {}
      break;
    case ToastStates.warning:
      color = Colors.orangeAccent;
      break;
  }
  return color;
}
