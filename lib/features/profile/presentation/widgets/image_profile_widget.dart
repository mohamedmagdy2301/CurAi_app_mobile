import 'dart:io';

import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/services/local_storage/menage_user_data.dart';
import 'package:curai_app_mobile/core/styles/images/app_images.dart';
import 'package:curai_app_mobile/core/utils/widgets/custom_cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImageProfileWidget extends StatelessWidget {
  const ImageProfileWidget({
    this.isEdit,
    super.key,
    this.onTap,
    this.imageUrl,
    this.imageFile,
  });

  final String? imageUrl;
  final File? imageFile;
  final VoidCallback? onTap;
  final bool? isEdit;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 70.r,
          backgroundColor: Colors.grey.shade200,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(70.r),
            child: imageFile != null
                ? Image.file(
                    imageFile!,
                    width: 140.w,
                    height: 140.h,
                    fit: BoxFit.cover,
                  )
                : CustomCachedNetworkImage(
                    imgUrl: imageUrl ??
                        (getRole() == 'doctor'
                            ? AppImages.avatarOnlineDoctor
                            : AppImages.avatarOnlinePatient),
                    width: 140.w,
                    height: 140.h,
                    loadingImgPadding: 50.w,
                    errorIconSize: 50.sp,
                  ),
          ),
        ),
        if (isEdit ?? false)
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
