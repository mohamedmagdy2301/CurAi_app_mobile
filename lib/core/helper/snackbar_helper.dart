import 'package:flutter/material.dart';
import 'package:smartcare_app_mobile/core/common/widgets/animated_snackbar.dart';

enum SnackBarType { error, success, warning, info }

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
}) {
  final snackBarTheme = Theme.of(context).snackBarTheme;

  hideMessage(context);

  // Create a new overlay entry
  _currentOverlayEntry = OverlayEntry(
    builder: (context) {
      return Positioned(
        bottom: 70,
        left: 16,
        right: 16,
        child: AnimatedSnackBar(
          message: message,
          backgroundColor: backgroundColor,
          isIconVisible: isIconVisible,
          icon: icon,
          labelAction: labelAction,
          onPressedAction: onPressedAction,
          snackBarTheme: snackBarTheme,
        ),
      );
    },
  );

  // Insert the overlay
  Overlay.of(context).insert(_currentOverlayEntry!);

  // Automatically remove the overlay after a delay 3 seconds
  Future.delayed(
    const Duration(seconds: 2),
    () {
      _currentOverlayEntry?.remove();
      _currentOverlayEntry = null;
    },
  );
}

//! Show message for user
void showMessage(
  BuildContext context, {
  required SnackBarType type,
  required String message,
  bool? isIconVisible,
  String? labelAction,
  VoidCallback? onPressedAction,
}) {
  final snackBarColors = <SnackBarType, Color>{
    SnackBarType.error: Colors.red,
    SnackBarType.success: Colors.green,
    SnackBarType.warning: Colors.orange,
    SnackBarType.info: Colors.blueGrey,
  };

  final snackBarIcons = <SnackBarType, IconData>{
    SnackBarType.error: Icons.error,
    SnackBarType.success: Icons.check_circle,
    SnackBarType.warning: Icons.warning,
    SnackBarType.info: Icons.info,
  };

  // Display the animated snackbar
  showAnimatedSnackBar(
    context: context,
    message: message,
    backgroundColor: snackBarColors[type]!,
    isIconVisible: isIconVisible,
    icon: snackBarIcons[type],
    labelAction: labelAction,
    onPressedAction: onPressedAction,
  );
}
