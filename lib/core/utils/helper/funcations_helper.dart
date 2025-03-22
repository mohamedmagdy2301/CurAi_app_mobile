import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Hide soft keyboard
void hideKeyboard() {
  return FocusManager.instance.primaryFocus?.unfocus();
}

//  isKeyboardVisible
bool isKeyboardVisible(BuildContext context) {
  return MediaQuery.of(context).viewInsets.bottom > 0;
}

/// Returns a string from Clipboard
Future<String> paste() async {
  final data = await Clipboard.getData('text/plain');
  return data?.text?.toString() ?? '';
}

/// returns Radius
Radius radiusCircular([double? radius]) {
  return Radius.circular(radius ?? 12);
}

BorderRadius radius([double? radius]) {
  return BorderRadius.all(radiusCircular(radius ?? 12));
}

ShapeBorder shapeBorder([double? borderRadius]) {
  return RoundedRectangleBorder(borderRadius: radius(borderRadius ?? 12));
}

/// returns custom Radius on each side
BorderRadius radiusOnly({
  double? topRight,
  double? topLeft,
  double? bottomRight,
  double? bottomLeft,
}) {
  return BorderRadius.only(
    topRight: radiusCircular(topRight ?? 0),
    topLeft: radiusCircular(topLeft ?? 0),
    bottomRight: radiusCircular(bottomRight ?? 0),
    bottomLeft: radiusCircular(bottomLeft ?? 0),
  );
}
