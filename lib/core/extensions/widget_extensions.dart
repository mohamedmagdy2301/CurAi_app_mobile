import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Widget Extensions
extension WidgetExtension on Widget? {
  /// With custom height and width
  SizedBox withSize({double width = 0.0, double height = 0.0}) {
    return SizedBox(height: height.h, width: width.w, child: this);
  }

  /// With custom width
  SizedBox withWidth(double width) => SizedBox(width: width.w, child: this);

  /// With custom height
  SizedBox withHeight(double height) => SizedBox(height: height.h, child: this);

  /// return padding top
  Padding paddingTop(double top) {
    return Padding(padding: EdgeInsets.only(top: top.h), child: this);
  }

  /// return padding left
  Padding paddingLeft(double left) {
    return Padding(padding: EdgeInsets.only(left: left.w), child: this);
  }

  /// return padding right
  Padding paddingRight(double right) {
    return Padding(padding: EdgeInsets.only(right: right.w), child: this);
  }

  /// return padding bottom
  Padding paddingBottom(double bottom) {
    return Padding(padding: EdgeInsets.only(bottom: bottom.h), child: this);
  }

  /// return padding all
  Padding paddingAll(double padding) {
    return Padding(padding: EdgeInsets.all(padding.r), child: this);
  }

  /// return custom padding from each side
  Padding paddingOnly({
    double top = 0.0,
    double left = 0.0,
    double bottom = 0.0,
    double right = 0.0,
  }) {
    return Padding(
      padding: EdgeInsets.fromLTRB(left.w, top.h, right.w, bottom.h),
      child: this,
    );
  }

  /// return padding symmetric
  Padding paddingSymmetric({double vertical = 0.0, double horizontal = 0.0}) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: vertical.h,
        horizontal: horizontal.w,
      ),
      child: this,
    );
  }

  /// set visibility
  Widget visible({required bool visible, Widget? defaultWidget}) {
    return visible ? this! : (defaultWidget ?? const SizedBox());
  }

  /// add custom corner radius each side
  ClipRRect cornerRadiusWithClipRRectOnly({
    int bottomLeft = 0,
    int bottomRight = 0,
    int topLeft = 0,
    int topRight = 0,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(bottomLeft.toDouble().r),
        bottomRight: Radius.circular(bottomRight.toDouble().r),
        topLeft: Radius.circular(topLeft.toDouble().r),
        topRight: Radius.circular(topRight.toDouble().r),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: this,
    );
  }

  /// add corner radius
  ClipRRect cornerRadiusWithClipRRect(double radius) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(radius.r)),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: this,
    );
  }

  /// add opacity to parent widget
  Widget opacity({
    required double opacity,
    int durationInSecond = 1,
    Duration? duration,
  }) {
    return AnimatedOpacity(
      opacity: opacity,
      duration: duration ?? const Duration(milliseconds: 500),
      child: this,
    );
  }

  /// add rotation to parent widget
  Widget rotate({
    required double angle,
    bool transformHitTests = true,
    Offset? origin,
  }) {
    return Transform.rotate(
      origin: origin,
      angle: angle,
      transformHitTests: transformHitTests,
      child: this,
    );
  }

  /// add scaling to parent widget
  Widget scale({
    required double scale,
    Offset? origin,
    AlignmentGeometry? alignment,
    bool transformHitTests = true,
  }) {
    return Transform.scale(
      scale: scale,
      origin: origin,
      alignment: alignment,
      transformHitTests: transformHitTests,
      child: this,
    );
  }

  /// add translate to parent widget
  Widget translate({
    required Offset offset,
    bool transformHitTests = true,
    Key? key,
  }) {
    return Transform.translate(
      offset: offset,
      transformHitTests: transformHitTests,
      key: key,
      child: this,
    );
  }

  /// set parent widget in center
  Widget center({double? heightFactor, double? widthFactor}) {
    return Center(
      heightFactor: heightFactor,
      widthFactor: widthFactor,
      child: this,
    );
  }

  Widget withScroll({
    required bool reverse,
    ScrollPhysics? physics,
    EdgeInsetsGeometry? padding,
    Axis scrollDirection = Axis.vertical,
    ScrollController? controller,
    DragStartBehavior dragStartBehavior = DragStartBehavior.start,
    bool? primary,
  }) {
    return SingleChildScrollView(
      physics: physics,
      padding: padding,
      scrollDirection: scrollDirection,
      controller: controller,
      dragStartBehavior: dragStartBehavior,
      primary: primary,
      reverse: reverse,
      child: this,
    );
  }

  /// add Expanded to parent widget
  Widget expand({int flex = 1}) => Expanded(flex: flex, child: this!);

  /// add Flexible to parent widget
  Widget flexible({int flex = 1, FlexFit? fit}) {
    return Flexible(flex: flex, fit: fit ?? FlexFit.loose, child: this!);
  }

  /// add FittedBox to parent widget
  Widget fit({BoxFit? fit, AlignmentGeometry? alignment}) {
    return FittedBox(
      fit: fit ?? BoxFit.contain,
      alignment: alignment ?? Alignment.center,
      child: this,
    );
  }

  /// Make your any widget refreshable with RefreshIndicator on top
  Widget makeRefreshable({required Future<void> Function() onRefresh}) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: Stack(
        children: [
          ListView(children: [this!]),
        ],
      ),
    );
  }
}
