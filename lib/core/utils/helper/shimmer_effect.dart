import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

ShimmerEffect shimmerEffect() {
  return ShimmerEffect(
    baseColor: Colors.grey.shade300,
    highlightColor: Colors.grey.shade100,
    duration: const Duration(seconds: 1),
  );
}
