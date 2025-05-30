import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAdvanceSwitch extends StatelessWidget {
  const CustomAdvanceSwitch({
    required this.valueNotifier,
    super.key,
    this.radius = 40,
    this.thumbRadius = 100,
    this.activeChild,
    this.inactiveChild,
    this.onChanged,
  });

  final ValueNotifier<bool> valueNotifier;
  final double radius;
  final double thumbRadius;
  final Widget? activeChild;
  final Widget? inactiveChild;
  final void Function({bool? value})? onChanged;

  @override
  Widget build(BuildContext context) {
    return AdvancedSwitch(
      activeColor: context.primaryColor,
      inactiveColor: context.onSecondaryColor,
      activeChild: activeChild ?? const SizedBox(),
      inactiveChild: inactiveChild ?? const SizedBox(),
      borderRadius: BorderRadius.all(Radius.circular(radius.r)),
      width: 60.w,
      height: 36.h,
      thumb: Container(
        margin: EdgeInsets.all(5.r),
        height: 24.h,
        width: 24.h,
        decoration: BoxDecoration(
          color: context.onPrimaryColor,
          borderRadius: BorderRadius.circular(thumbRadius),
        ),
      ),
      controller: valueNotifier,
      onChanged: onChanged != null
          ? (value) => onChanged!(value: value as bool)
          : null,
    );
  }
}
