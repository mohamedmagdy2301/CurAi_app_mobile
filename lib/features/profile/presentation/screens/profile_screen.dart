// ignore_for_file: flutter_style_todos

import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/extensions/int_extensions.dart' as a;
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/features/auth/presentation/widgets/logout_widget.dart';
import 'package:curai_app_mobile/features/profile/presentation/widgets/custom_appbar_profile.dart';
import 'package:curai_app_mobile/features/profile/presentation/widgets/image_profile_widget.dart';
import 'package:curai_app_mobile/features/profile/presentation/widgets/row_navigate_profile_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarProfile(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            20.hSpace,

            const ImageProfileWidget(),
            // TODO: Add edit profile
            15.hSpace,
            AutoSizeText(
              context.translate(LangKeys.editProfile),
              maxLines: 1,
              style: TextStyleApp.medium18(),
            ),
            25.hSpace,
            RowNavigateProfileWidget(
              icon: CupertinoIcons.person,
              title: LangKeys.yourProfile,
              onTap: () {},
            ),
            _buildDivider(context),
            RowNavigateProfileWidget(
              icon: Icons.payment,
              title: LangKeys.paymentMethod,
              onTap: () {},
            ),
            _buildDivider(context),
            RowNavigateProfileWidget(
              icon: CupertinoIcons.heart,
              title: LangKeys.favorite,
              onTap: () {},
            ),
            _buildDivider(context),
            RowNavigateProfileWidget(
              icon: CupertinoIcons.settings,
              title: LangKeys.settings,
              onTap: () {},
            ),
            _buildDivider(context),
            RowNavigateProfileWidget(
              icon: CupertinoIcons.info,
              title: LangKeys.helpCenter,
              onTap: () {},
            ),
            _buildDivider(context),
            RowNavigateProfileWidget(
              icon: CupertinoIcons.lock_shield,
              title: LangKeys.privacyPolicy,
              onTap: () {},
            ),
            _buildDivider(context),
            const LogoutWidget(),
          ],
        ).center(),
      ).paddingSymmetric(horizontal: context.isLandscape ? 100 : 0),
    );
  }

  Widget _buildDivider(BuildContext context) => Divider(
        thickness: .2,
        endIndent: 30,
        indent: 30,
        height: 0,
        color: context.onSecondaryColor,
      );
}
