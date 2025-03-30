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
import 'package:curai_app_mobile/features/auth/data/models/register/register_request.dart';
import 'package:curai_app_mobile/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:curai_app_mobile/features/auth/presentation/widgets/height_valid_notifier_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegistrationFormWidget extends StatefulWidget {
  const RegistrationFormWidget({super.key});

  @override
  State<RegistrationFormWidget> createState() => _RegistrationFormWidgetState();
}

class _RegistrationFormWidgetState extends State<RegistrationFormWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _yourAgeController = TextEditingController();
  // A ValueNotifier to track the form validation status
  final ValueNotifier<bool> _isFormValidNotifier = ValueNotifier<bool>(true);

  String? selectedGender;

  final bool _isPasswordObscure = true;

  void _validateForm() {
    final isValid = _formKey.currentState?.validate() ?? false;
    _isFormValidNotifier.value = isValid;
  }

  void _onRegisterPressed(BuildContext context) {
    hideKeyboard();
    _validateForm();
    if (_isFormValidNotifier.value) {
      _formKey.currentState?.save();
      if (_passwordController.text != _confirmPasswordController.text) {
        showMessage(
          context,
          message: context.translate(LangKeys.passwordNotMatch),
          type: SnackBarType.error,
        );
        return;
      }
      context.read<AuthCubit>().register(
            RegisterRequest(
              email: _emailController.text.trim(),
              password: _passwordController.text.trim(),
              username: _userNameController.text.trim(),
              confirmPassword: _confirmPasswordController.text.trim(),
              fullName: _fullNameController.text,
              phoneNumber: _phoneController.text,
              location: _addressController.text,
              age: int.parse(_yourAgeController.text),
              gender: selectedGender ?? 'male',
              specialization: '1',
              consultationPrice: '100',
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          HeightValidNotifier(isFormValidNotifier: _isFormValidNotifier),
          CustomTextFeild(
            labelText: context.translate(LangKeys.userName),
            keyboardType: TextInputType.name,
            controller: _userNameController,
            onChanged: (_) => _validateForm(),
          ),
          HeightValidNotifier(isFormValidNotifier: _isFormValidNotifier),
          CustomTextFeild(
            labelText: context.translate(LangKeys.fullName),
            keyboardType: TextInputType.name,
            controller: _fullNameController,
            onChanged: (_) => _validateForm(),
          ),
          HeightValidNotifier(isFormValidNotifier: _isFormValidNotifier),
          CustomTextFeild(
            labelText: context.translate(LangKeys.email),
            keyboardType: TextInputType.emailAddress,
            controller: _emailController,
            onChanged: (_) => _validateForm(),
          ),
          HeightValidNotifier(isFormValidNotifier: _isFormValidNotifier),
          CustomTextFeild(
            labelText: context.translate(LangKeys.phone),
            keyboardType: TextInputType.phone,
            controller: _phoneController,
            onChanged: (_) => _validateForm(),
          ),
          HeightValidNotifier(isFormValidNotifier: _isFormValidNotifier),
          CustomTextFeild(
            labelText: context.translate(LangKeys.address),
            keyboardType: TextInputType.streetAddress,
            controller: _addressController,
            onChanged: (_) => _validateForm(),
          ),
          HeightValidNotifier(isFormValidNotifier: _isFormValidNotifier),
          SizedBox(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: context.W * .3,
                  child: CustomTextFeild(
                    labelText: context.translate(LangKeys.yourAge),
                    keyboardType: TextInputType.number,
                    controller: _yourAgeController,
                    onChanged: (_) => _validateForm(),
                  ),
                ),
                Container(
                  width: context.W * .55,
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 15.h,
                  ),
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
                      hint: Text(
                        context.translate(LangKeys.gender),
                        style: TextStyleApp.regular16().copyWith(
                          color: context.primaryColor,
                        ),
                      ),
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
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          HeightValidNotifier(isFormValidNotifier: _isFormValidNotifier),
          CustomTextFeild(
            labelText: context.translate(LangKeys.password),
            keyboardType: TextInputType.visiblePassword,
            controller: _passwordController,
            obscureText: _isPasswordObscure,
            onChanged: (_) => _validateForm(),
          ),
          HeightValidNotifier(isFormValidNotifier: _isFormValidNotifier),
          CustomTextFeild(
            labelText: context.translate(LangKeys.confirmPassword),
            keyboardType: TextInputType.visiblePassword,
            controller: _confirmPasswordController,
            obscureText: _isPasswordObscure,
            onChanged: (_) => _validateForm(),
          ),
          HeightValidNotifier(isFormValidNotifier: _isFormValidNotifier),
          5.hSpace,
          BlocConsumer<AuthCubit, AuthState>(
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
                AdaptiveDialogs.shoLoadingAlertDialog(
                  context: context,
                  title: context.translate(LangKeys.register),
                );
              }
            },
            builder: (context, state) {
              return CustomButton(
                title: LangKeys.completeProfile,
                onPressed: () => _onRegisterPressed(context),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _isFormValidNotifier.dispose();
    super.dispose();
  }
}
