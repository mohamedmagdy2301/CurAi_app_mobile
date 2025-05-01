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
import 'package:curai_app_mobile/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:curai_app_mobile/features/auth/presentation/widgets/height_valid_notifier_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CompleteProfileFormWidget extends StatefulWidget {
  const CompleteProfileFormWidget({super.key});

  @override
  State<CompleteProfileFormWidget> createState() =>
      _CompleteProfileFormWidgetState();
}

class _CompleteProfileFormWidgetState extends State<CompleteProfileFormWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _specializationController =
      TextEditingController();
  final TextEditingController _consultationPriceController =
      TextEditingController();

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _yourAgeController = TextEditingController();

  final ValueNotifier<bool> _isFormValidNotifier = ValueNotifier<bool>(true);

  String? selectedGender;

  void _validateForm() {
    final isValid = _formKey.currentState?.validate() ?? false;
    _genderErrorText = selectedGender == null
        ? context.isStateArabic
            ? 'من فضلك اختر النوع'
            : 'Please select gender'
        : null;
    setState(() {});
    _isFormValidNotifier.value = isValid && _genderErrorText == null;
  }

  void _onCompletePressed(BuildContext context) {
    hideKeyboard();
    _validateForm();
    // if (_isFormValidNotifier.value) {
    //   _formKey.currentState?.save();

    context.pushReplacementNamed(Routes.contCompleteProfileScreen);
    // }
  }

  String? _genderErrorText;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          HeightValidNotifier(isFormValidNotifier: _isFormValidNotifier),
          CustomTextFeild(
            labelText: context.translate(LangKeys.fullName),
            keyboardType: TextInputType.name,
            controller: _fullNameController,
            onChanged: (_) => _validateForm(),
          ),
          HeightValidNotifier(isFormValidNotifier: _isFormValidNotifier),
          CustomTextFeild(
            labelText: context.translate(LangKeys.phone),
            keyboardType: TextInputType.phone,
            controller: _phoneController,
            onChanged: (_) => _validateForm(),
          ),
          // HeightValidNotifier(isFormValidNotifier: _isFormValidNotifier),
          // CustomTextFeild(
          //   labelText: context.translate(LangKeys.medicalSpecialization),
          //   keyboardType: TextInputType.number,
          //   controller: _specializationController,
          //   onChanged: (_) => _validateForm(),
          // ),
          // HeightValidNotifier(isFormValidNotifier: _isFormValidNotifier),
          // CustomTextFeild(
          //   labelText: context.translate(LangKeys.consultationPrice),
          //   keyboardType: TextInputType.phone,
          //   controller: _consultationPriceController,
          //   onChanged: (_) => _validateForm(),
          // ),
          HeightValidNotifier(isFormValidNotifier: _isFormValidNotifier),
          CustomTextFeild(
            labelText: context.translate(LangKeys.yourAge),
            keyboardType: TextInputType.number,
            controller: _yourAgeController,
            onChanged: (_) => _validateForm(),
          ),
          HeightValidNotifier(isFormValidNotifier: _isFormValidNotifier),
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
          ),
          HeightValidNotifier(isFormValidNotifier: _isFormValidNotifier),
          20.hSpace,
          _buildCompleteButton(),
        ],
      ),
    );
  }

  BlocConsumer<AuthCubit, AuthState> _buildCompleteButton() {
    return BlocConsumer<AuthCubit, AuthState>(
      listenWhen: (previous, current) =>
          current is RegisterLoading ||
          current is RegisterSuccess ||
          current is RegisterError,
      listener: (context, state) {
        if (state is RegisterError) {
          Navigator.pop(context);
          showMessage(
            context,
            message: state.message,
            type: SnackBarType.error,
          );
        } else if (state is RegisterSuccess) {
          Navigator.pop(context);
          showMessage(
            context,
            message: state.message,
            type: SnackBarType.success,
          );
          context.pushNamed(Routes.loginScreen);
        } else if (state is RegisterLoading) {
          AdaptiveDialogs.showLoadingAlertDialog(
            context: context,
            title: context.translate(LangKeys.register),
          );
        }
      },
      builder: (context, state) {
        return CustomButton(
          title: LangKeys.completeProfile,
          onPressed: () => _onCompletePressed(context),
        );
      },
    );
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneController.dispose();
    _yourAgeController.dispose();
    _consultationPriceController.dispose();
    _isFormValidNotifier.dispose();
    _specializationController.dispose();
    super.dispose();
  }
}
