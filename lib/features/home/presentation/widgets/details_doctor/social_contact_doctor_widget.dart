// ignore_for_file: lines_longer_than_80_chars

import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/utils/helper/url_launcher_helper.dart';
import 'package:curai_app_mobile/features/home/data/models/doctor_model/doctor_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SocialContactDoctorWidget extends StatelessWidget {
  const SocialContactDoctorWidget({
    required this.doctorResults,
    super.key,
  });

  final DoctorResults doctorResults;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10.w,
      children: [
        CircleAvatar(
          backgroundColor: context.onSecondaryColor.withAlpha(70),
          child: IconButton(
            onPressed: () {
              UrlLauncherHelper.launchPhoneCall(context, '01015415210');
            },
            icon: const Icon(CupertinoIcons.phone_fill),
            color: context.onPrimaryColor,
          ),
        ),
        CircleAvatar(
          backgroundColor: context.onSecondaryColor.withAlpha(70),
          child: IconButton(
            onPressed: () {
              UrlLauncherHelper.sendSms(context, '01015415210');
            },
            icon: const Icon(CupertinoIcons.chat_bubble_fill),
            color: context.onPrimaryColor,
          ),
        ),
        CircleAvatar(
          backgroundColor: context.onSecondaryColor.withAlpha(70),
          child: IconButton(
            onPressed: () {
              UrlLauncherHelper.launchEmail(
                context,
                doctorResults.email ?? '',
              );
            },
            icon: Icon(
              CupertinoIcons.mail,
              color: context.onPrimaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
