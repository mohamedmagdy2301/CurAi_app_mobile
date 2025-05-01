import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/extensions/int_extensions.dart' as a;
import 'package:curai_app_mobile/core/extensions/navigation_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/local_storage/menage_user_data.dart';
import 'package:curai_app_mobile/core/routes/routes.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/features/auth/presentation/widgets/logout_widget.dart';
import 'package:curai_app_mobile/features/profile/presentation/widgets/custom_appbar_profile.dart';
import 'package:curai_app_mobile/features/profile/presentation/widgets/image_profile_widget.dart';
import 'package:curai_app_mobile/features/profile/presentation/widgets/row_navigate_profile_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ImagePicker imagePicker = ImagePicker();
  File? imageFile;
  XFile? xFilePhoto;
  String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarProfile(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            20.hSpace,
            ImageProfileWidget(
              imageFile: File(getProfilePicture()),
              isEdit: false,
            ),
            15.hSpace,
            AutoSizeText(
              getFullName(),
              maxLines: 1,
              style: TextStyleApp.medium22().copyWith(
                color: context.primaryColor,
              ),
            ),
            20.hSpace,
            RowNavigateProfileWidget(
              icon: CupertinoIcons.person,
              title: LangKeys.yourProfile,
              onTap: () => context.pushNamed(Routes.yourProfileScreen),
            ),
            if (isDoctor) _buildDivider(context),
            if (isDoctor)
              RowNavigateProfileWidget(
                icon: CupertinoIcons.calendar,
                title: LangKeys.workingTime,
                onTap: () {
                  context.pushNamed(Routes.workingTimeDoctorAvailableScreen);
                },
              ),
            if (isPatient) _buildDivider(context),
            if (isPatient)
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
              onTap: () => context.pushNamed(Routes.settingsScreen),
            ),
            _buildDivider(context),
            RowNavigateProfileWidget(
              icon: CupertinoIcons.info,
              title: LangKeys.helpCenter,
              onTap: () => context.pushNamed(Routes.helpCenterScreen),
            ),
            _buildDivider(context),
            RowNavigateProfileWidget(
              icon: CupertinoIcons.lock_shield,
              title: LangKeys.privacyPolicy,
              onTap: () => context.pushNamed(Routes.privacyPolicyScreen),
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
