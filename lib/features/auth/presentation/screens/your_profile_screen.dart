import 'dart:io';

import 'package:curai_app_mobile/core/dependency_injection/service_locator.dart'
    as di;
import 'package:curai_app_mobile/core/extensions/int_extensions.dart' as int_ex;
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/navigation_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/routes/routes.dart';
import 'package:curai_app_mobile/core/services/local_storage/menage_user_data.dart';
import 'package:curai_app_mobile/core/services/local_storage/shared_pref_key.dart';
import 'package:curai_app_mobile/core/services/local_storage/shared_preferences_manager.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/core/utils/widgets/adaptive_dialogs/adaptive_dialogs.dart';
import 'package:curai_app_mobile/core/utils/widgets/custom_button.dart';
import 'package:curai_app_mobile/core/utils/widgets/sankbar/snackbar_helper.dart';
import 'package:curai_app_mobile/features/auth/data/models/profile/profile_model.dart';
import 'package:curai_app_mobile/features/auth/data/models/profile/profile_request.dart';
import 'package:curai_app_mobile/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:curai_app_mobile/features/auth/presentation/widgets/your_profile/custom_text_feild_edit_profile.dart';
import 'package:curai_app_mobile/features/home/data/models/specializations_model/specializations_model.dart';
import 'package:curai_app_mobile/features/home/presentation/widgets/doctor_speciality/specialization_widget.dart';
import 'package:curai_app_mobile/features/profile/presentation/widgets/image_profile_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toastification/toastification.dart';

class YourProfileScreen extends StatefulWidget {
  const YourProfileScreen({required this.profileModel, super.key});
  final ProfileModel profileModel;

  @override
  State<YourProfileScreen> createState() => _YourProfileScreenState();
}

class _YourProfileScreenState extends State<YourProfileScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _yourAgeController = TextEditingController();
  final TextEditingController _consultationPriceController =
      TextEditingController();

  String? selectedGender;
  final ImagePicker imagePicker = ImagePicker();
  File? imageFile;
  String? imageUrl;
  bool isChanged = false;
  XFile? xFilePhoto;

  int? selectedSpecialization;

  @override
  void initState() {
    super.initState();
    _userNameController.text = widget.profileModel.username ?? '';
    _firstNameController.text = widget.profileModel.firstName ?? '';
    _lastNameController.text = widget.profileModel.lastName ?? '';
    _phoneController.text = widget.profileModel.phoneNumber ?? '';
    _consultationPriceController.text =
        widget.profileModel.consultationPrice ?? '';
    _yourAgeController.text = widget.profileModel.age?.toString() ?? '';
    selectedGender = widget.profileModel.gender;
    selectedSpecialization = widget.profileModel.specialization;
    imageUrl = widget.profileModel.profilePicture;

    _userNameController.addListener(checkIfChanged);
    _firstNameController.addListener(checkIfChanged);
    _lastNameController.addListener(checkIfChanged);
    _phoneController.addListener(checkIfChanged);
    _yourAgeController.addListener(checkIfChanged);
    _consultationPriceController.addListener(checkIfChanged);
  }

  void checkIfChanged() {
    setState(() {
      isChanged = widget.profileModel.username != _userNameController.text ||
          widget.profileModel.firstName != _firstNameController.text ||
          widget.profileModel.lastName != _lastNameController.text ||
          widget.profileModel.phoneNumber != _phoneController.text ||
          widget.profileModel.age != int.tryParse(_yourAgeController.text) ||
          widget.profileModel.consultationPrice !=
              _consultationPriceController.text ||
          widget.profileModel.gender != selectedGender ||
          widget.profileModel.specialization != selectedSpecialization ||
          imageFile != null;
    });
  }

  void _updateProfileOnTap() {
    context.pop();
    final ProfileRequest profileRequest;
    if (getRole() == 'doctor') {
      profileRequest = ProfileRequest(
        username: _userNameController.text.trim(),
        firstName: _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
        phoneNumber: _phoneController.text.trim(),
        age: _yourAgeController.text.trim(),
        gender: selectedGender,
        consultationPrice: _consultationPriceController.text.trim(),
        specialization: selectedSpecialization,
        profileImage: imageFile,
      );
    } else {
      profileRequest = ProfileRequest(
        username: _userNameController.text.trim(),
        firstName: _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
        phoneNumber: _phoneController.text.trim(),
        age: _yourAgeController.text.trim(),
        gender: selectedGender,
        profileImage: imageFile,
      );
    }
    context
        .read<AuthCubit>()
        .editProfile(context, profileRequest: profileRequest);
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
            isEdit: true,
            imageUrl: widget.profileModel.profilePicture,
            onTap: () async {
              xFilePhoto = await imagePicker.pickImage(
                source: ImageSource.gallery,
              );
              if (xFilePhoto != null) {
                setState(() {
                  imageFile = File(xFilePhoto!.path);
                  imageUrl = imageFile!.path;
                  checkIfChanged();
                });
              }
            },
          ),
          CustomTextFeildEditProfile(
            title: LangKeys.userName,
            keyboardType: TextInputType.emailAddress,
            controller: _userNameController,
          ),
          CustomTextFeildEditProfile(
            title: LangKeys.firstName,
            keyboardType: TextInputType.name,
            controller: _firstNameController,
          ),
          CustomTextFeildEditProfile(
            title: LangKeys.lastName,
            keyboardType: TextInputType.name,
            controller: _lastNameController,
          ),
          CustomTextFeildEditProfile(
            title: LangKeys.yourAge,
            keyboardType: TextInputType.number,
            controller: _yourAgeController,
            suffixIcon: InkWell(
              onTap: () => _showYearPicker(context),
              child: const Icon(CupertinoIcons.calendar),
            ),
          ),
          _buildSelectGender(context),
          if (getRole() == 'doctor')
            CustomTextFeildEditProfile(
              title: LangKeys.consultationPrice,
              keyboardType: TextInputType.number,
              controller: _consultationPriceController,
            ),
          if (getRole() == 'doctor') _buildSelectSpecilization(context),
          CustomTextFeildEditProfile(
            title: LangKeys.phone,
            keyboardType: TextInputType.phone,
            controller: _phoneController,
            maxLenght: 11,
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
                  type: ToastificationType.success,
                  message: context.isStateArabic
                      ? 'تم تحديث الملف الشخصي بنجاح'
                      : 'Profile updated successfully',
                );

                di.sl<CacheDataManager>()
                  ..removeData(key: SharedPrefKey.keyFullName)
                  ..removeData(key: SharedPrefKey.keyProfilePicture)
                  ..setData(
                    key: SharedPrefKey.keyProfilePicture,
                    value:
                        imageFile?.path ?? widget.profileModel.profilePicture,
                  )
                  ..setData(
                    key: SharedPrefKey.keyFullName,
                    value: '${_firstNameController.text} '
                        '${_lastNameController.text}',
                  );
                context.pushReplacementNamed(Routes.mainScaffoldUser);
                context.read<AuthCubit>().clearState();
              }
              if (state is EditProfileError) {
                context.pop();
                showMessage(
                  context,
                  type: ToastificationType.error,
                  message: state.message,
                );
                context.read<AuthCubit>().clearState();
              }
              if (state is EditProfileLoading) {
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
                onPressed: isChanged
                    ? () {
                        AdaptiveDialogs.showOkCancelAlertDialog<bool>(
                          context: context,
                          title: context.translate(LangKeys.updateProfile),
                          message:
                              context.translate(LangKeys.updateProfileMessage),
                          onPressedOk: _updateProfileOnTap,
                        );
                      }
                    : () {},
              );
            },
          ).paddingSymmetric(horizontal: 20, vertical: 10),
        ],
      ).center(),
    );
  }

  Widget _buildSelectGender(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.translate(LangKeys.gender),
          style: TextStyleApp.medium14().copyWith(
            color: context.onPrimaryColor,
          ),
        ),
        8.hSpace,
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(
              color: context.primaryColor.withAlpha(100),
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
              icon: Icon(
                Icons.keyboard_arrow_down,
                size: 30.sp,
                color: context.primaryColor,
              ),
              value: selectedGender,
              hint: Text(
                context.translate(LangKeys.gender),
                style: TextStyleApp.regular16().copyWith(
                  color: context.primaryColor,
                ),
              ),
              items: [
                DropdownMenuItem(
                  value: 'male',
                  child: Text(
                    context.translate(LangKeys.male),
                    style: TextStyleApp.regular16().copyWith(
                      color: context.onPrimaryColor,
                    ),
                  ),
                ),
                DropdownMenuItem(
                  value: 'female',
                  child: Text(
                    context.translate(LangKeys.female),
                    style: TextStyleApp.regular16().copyWith(
                      color: context.onPrimaryColor,
                    ),
                  ),
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
    ).paddingSymmetric(horizontal: 20);
  }

  Widget _buildSelectSpecilization(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.translate(LangKeys.medicalSpecialization),
          style: TextStyleApp.medium14().copyWith(
            color: context.onPrimaryColor,
          ),
        ),
        8.hSpace,
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(
              color: context.primaryColor.withAlpha(100),
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
              icon: Icon(
                Icons.keyboard_arrow_down,
                size: 30.sp,
                color: context.primaryColor,
              ),
              value: selectedSpecialization,
              hint: selectedSpecialization == null
                  ? Text(
                      context.translate(LangKeys.medicalSpecialization),
                      style: TextStyleApp.regular16().copyWith(
                        color: context.primaryColor,
                      ),
                    )
                  : Text(
                      specializationName(
                        specializationsList.firstWhere(
                          (element) => element['id'] == selectedSpecialization,
                        )['name'] as String,
                        isArabic: context.isStateArabic,
                      ),
                      style: TextStyleApp.regular16().copyWith(
                        color: context.onPrimaryColor,
                      ),
                    ),
              items: specializationsList
                  .map(
                    (spec) => DropdownMenuItem<int>(
                      value: spec['id'] as int,
                      child: Text(
                        specializationName(
                          spec['name'] as String,
                          isArabic: context.isStateArabic,
                        ),
                        style: TextStyleApp.regular16().copyWith(
                          color: context.onPrimaryColor,
                        ),
                      ),
                    ),
                  )
                  .toList(),
              onChanged: (int? newValue) {
                setState(() {
                  selectedSpecialization = newValue;
                  checkIfChanged();
                });
              },
            ),
          ),
        ),
      ],
    ).paddingSymmetric(horizontal: 20);
  }

  void _showYearPicker(BuildContext context) {
    var selectedDate = DateTime.now();

    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext builder) {
        return SizedBox(
          height: context.H * 0.4,
          child: Column(
            children: [
              10.hSpace,
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: const Icon(Icons.check),
                  iconSize: 30.sp,
                  color: context.primaryColor,
                  constraints: BoxConstraints.tight(
                    Size(context.W * 0.1, context.W * 0.1),
                  ),
                  onPressed: () {
                    final birthYear = selectedDate.year;
                    final age = DateTime.now().year - birthYear;
                    _yourAgeController.text = age.toString();
                    context.pop();
                  },
                ).paddingSymmetric(horizontal: 15.w),
              ),
              5.hSpace,
              Expanded(
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: DateTime(2000),
                  maximumDate: DateTime(DateTime.now().year - 24),
                  minimumDate: DateTime(DateTime.now().year - 120),
                  onDateTimeChanged: (DateTime date) {
                    setState(() {
                      selectedDate = date;
                    });
                  },
                ),
              ),
              10.hSpace,
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _consultationPriceController.dispose();
    _userNameController.dispose();
    _phoneController.dispose();
    _yourAgeController.dispose();
    super.dispose();
  }
}
