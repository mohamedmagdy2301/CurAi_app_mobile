import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

ShimmerEffect shimmerEffect(BuildContext context) {
  return ShimmerEffect(
    baseColor: context.isDark ? Colors.grey.shade800 : Colors.grey.shade300,
    highlightColor:
        context.isDark ? Colors.grey.shade600 : Colors.grey.shade100,
    duration: const Duration(seconds: 1),
  );
}
