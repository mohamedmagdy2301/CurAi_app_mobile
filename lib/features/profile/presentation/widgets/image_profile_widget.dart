// ignore_for_file: flutter_style_todos

import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImageProfileWidget extends StatelessWidget {
  const ImageProfileWidget({
    super.key,
    this.onTap,
  });

  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 70.r,
          backgroundImage: const NetworkImage(
            'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
          ),
        ),
        Positioned(
          bottom: 5.h,
          right: 0,
          child: InkWell(
            onTap: onTap ?? () {},
            child: CircleAvatar(
              radius: 16.r,
              backgroundColor: context.backgroundColor,
              child: CircleAvatar(
                radius: 15.r,
                backgroundColor: context.primaryColor,
                child: const Icon(
                  CupertinoIcons.pencil,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
