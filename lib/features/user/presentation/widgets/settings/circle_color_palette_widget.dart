// ignore_for_file: inference_failure_on_function_return_type

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
      child: CircleAvatar(
        backgroundColor: color,
        radius: 27.r,
        child:
            isSelected ? const Icon(Icons.check, color: AppColors.white) : null,
      ),
    );
  }
}
