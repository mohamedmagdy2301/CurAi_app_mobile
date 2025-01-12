import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/extensions/settings_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/style_text_context_ext.dart';
import 'package:curai_app_mobile/core/helper/functions_helper.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginWithSocial extends StatelessWidget {
  const LoginWithSocial({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Divider(
                thickness: 1,
                color: context.color.onSecondary.withAlpha(120),
              ),
            ),
            Padding(
              padding: padding(horizontal: 8),
              child: AutoSizeText(
                context.translate(LangKeys.orSignInWith),
                style: context.styleMedium14.copyWith(
                  color: context.color.onSecondary,
                ),
                maxLines: 1,
              ),
            ),
            Expanded(
              child: Divider(
                thickness: 1,
                color: context.color.onSecondary.withAlpha(120),
              ),
            ),
          ],
        ),
        spaceHeight(35),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CircleAvatar(
              backgroundColor: context.color.onSecondary.withAlpha(30),
              radius: 25.r,
              child: SvgPicture.asset(
                'assets/svg/Logo-Google.svg',
              ),
            ),
            CircleAvatar(
              backgroundColor: context.color.onSecondary.withAlpha(30),
              radius: 25.r,
              child: SvgPicture.asset(
                'assets/svg/Logo-Facebook.svg',
              ),
            ),
            CircleAvatar(
              backgroundColor: context.color.onSecondary.withAlpha(30),
              radius: 25.r,
              child: SvgPicture.asset(
                'assets/svg/Logo-Apple.svg',
              ),
            ),
          ],
        ),
      ],
    );
  }
}
