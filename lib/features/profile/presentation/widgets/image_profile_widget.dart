import 'dart:io';

import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImageProfileWidget extends StatelessWidget {
  const ImageProfileWidget({
    super.key,
    this.onTap,
    this.imageUrl,
    this.imageFile,
  });

  final String? imageUrl;
  final File? imageFile;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 70.r,
          foregroundColor: context.onSecondaryColor,
          backgroundImage: imageFile != null
              ? FileImage(imageFile!)
              : NetworkImage(
                  imageUrl ??
                      'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
                ) as ImageProvider,
        ),
        Positioned(
          bottom: 5.h,
          right: 0,
          child: InkWell(
            onTap: onTap ?? () {},
            child: CircleAvatar(
              radius: 18.r,
              backgroundColor: context.backgroundColor,
              child: CircleAvatar(
                radius: 17.r,
                backgroundColor: context.primaryColor,
                child: Icon(
                  CupertinoIcons.camera_fill,
                  size: 18.sp,
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
