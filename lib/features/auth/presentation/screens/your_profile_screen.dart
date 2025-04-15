import 'dart:io';

import 'package:curai_app_mobile/core/extensions/int_extensions.dart' as int_ex;
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/navigation_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/core/utils/widgets/adaptive_dialogs/adaptive_dialogs.dart';
import 'package:curai_app_mobile/core/utils/widgets/custom_button.dart';
import 'package:curai_app_mobile/core/utils/widgets/sankbar/snackbar_helper.dart';
import 'package:curai_app_mobile/features/auth/data/models/profile/profile_model.dart';
import 'package:curai_app_mobile/features/auth/data/models/profile/profile_request.dart';
import 'package:curai_app_mobile/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:curai_app_mobile/features/auth/presentation/widgets/your_profile/custom_text_feild_edit_profile.dart';
import 'package:curai_app_mobile/features/profile/presentation/widgets/image_profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class YourProfileScreen extends StatefulWidget {
  const YourProfileScreen({required this.profileModel, super.key});
  final ProfileModel profileModel;

  @override
  State<YourProfileScreen> createState() => _YourProfileScreenState();
}

class _YourProfileScreenState extends State<YourProfileScreen> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _yourAgeController = TextEditingController();

  String? selectedGender;
  ImagePicker imagePicker = ImagePicker();
  File? imageFile;
  String? imageUrl;
  bool isChanged = false;

  @override
  void initState() {
    super.initState();
    _userNameController.text = widget.profileModel.username!;
    _fullNameController.text = widget.profileModel.firstName!;
    _phoneController.text = widget.profileModel.phoneNumber!;
    _addressController.text = widget.profileModel.location!;
    _yourAgeController.text = widget.profileModel.age.toString();
    selectedGender = widget.profileModel.gender;
    imageUrl = widget.profileModel.profilePicture;

    _userNameController.addListener(checkIfChanged);
    _fullNameController.addListener(checkIfChanged);
    _phoneController.addListener(checkIfChanged);
    _addressController.addListener(checkIfChanged);
    _yourAgeController.addListener(checkIfChanged);
  }

  void checkIfChanged() {
    setState(() {
      isChanged = widget.profileModel.username! != _userNameController.text ||
          widget.profileModel.phoneNumber! != _phoneController.text ||
          widget.profileModel.location! != _addressController.text ||
          widget.profileModel.age! != int.tryParse(_yourAgeController.text) ||
          widget.profileModel.gender! != selectedGender ||
          imageFile != null;
    });
  }

  void _updateProfileOnTap() {
    context.pop();
    final profileRequest = ProfileRequest(
      fullName: _fullNameController.text,
      username: _userNameController.text,
      phoneNumber: _phoneController.text,
      location: _addressController.text,
      age: int.parse(_yourAgeController.text),
      gender: selectedGender ?? 'male',
      specialization: '',
      consultationPrice: '',
    );
    context.read<AuthCubit>().editProfile(
          profileRequest: profileRequest,
          // imageFile: imageFile,
        );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 12.h,
        children: [
          4.hSpace,
          ImageProfileWidget(
            imageFile: imageFile,
            imageUrl: imageFile == null ? imageUrl : null,
            // isEdit: true,
            // onTap: () async {
            //   final xFilePhoto =
            //       await imagePicker.pickImage(source: ImageSource.gallery);
            //   if (xFilePhoto != null) {
            //     setState(() {
            //       imageFile = File(xFilePhoto.path);
            //       checkIfChanged();
            //     });
            // }
            // },
          ),
          CustomTextFeildEditProfile(
            title: LangKeys.userName,
            keyboardType: TextInputType.emailAddress,
            controller: _userNameController,
          ),
          CustomTextFeildEditProfile(
            title: LangKeys.fullName,
            keyboardType: TextInputType.name,
            controller: _fullNameController,
          ),
          CustomTextFeildEditProfile(
            title: LangKeys.phone,
            keyboardType: TextInputType.phone,
            controller: _phoneController,
          ),
          CustomTextFeildEditProfile(
            title: LangKeys.address,
            keyboardType: TextInputType.streetAddress,
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
                padding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 8.h,
                ),
                margin: EdgeInsets.symmetric(horizontal: 20.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(
                    color: context.primaryColor.withAlpha(90),
                  ),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    borderRadius: BorderRadius.circular(8.r),
                    elevation: 0,
                    style: TextStyleApp.regular16().copyWith(
                      color: context.onPrimaryColor,
                    ),
                    isDense: true,
                    icon: const Icon(Icons.arrow_drop_down),
                    value: selectedGender,
                    items: [
                      DropdownMenuItem(
                        value: 'male',
                        child: Text(context.translate(LangKeys.male)),
                      ),
                      DropdownMenuItem(
                        value: 'female',
                        child: Text(context.translate(LangKeys.female)),
                      ),
                    ],
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedGender = newValue;
                        checkIfChanged();
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
          CustomTextFeildEditProfile(
            title: LangKeys.yourAge,
            keyboardType: TextInputType.number,
            controller: _yourAgeController,
          ),
          BlocConsumer<AuthCubit, AuthState>(
            listenWhen: (previous, current) =>
                current is EditProfileSuccess ||
                current is EditProfileError ||
                current is EditProfileLoading,
            buildWhen: (previous, current) =>
                current is EditProfileSuccess ||
                current is EditProfileError ||
                current is EditProfileLoading,
            listener: (context, state) {
              if (state is EditProfileSuccess) {
                context.pop();
                showMessage(
                  context,
                  type: SnackBarType.success,
                  message: context.isStateArabic
                      ? 'تم تحديث الملف الشخصي بنجاح'
                      : 'Profile updated successfully',
                );
              } else if (state is EditProfileError) {
                context.pop();
                showMessage(
                  context,
                  type: SnackBarType.error,
                  message: state.message,
                );
              } else if (state is EditProfileLoading) {
                AdaptiveDialogs.showLoadingAlertDialog(
                  context: context,
                  title: context.translate(LangKeys.editProfile),
                );
              }
            },
            builder: (context, state) {
              return CustomButton(
                title: LangKeys.updateProfile,
                colorBackground: isChanged ? context.primaryColor : Colors.grey,
                onPressed: () {
                  isChanged
                      ? AdaptiveDialogs.showOkCancelAlertDialog(
                          context: context,
                          title: context.translate(LangKeys.updateProfile),
                          message:
                              context.translate(LangKeys.updateProfileMessage),
                          onPressedOk: _updateProfileOnTap,
                        )
                      : null;
                },
              );
            },
          ).paddingSymmetric(horizontal: 20, vertical: 10),
        ],
      ).center(),
    );
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _userNameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _yourAgeController.dispose();
    super.dispose();
  }
}
