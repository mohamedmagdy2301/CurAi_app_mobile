// ignore_for_file: lines_longer_than_80_chars

import 'dart:ui';

import 'package:curai_app_mobile/core/extensions/navigation_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/utils/widgets/custom_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void showImageViewerFullScreen(
  BuildContext context, {
  required String imageUrl,
}) {
  showDialog<void>(
    context: context,
    barrierColor: Colors.transparent,
    builder: (_) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Dialog(
            backgroundColor: Colors.transparent,
            insetPadding: EdgeInsets.zero,
            child: Stack(
              children: [
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                  child: Container(
                    color: context.backgroundColor.withAlpha(80),
                  ),
                ),
                InteractiveViewer(
                  child: CustomCachedNetworkImage(
                    imgUrl: imageUrl,
                    width: context.H * 0.4,
                    height: context.H * 0.5,
                    loadingImgPadding: 60.sp,
                    errorIconSize: 60.sp,
                  ),
                ).cornerRadiusWithClipRRect(12.r).center(),
                Positioned(
                  top: 20,
                  right: 20,
                  child: InkWell(
                    onTap: () => context.pop(),
                    borderRadius: BorderRadius.circular(30.r),
                    child: Icon(
                      Icons.close,
                      color: context.onPrimaryColor,
                      size: 35.sp,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
