import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/core/utils/widgets/sankbar/animated_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toastification/toastification.dart';

// enum ToastificationType { error, success, warning, info }

OverlayEntry? _currentOverlayEntry;

//! Hide SnackBar
void hideMessage(BuildContext context) {
  _currentOverlayEntry?.remove();
  _currentOverlayEntry = null;
}

//! Animated SnackBar
void showAnimatedSnackBar({
  required BuildContext context,
  required String message,
  required Color backgroundColor,
  bool? isIconVisible,
  String? labelAction,
  VoidCallback? onPressedAction,
  IconData? icon,
  bool? showCloseIcon,
}) {
  final snackBarTheme = Theme.of(context).snackBarTheme;

  hideMessage(context);

  // Create a new overlay entry
  _currentOverlayEntry = OverlayEntry(
    builder: (context) {
      return Positioned(
        bottom: 80.h,
        left: 16.w,
        right: 16.w,
        child: AnimatedSnackBar(
          message: message,
          backgroundColor: backgroundColor,
          isIconVisible: isIconVisible,
          icon: icon,
          labelAction: labelAction,
          onPressedAction: onPressedAction,
          snackBarTheme: snackBarTheme,
          showCloseIcon: showCloseIcon,
        ),
      );
    },
  );

  // Insert the overlay
  Overlay.of(context).insert(_currentOverlayEntry!);

  // Automatically remove the overlay after 3 seconds
  Future.delayed(
    Duration(seconds: showCloseIcon ?? false ? 12 : 3),
    () {
      _currentOverlayEntry?.remove();
      _currentOverlayEntry = null;
    },
  );
}

// //! Show message for user
// void showMessage(
//   BuildContext context, {
//   required SnackBarType type,
//   required String message,
//   bool? isIconVisible,
//   String? labelAction,
//   VoidCallback? onPressedAction,
//   bool? showCloseIcon, // ← جديد
// }) {
//   final snackBarColors = <SnackBarType, Color>{
//     SnackBarType.error: Colors.red,
//     SnackBarType.success: Colors.green,
//     SnackBarType.warning: Colors.orange,
//     SnackBarType.info: Colors.blueGrey,
//   };

//   final snackBarIcons = <SnackBarType, IconData>{
//     SnackBarType.error: Icons.error,
//     SnackBarType.success: Icons.check_circle,
//     SnackBarType.warning: Icons.warning,
//     SnackBarType.info: Icons.info,
//   };

//   // Display the animated snackbar
//   showAnimatedSnackBar(
//     context: context,
//     message: message,
//     backgroundColor: snackBarColors[type]!,
//     isIconVisible: isIconVisible,
//     icon: snackBarIcons[type],
//     labelAction: labelAction,
//     onPressedAction: onPressedAction,
//     showCloseIcon: showCloseIcon,
//   );
// }

void showMessage(
  BuildContext context, {
  required String message,
  required ToastificationType type,
  AlignmentGeometry? alignment,
}) {
  toastification.show(
    context: context,
    type: type,
    description: AutoSizeText(
      message,
      style: TextStyleApp.medium16().copyWith(
        color: Colors.white,
      ),
    ).paddingBottom(12.h),
    showIcon: false,
    primaryColor: Colors.white,
    autoCloseDuration: const Duration(seconds: 5),
    progressBarTheme: ProgressIndicatorThemeData(
      refreshBackgroundColor: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(12.r)),
      circularTrackColor: Colors.red,
      linearTrackColor: Colors.white,
      color: type == ToastificationType.success
          ? Colors.green.shade300
          : type == ToastificationType.info
              ? Colors.blueGrey.shade300
              : type == ToastificationType.warning
                  ? Colors.orange.shade300
                  : Colors.red.shade300,
    ),
    showProgressBar: true,
    borderSide: BorderSide.none,
    closeButton: const ToastCloseButton(
      showType: CloseButtonShowType.none,
    ),
    alignment: alignment ??
        (context.isStateArabic ? Alignment.topLeft : Alignment.topRight),
    borderRadius: BorderRadius.all(Radius.circular(12.r)),
    backgroundColor: type == ToastificationType.success
        ? Colors.green
        : type == ToastificationType.info
            ? Colors.blueGrey
            : type == ToastificationType.warning
                ? Colors.orange
                : Colors.red,
    foregroundColor: Colors.white,
  );
}
