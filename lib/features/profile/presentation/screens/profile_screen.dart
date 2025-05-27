import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/extensions/int_extensions.dart' as a;
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/navigation_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/string_extensions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/routes/routes.dart';
import 'package:curai_app_mobile/core/services/local_storage/menage_user_data.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/core/styles/images/app_images.dart';
import 'package:curai_app_mobile/core/utils/widgets/custom_cached_network_image.dart';
import 'package:curai_app_mobile/features/auth/presentation/widgets/logout_widget.dart';
import 'package:curai_app_mobile/features/profile/presentation/widgets/custom_appbar_profile.dart';
import 'package:curai_app_mobile/features/profile/presentation/widgets/row_navigate_profile_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? imageFile;
  String? imageUrl;
  @override
  Widget build(BuildContext context) {
    if (getProfilePicture().contains('http')) {
      imageUrl = getProfilePicture();
    } else {
      imageFile = File(getProfilePicture());
    }

    return Scaffold(
      appBar: const CustomAppBarProfile(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            10.hSpace,
            ClipRRect(
              borderRadius: BorderRadius.circular(1000.r),
              child: imageFile != null
                  ? Image.file(
                      imageFile!,
                      width: context.H * 0.16,
                      height: context.H * 0.16,
                      fit: BoxFit.cover,
                    )
                  : CustomCachedNetworkImage(
                      imgUrl: imageUrl ??
                          (getRole() == 'doctor'
                              ? AppImages.avatarOnlineDoctor
                              : AppImages.avatarOnlinePatient),
                      width: context.isTablet
                          ? context.H * 0.17
                          : context.H * 0.16,
                      height: context.isTablet
                          ? context.H * 0.17
                          : context.H * 0.16,
                      loadingImgPadding: 50.w,
                      errorIconSize: 50.sp,
                    ),
            ),
            10.wSpace,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: context.W * .65,
                  child: AutoSizeText(
                    getRole() == 'patient'
                        ? getFullName().capitalizeFirstChar
                        : '${context.translate(LangKeys.dr)}. '
                            '${getFullName().capitalizeFirstChar}',
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyleApp.extraBold26().copyWith(
                      color: context.primaryColor,
                    ),
                  ),
                ),
              ],
            ).paddingSymmetric(horizontal: 12, vertical: 5),
            RowNavigateProfileWidget(
              icon: CupertinoIcons.person,
              title: LangKeys.yourProfile,
              onTap: () => context.pushNamed(Routes.yourProfileScreen),
            ),
            if (getRole() != 'patient') _buildDivider(context),
            if (getRole() != 'patient')
              RowNavigateProfileWidget(
                icon: CupertinoIcons.person_2_square_stack_fill,
                title: LangKeys.bio,
                onTap: () {
                  context.pushNamed(
                    Routes.bioScreen,
                    arguments: {'isEdit': true},
                  );
                },
              ),
            if (getRole() != 'patient') _buildDivider(context),
            if (getRole() != 'patient')
              RowNavigateProfileWidget(
                icon: CupertinoIcons.calendar,
                title: LangKeys.workingTime,
                onTap: () {
                  context.pushNamed(Routes.workingTimeDoctorAvailableScreen);
                },
              ),
            _buildDivider(context),
            if (getRole() != 'patient')
              RowNavigateProfileWidget(
                icon: CupertinoIcons.map,
                title: LangKeys.clinicAddress,
                onTap: () {
                  context.pushNamed(
                    Routes.addAddreesClinicScreen,
                    arguments: {'isEdit': true},
                  );
                },
              ),
            if (getRole() == 'patient')
              RowNavigateProfileWidget(
                icon: Icons.payment,
                title: LangKeys.paymentMethod,
                onTap: () {},
              ),
            _buildDivider(context),
            RowNavigateProfileWidget(
              icon: CupertinoIcons.heart,
              title: LangKeys.favorite,
              onTap: () {
                context.pushNamed(Routes.favoriteScreen);
              },
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
