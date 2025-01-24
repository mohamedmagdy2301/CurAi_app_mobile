import 'dart:math';

import 'package:curai_app_mobile/core/responsive_helper/size_provider.dart';
import 'package:flutter/material.dart';

extension SizerExt on BuildContext {
  //! MediaQuery
  bool get isLandscape =>
      MediaQuery.of(this).orientation == Orientation.landscape;

  double get width => isLandscape
      ? MediaQuery.sizeOf(this).height
      : MediaQuery.sizeOf(this).width;

  double get height => isLandscape
      ? MediaQuery.sizeOf(this).width
      : MediaQuery.sizeOf(this).height;

  SizeProvider get sizeProvider => SizeProvider.of(this);

  double get scaleWidth => sizeProvider.width / sizeProvider.baseSize.width;
  double get scaleHeight => sizeProvider.height / sizeProvider.baseSize.height;

  double setW(num width) => width * scaleWidth;
  double setH(num height) => height * scaleHeight;
  double setSp(num fontSize) => fontSize * scaleWidth;
  double setR(num size) => size * min(scaleWidth, scaleHeight);

  double get statusBarHeight => MediaQuery.paddingOf(this).top;
  double get bottomBarHeight => MediaQuery.paddingOf(this).bottom;
  double get screenHeightWithoutPadding => height - statusBarHeight;
  bool get isKeyboardVisible => MediaQuery.of(this).viewInsets.bottom == 0;
}
