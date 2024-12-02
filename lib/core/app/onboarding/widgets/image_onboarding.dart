import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImageOnboarding extends StatelessWidget {
  const ImageOnboarding({
    required this.image,
    super.key,
  });
  final String image;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      image,
      height: 380.h,
      width: double.infinity,
      fit: BoxFit.fill,
    );
  }
}
