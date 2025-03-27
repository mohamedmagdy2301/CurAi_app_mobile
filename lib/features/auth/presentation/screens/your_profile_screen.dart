import 'package:curai_app_mobile/core/extensions/int_extensions.dart' as int_ex;
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/core/utils/widgets/adaptive_dialogs/adaptive_dialogs.dart';
import 'package:curai_app_mobile/core/utils/widgets/custom_button.dart';
import 'package:curai_app_mobile/features/auth/presentation/widgets/your_profile/custom_appbar_your_profile.dart';
import 'package:curai_app_mobile/features/auth/presentation/widgets/your_profile/custom_text_feild_edit_profile.dart';
import 'package:curai_app_mobile/features/profile/presentation/widgets/image_profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class YourProfileScreen extends StatefulWidget {
  const YourProfileScreen({super.key});

  @override
  State<YourProfileScreen> createState() => _YourProfileScreenState();
}

class _YourProfileScreenState extends State<YourProfileScreen> {
  final TextEditingController _fullNameController =
      TextEditingController(text: 'mohamed magdy');
  final TextEditingController _emailController =
      TextEditingController(text: 'b7Fk8@example.com');
  final TextEditingController _phoneController =
      TextEditingController(text: '01015415210');
  final TextEditingController _addressController =
      TextEditingController(text: 'Cairo, Egypt');
  final TextEditingController _birthDateController =
      TextEditingController(text: '19/11/2002');

  int? selectedGender;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarYourProfile(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 12.h,
          children: [
            4.hSpace,
            const ImageProfileWidget(),
            CustomTextFeildEditProfile(
              title: LangKeys.fullName,
              controller: _fullNameController,
            ),
            CustomTextFeildEditProfile(
              title: LangKeys.email,
              controller: _emailController,
            ),
            CustomTextFeildEditProfile(
              title: LangKeys.phone,
              controller: _phoneController,
            ),
            CustomTextFeildEditProfile(
              title: LangKeys.address,
              controller: _addressController,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.translate(LangKeys.gender),
                  style: TextStyleApp.medium14().copyWith(
                    color: context.onPrimaryColor,
                  ),
                ).paddingSymmetric(horizontal: 20),
                8.hSpace,
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  height: 50.h,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(
                      color: context.primaryColor.withAlpha(90),
                    ),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<int>(
                      isExpanded: true,
                      borderRadius: BorderRadius.circular(8.r),
                      elevation: 0,
                      style: TextStyleApp.regular16().copyWith(
                        color: context.onPrimaryColor,
                      ),
                      isDense: true,
                      icon: const Icon(Icons.arrow_drop_down),
                      value: selectedGender,
                      hint: Text(context.translate(LangKeys.gender)),
                      items: [
                        DropdownMenuItem(
                          value: 0,
                          child: Text(
                            context.translate(LangKeys.male),
                            style: TextStyleApp.regular16().copyWith(
                              color: context.onPrimaryColor,
                            ),
                          ),
                        ),
                        DropdownMenuItem(
                          value: 1,
                          child: Text(
                            context.translate(LangKeys.female),
                            style: TextStyleApp.regular16().copyWith(
                              color: context.onPrimaryColor,
                            ),
                          ),
                        ),
                      ],
                      onChanged: (int? newValue) {
                        setState(() {
                          selectedGender = newValue;
                        });
                        if (newValue != null) {
                          print('Selected Gender Value: $newValue');
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
            CustomTextFeildEditProfile(
              title: LangKeys.birthDate,
              controller: _birthDateController,
            ),
            CustomButton(
              title: LangKeys.updateProfile,
              onPressed: () {
                AdaptiveDialogs.showOkCancelAlertDialog(
                  context: context,
                  title: context.translate(LangKeys.updateProfile),
                  message: context.translate(LangKeys.updateProfileMessage),
                );
              },
            ).paddingSymmetric(horizontal: 20, vertical: 5),
          ],
        ).center(),
      ),
    );
  }
}
