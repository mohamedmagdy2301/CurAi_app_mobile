import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/extensions/context_sizer_extansions.dart';
import 'package:curai_app_mobile/core/extensions/context_system_extansions.dart';
import 'package:curai_app_mobile/core/extensions/styletext_context_extansions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/features/auth/presentation/widgets/login/icon_auth_with_social.dart';
import 'package:flutter/material.dart';

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
                color: context.color.onSecondary.withAlpha(120),
              ),
            ),
            Padding(
              padding: context.padding(horizontal: 8),
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
        context.spaceHeight(35),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconAuthWithSocial(icon: 'assets/svg/Logo-Google.svg'),
            IconAuthWithSocial(icon: 'assets/svg/Logo-Facebook.svg'),
            IconAuthWithSocial(icon: 'assets/svg/Logo-Apple.svg'),
          ],
        ),
      ],
    );
  }
}
