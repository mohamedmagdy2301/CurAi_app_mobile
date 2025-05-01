import 'package:curai_app_mobile/core/extensions/int_extensions.dart';
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/navigation_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
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
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContCompleteProfileFormWidget extends StatefulWidget {
  const ContCompleteProfileFormWidget({required this.isUserDoctor, super.key});
  final bool isUserDoctor;
  @override
  State<ContCompleteProfileFormWidget> createState() =>
      _ContCompleteProfileFormWidgetState();
}

class _ContCompleteProfileFormWidgetState
    extends State<ContCompleteProfileFormWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _consultationPriceController =
      TextEditingController();

  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();

  // A ValueNotifier to track the form validation status
  final ValueNotifier<bool> _isFormValidNotifier = ValueNotifier<bool>(true);

  int? selectedSpecialization;

  void _validateForDoctorForm() {
    final isValid = _formKey.currentState?.validate() ?? false;
    _specializationErrorText = selectedSpecialization == null
        ? context.isStateArabic
            ? 'من فضلك اختر التخصص'
            : 'Please select specialization'
        : null;
    setState(() {});
    _isFormValidNotifier.value = isValid && _specializationErrorText == null;
  }

  void _validateForPatientForm() {
    final isValid = _formKey.currentState?.validate() ?? false;

    _isFormValidNotifier.value = isValid;
  }

  void _onContCompletePressed(BuildContext context) {
    hideKeyboard();
    widget.isUserDoctor ? _validateForDoctorForm() : _validateForPatientForm();

    if (_isFormValidNotifier.value) {
      _formKey.currentState?.save();

      final profileRequest = widget.isUserDoctor
          ? ProfileRequest(
              role: 'doctor',
              consultationPrice: _consultationPriceController.text,
              specialization: selectedSpecialization,
              bio: _bioController.text,
            )
          : ProfileRequest(
              role: 'patient',
              location: _addressController.text,
              bio: _bioController.text,
            );
      context.read<AuthCubit>().editProfile(profileRequest: profileRequest);
    }
  }

  String? _specializationErrorText;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          if (!widget.isUserDoctor)
            HeightValidNotifier(isFormValidNotifier: _isFormValidNotifier),
          if (!widget.isUserDoctor)
            CustomTextFeild(
              labelText: context.translate(LangKeys.address),
              keyboardType: TextInputType.streetAddress,
              controller: _addressController,
              onChanged: (_) => widget.isUserDoctor
                  ? _validateForDoctorForm()
                  : _validateForPatientForm(),
            ),
          if (widget.isUserDoctor)
            HeightValidNotifier(isFormValidNotifier: _isFormValidNotifier),
          if (widget.isUserDoctor)
            CustomTextFeild(
              labelText: context.translate(LangKeys.consultationPrice),
              keyboardType: TextInputType.number,
              controller: _consultationPriceController,
              onChanged: (_) => widget.isUserDoctor
                  ? _validateForDoctorForm()
                  : _validateForPatientForm(),
            ),
          if (widget.isUserDoctor)
            HeightValidNotifier(isFormValidNotifier: _isFormValidNotifier),
          if (widget.isUserDoctor)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 10.h,
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
                      items: [
                        DropdownMenuItem(
                          value: 1,
                          child: Text(
                            'Audiologist',
                            style: TextStyleApp.regular16().copyWith(
                              color: context.onPrimaryColor,
                            ),
                          ),
                        ),
                        DropdownMenuItem(
                          value: 2,
                          child: Text(
                            'Allergist',
                            style: TextStyleApp.regular16().copyWith(
                              color: context.onPrimaryColor,
                            ),
                          ),
                        ),
                        DropdownMenuItem(
                          value: 3,
                          child: Text(
                            'Andrologists',
                            style: TextStyleApp.regular16().copyWith(
                              color: context.onPrimaryColor,
                            ),
                          ),
                        ),
                      ],
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
            ),
          HeightValidNotifier(isFormValidNotifier: _isFormValidNotifier),
          CustomTextFeild(
            labelText: context.translate(LangKeys.bio),
            keyboardType: TextInputType.text,
            controller: _bioController,
            maxLines: 3,
            isLable: false,
            onChanged: (_) => widget.isUserDoctor
                ? _validateForDoctorForm()
                : _validateForPatientForm(),
          ),
          HeightValidNotifier(isFormValidNotifier: _isFormValidNotifier),
          10.hSpace,
          _buildContCompleteButton(),
        ],
      ),
    );
  }

  BlocConsumer<AuthCubit, AuthState> _buildContCompleteButton() {
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
          onPressed: () => _onContCompletePressed(context),
        );
      },
    );
  }

  @override
  void dispose() {
    _addressController.dispose();
    _bioController.dispose();
    _consultationPriceController.dispose();
    _isFormValidNotifier.dispose();
    super.dispose();
  }
}
