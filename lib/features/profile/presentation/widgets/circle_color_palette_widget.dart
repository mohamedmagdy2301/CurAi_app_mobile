// ignore_for_file: inference_failure_on_function_return_type, document_ignores

import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/styles/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CircleColorPaletteWidget extends StatelessWidget {
  const CircleColorPaletteWidget({
    required this.color,
    required this.isSelected,
    required this.onSelect,
    super.key,
  });
  final Color color;
  final bool isSelected;
  final Function(Color) onSelect;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onSelect(color),
      child: ColoredBox(
        color: color,
        child: SizedBox(
          width: 50.w,
          height: 30.h,
          child: isSelected
              ? Icon(
                  Icons.check,
                  color: AppColors.white,
                  size: 30.sp,
                )
              : null,
        ),
      ).cornerRadiusWithClipRRect(10.r),
      // CircleAvatar(
      //   backgroundColor: color,
      //   radius: 40.r,
      //   child: isSelected
      //       ? Icon(Icons.check, color: AppColors.white, size: 20.sp)
      //       : null,
      // ),
    );
  }
}
