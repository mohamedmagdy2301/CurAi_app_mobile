import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/extensions/int_extensions.dart';
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/core/styles/images/app_images.dart';
import 'package:curai_app_mobile/features/auth/presentation/widgets/login/icon_auth_with_social.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SocialAuthenticationWidget extends StatelessWidget {
  const SocialAuthenticationWidget({
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
                color: context.onSecondaryColor.withAlpha(120),
              ),
            ),
            Padding(
              padding: context.padding(horizontal: 8.r),
              child: AutoSizeText(
                context.translate(LangKeys.orSignInWith),
                style: TextStyleApp.medium14().copyWith(
                  color: context.onSecondaryColor,
                ),
                maxLines: 1,
              ),
            ),
            Expanded(
              child: Divider(
                thickness: 1,
                color: context.onSecondaryColor.withAlpha(120),
              ),
            ),
          ],
        ),
        35.hSpace,
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconAuthWithSocial(icon: AppImagesSvg.logoGoogle),
            IconAuthWithSocial(icon: AppImagesSvg.logoFacebook),
            IconAuthWithSocial(icon: AppImagesSvg.logoApple),
          ],
        ),
      ],
    );
  }
}
