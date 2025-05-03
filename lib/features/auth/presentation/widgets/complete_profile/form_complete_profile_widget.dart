import 'dart:io';

import 'package:curai_app_mobile/core/extensions/int_extensions.dart';
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/navigation_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/routes/routes.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/core/utils/helper/funcations_helper.dart';
import 'package:curai_app_mobile/core/utils/widgets/adaptive_dialogs/adaptive_dialogs.dart';
import 'package:curai_app_mobile/core/utils/widgets/custom_button.dart';
import 'package:curai_app_mobile/core/utils/widgets/custom_text_feild.dart';
import 'package:curai_app_mobile/core/utils/widgets/sankbar/snackbar_helper.dart';
import 'package:curai_app_mobile/features/auth/data/models/profile/profile_request.dart';
import 'package:curai_app_mobile/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:curai_app_mobile/features/auth/presentation/widgets/height_valid_notifier_widget.dart';
import 'package:curai_app_mobile/features/home/data/models/specializations_model/specializations_model.dart';
import 'package:curai_app_mobile/features/home/presentation/widgets/doctor_speciality/specialization_widget.dart';
import 'package:curai_app_mobile/features/profile/presentation/widgets/image_profile_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class CompleteProfileFormWidget extends StatefulWidget {
  const CompleteProfileFormWidget({super.key});

  @override
  State<CompleteProfileFormWidget> createState() =>
      _CompleteProfileFormWidgetState();
}

class _CompleteProfileFormWidgetState extends State<CompleteProfileFormWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _consultationPriceController =
      TextEditingController();

  final TextEditingController _bioController = TextEditingController();

  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _yourAgeController = TextEditingController();

  final ValueNotifier<bool> _isFormValidNotifier = ValueNotifier<bool>(true);
  int? selectedSpecialization;
  String? selectedGender;

  String? _specializationErrorText;
  String? _genderErrorText;

  final ImagePicker imagePicker = ImagePicker();
  File? imageFile;
  String? imageUrl;
  bool isChanged = false;
  XFile? xFilePhoto;

  void _validateForm() {
    final isValid = _formKey.currentState?.validate() ?? false;
    _genderErrorText = selectedGender == null
        ? context.isStateArabic
            ? 'من فضلك اختر النوع'
            : 'Please select gender'
        : null;
    setState(() {});

    _specializationErrorText = selectedSpecialization == null
        ? context.isStateArabic
            ? 'من فضلك اختر التخصص'
            : 'Please select specialization'
        : null;
    setState(() {});
    _isFormValidNotifier.value =
        isValid && _genderErrorText == null && _specializationErrorText == null;
  }

  void _onCompletePressed(BuildContext context) {
    hideKeyboard();
    _validateForm();

    if (_isFormValidNotifier.value) {
      _formKey.currentState?.save();
      if (imageFile == null) {
        showMessage(
          context,
          message: context.isStateArabic
              ? 'من فضلك اختر صورة'
              : 'Please select image',
          type: SnackBarType.error,
        );
        return;
      }

      final ageText = _yourAgeController.text;

      if (!RegExp(r'^[0-9]+$').hasMatch(ageText)) {
        showMessage(
          context,
          message: context.isStateArabic
              ? 'من فضلك أدخل العمر بالأرقام فقط.\n'
                  'يمكنك اختيار العمر باستخدام الأيقونة'
              : 'Please enter your age as a number.\n'
                  'You can select age using the icon',
          showCloseIcon: true,
          type: SnackBarType.error,
        );
        return;
      }

      final age = int.parse(ageText);

      if (age < 24 || age > 120) {
        showMessage(
          context,
          message: context.isStateArabic
              ? 'العمر يجب أن يكون بين 24 و 120 سنة'
              : 'Age must be between 24 and 120 years',
          showCloseIcon: true,
          type: SnackBarType.error,
        );
        return;
      }
      final phoneRegex = RegExp(r'^(010|011|012|015)[0-9]{8}$');

      if (!phoneRegex.hasMatch(_phoneController.text)) {
        showMessage(
          context,
          message: context.isStateArabic
              ? 'من فضلك ادخل رقم هاتف صحيح'
              : 'Please enter a valid phone number',
          showCloseIcon: true,
          type: SnackBarType.error,
        );
        return;
      }
      final profileRequest = ProfileRequest(
        consultationPrice: _consultationPriceController.text.trim(),
        specialization: selectedSpecialization,
        bio: _bioController.text.trim(),
        phoneNumber: _phoneController.text.trim(),
        age: _yourAgeController.text.trim(),
        gender: selectedGender,
        imageFile: imageFile,
        isApproved: true,
      );
      context
          .read<AuthCubit>()
          .editProfile(context, profileRequest: profileRequest);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        spacing: _isFormValidNotifier.value ? 0.h : 6.h,
        children: [
          ImageProfileWidget(
            imageUrl: imageUrl,
            imageFile: imageFile,
            isEdit: true,
            onTap: () async {
              xFilePhoto = await imagePicker.pickImage(
                source: ImageSource.gallery,
              );
              if (xFilePhoto != null) {
                setState(() {
                  imageFile = File(xFilePhoto!.path);
                  imageUrl = imageFile!.path;
                });
              }
            },
          ).center(),
          HeightValidNotifier(isFormValidNotifier: _isFormValidNotifier),
          CustomTextFeild(
            labelText: context.translate(LangKeys.phone),
            keyboardType: TextInputType.phone,
            controller: _phoneController,
            hint: context.isStateArabic
                ? 'مثال: 01012345678'
                : 'e.g. 01012345678',
            onChanged: (_) => _validateForm(),
          ),
          HeightValidNotifier(isFormValidNotifier: _isFormValidNotifier),
          CustomTextFeild(
            labelText: context.translate(LangKeys.yourAge),
            keyboardType: TextInputType.number,
            controller: _yourAgeController,
            hint: context.isStateArabic ? 'مثال: 37' : 'e.g. 37',
            onChanged: (_) => _validateForm(),
            suffixIcon: InkWell(
              onTap: () => _showYearPicker(context),
              child: const Icon(CupertinoIcons.calendar),
            ),
          ),
          HeightValidNotifier(isFormValidNotifier: _isFormValidNotifier),
          _buildSelectSpecilization(context),
          HeightValidNotifier(isFormValidNotifier: _isFormValidNotifier),
          _buildSelectGender(context),
          HeightValidNotifier(isFormValidNotifier: _isFormValidNotifier),
          CustomTextFeild(
            labelText: context.translate(LangKeys.bio),
            keyboardType: TextInputType.text,
            hint: context.isStateArabic
                ? 'مثال: أخصائي أمراض القلب مع 10 سنوات من الخبرة في'
                    'مستشفى السلام ، متخصص في ارتفاع ضغط الدم وأمراض القلب.'
                : 'e.g. Cardiologist with 10+ years of experience at '
                    'Al Salam Hospital, specialized in hypertension '
                    'and heart diseases.',
            controller: _bioController,
            maxLines: 2,
            isLable: false,
            onChanged: (_) => _validateForm(),
          ),
          HeightValidNotifier(isFormValidNotifier: _isFormValidNotifier),
          _buildCompleteButton(),
        ],
      ),
    );
  }

  Column _buildSelectGender(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(
              color: _genderErrorText != null
                  ? Colors.redAccent
                  : context.primaryColor.withAlpha(100),
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
                  _genderErrorText = null;
                });
              },
            ),
          ),
        ),
        if (_genderErrorText != null)
          Padding(
            padding: EdgeInsets.only(top: 5.h, left: 8.w),
            child: Text(
              _genderErrorText!,
              style: TextStyleApp.regular12().copyWith(
                color: Colors.redAccent,
              ),
            ),
          ),
      ],
    );
  }

  Column _buildSelectSpecilization(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(
              color: _specializationErrorText != null
                  ? Colors.redAccent
                  : context.primaryColor.withAlpha(100),
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
              hint: Text(
                context.translate(LangKeys.medicalSpecialization),
                style: TextStyleApp.regular16().copyWith(
                  color: context.primaryColor,
                ),
              ),
              items: specializationsList
                  .map(
                    (spec) => DropdownMenuItem<int>(
                      value: spec['id'] as int,
                      child: Text(
                        specializationName(
                          spec['name'] as String,
                          context.isStateArabic,
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
                  _specializationErrorText = null;
                });
              },
            ),
          ),
        ),
        if (_specializationErrorText != null)
          Padding(
            padding: EdgeInsets.only(top: 5.h, left: 8.w),
            child: Text(
              _specializationErrorText!,
              style: TextStyleApp.regular12().copyWith(
                color: Colors.redAccent,
              ),
            ),
          ),
      ],
    );
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

  Widget _buildCompleteButton() {
    return BlocConsumer<AuthCubit, AuthState>(
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
          context
            ..pop()
            ..pushReplacementNamed(Routes.loginScreen);
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
            title: context.translate(LangKeys.completeProfileTitle),
          );
        }
      },
      builder: (context, state) {
        return CustomButton(
          title: LangKeys.completeProfile,
          isLoading: state is EditProfileLoading,
          onPressed: () => _onCompletePressed(context),
        );
      },
    );
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _yourAgeController.dispose();

    _isFormValidNotifier.dispose();
    super.dispose();
  }
}
