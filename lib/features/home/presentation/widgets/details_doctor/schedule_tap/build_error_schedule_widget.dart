import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/extensions/int_extensions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildErrorScheduleWidget extends StatelessWidget {
  const BuildErrorScheduleWidget({required this.message, super.key});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          CupertinoIcons.exclamationmark_octagon_fill,
          size: 100.r,
          color: context.onSecondaryColor.withAlpha(50),
        ),
        20.hSpace,
        AutoSizeText(
          message,
          maxLines: 2,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: TextStyleApp.medium18().copyWith(
            color: Colors.red,
          ),
        ),
      ],
    );
  }
}
