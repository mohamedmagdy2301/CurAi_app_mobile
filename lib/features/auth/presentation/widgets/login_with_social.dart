import 'package:curai_app_mobile/core/extensions/settings_context_extansions.dart';
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
            const Expanded(
              child: Divider(
                thickness: 1,
                // color: context.colors.textColorLight,
              ),
            ),
            Padding(
              padding: padding(horizontal: 8),
              child: Text(
                context.translate(LangKeys.orSignInWith),
                style: context.textTheme.bodyMedium!.copyWith(
                    // color: context.colors.textColorLight,
                    ),
              ),
            ),
            const Expanded(
              child: Divider(
                thickness: 1,
                // color: context.colors.textColorLight,
              ),
            ),
          ],
        ),
        spaceHeight(30),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: context.colors.primaryColor!.withAlpha(100),
              radius: 25.r,
              child: SvgPicture.asset(
                'assets/svg/Logo-Google.svg',
              ),
            ),
            spaceWidth(20),
            CircleAvatar(
              backgroundColor: context.colors.primaryColor!.withAlpha(100),
              radius: 25.r,
              child: SvgPicture.asset(
                'assets/svg/Logo-Facebook.svg',
              ),
            ),
            spaceWidth(20),
            CircleAvatar(
              backgroundColor: context.colors.primaryColor!.withAlpha(100),
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
