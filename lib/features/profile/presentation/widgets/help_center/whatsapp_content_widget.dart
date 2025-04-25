// ignore_for_file: inference_failure_on_function_invocation, document_ignores

import 'package:curai_app_mobile/core/extensions/int_extensions.dart' as a;
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/core/utils/helper/url_launcher_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NumberPhoneContentWidget extends StatelessWidget {
  const NumberPhoneContentWidget({
    required this.number,
    super.key,
    this.isPhone,
  });
  final bool? isPhone;
  final String number;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        10.wSpace,
        Text(
          number,
          style: TextStyleApp.medium18().copyWith(
            color: context.onSecondaryColor,
          ),
        ),
        const Spacer(),
        if (isPhone ?? false)
          Row(
            children: [
              10.wSpace,
              IconButton(
                onPressed: () {
                  UrlLauncherHelper.sendSms(context, '01015415210');
                },
                padding: EdgeInsets.zero,
                icon: const Icon(
                  CupertinoIcons.chat_bubble_2_fill,
                  color: Colors.green,
                ),
              ),
              10.wSpace,
              IconButton(
                onPressed: () {
                  UrlLauncherHelper.launchPhoneCall(context, '01015415210');
                },
                padding: EdgeInsets.zero,
                icon: const Icon(
                  CupertinoIcons.phone_fill,
                  color: Colors.green,
                ),
              ),
            ],
          )
        else
          InkWell(
            onTap: () {
              UrlLauncherHelper.launchWhatsApp(context, '01015415210');
            },
            child: SvgPicture.asset(
              'assets/svg/whatsapp.svg',
              height: 25.h,
              width: 25.h,
            ),
          ),
      ],
    );
  }
}
