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
import 'package:toastification/toastification.dart';

class RegistrationFormWidget extends StatefulWidget {
  const RegistrationFormWidget({super.key});

  @override
  State<RegistrationFormWidget> createState() => _RegistrationFormWidgetState();
}

class _RegistrationFormWidgetState extends State<RegistrationFormWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _userNameFocus = FocusNode();
  final _firstNameFocus = FocusNode();
  final _lastNameFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final _confirmPasswordFocus = FocusNode();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final ValueNotifier<bool> _isFormValidNotifier = ValueNotifier<bool>(true);

  final bool _isPasswordObscure = true;

  void _validateForm() {
    final isValid = _formKey.currentState?.validate() ?? false;
    _isFormValidNotifier.value = isValid;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          chooseUserType(context),
          20.hSpace,
          CustomTextFeild(
            labelText: context.translate(LangKeys.userName),
            keyboardType: TextInputType.name,
            controller: _userNameController,
            hint: context.isStateArabic ? 'مثال: @username' : 'e.g. @username',
            onChanged: (_) => _validateForm(),
            focusNode: _userNameFocus,
            nextFocusNode: _firstNameFocus,
            textInputAction: TextInputAction.next,
          ),
          HeightValidNotifier(isFormValidNotifier: _isFormValidNotifier),
          CustomTextFeild(
            labelText: context.translate(LangKeys.firstName),
            keyboardType: TextInputType.name,
            controller: _firstNameController,
            onChanged: (_) => _validateForm(),
            focusNode: _firstNameFocus,
            nextFocusNode: _lastNameFocus,
            textInputAction: TextInputAction.next,
          ),
          HeightValidNotifier(isFormValidNotifier: _isFormValidNotifier),
          CustomTextFeild(
            labelText: context.translate(LangKeys.lastName),
            keyboardType: TextInputType.name,
            controller: _lastNameController,
            onChanged: (_) => _validateForm(),
            focusNode: _lastNameFocus,
            nextFocusNode: _emailFocus,
            textInputAction: TextInputAction.next,
          ),
          HeightValidNotifier(isFormValidNotifier: _isFormValidNotifier),
          CustomTextFeild(
            labelText: context.translate(LangKeys.email),
            keyboardType: TextInputType.emailAddress,
            controller: _emailController,
            hint: context.isStateArabic
                ? 'مثال: username.${DateTime.now().year}@example.com'
                : 'e.g. username.${DateTime.now().year}@example.com',
            onChanged: (_) => _validateForm(),
            focusNode: _emailFocus,
            nextFocusNode: _passwordFocus,
            textInputAction: TextInputAction.next,
          ),
          HeightValidNotifier(isFormValidNotifier: _isFormValidNotifier),
          CustomTextFeild(
            labelText: context.translate(LangKeys.password),
            keyboardType: TextInputType.visiblePassword,
            controller: _passwordController,
            obscureText: _isPasswordObscure,
            hint:
                context.isStateArabic ? 'مثال: XYZ@123xyz' : 'e.g. XYZ@123xyz',
            onChanged: (_) => _validateForm(),
            focusNode: _passwordFocus,
            nextFocusNode: _confirmPasswordFocus,
            textInputAction: TextInputAction.next,
          ),
          HeightValidNotifier(isFormValidNotifier: _isFormValidNotifier),
          CustomTextFeild(
            labelText: context.translate(LangKeys.confirmPassword),
            keyboardType: TextInputType.visiblePassword,
            controller: _confirmPasswordController,
            obscureText: _isPasswordObscure,
            onChanged: (_) => _validateForm(),
            focusNode: _confirmPasswordFocus,
            textInputAction: TextInputAction.done,
          ),
          HeightValidNotifier(isFormValidNotifier: _isFormValidNotifier),
          5.hSpace,
          _buildRegisterButton(),
        ],
      ),
    );
  }

  BlocConsumer<AuthCubit, AuthState> _buildRegisterButton() {
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
            type: ToastificationType.error,
          );
          context.read<AuthCubit>().clearState();
        } else if (state is RegisterSuccess) {
          Navigator.pop(context);
          showMessage(
            context,
            message: state.message,
            type: ToastificationType.success,
          );
          if (userType == 'patient') {
            context.pushReplacementNamed(Routes.loginScreen);
          } else {
            context.pushReplacementNamed(Routes.completeProfileScreen);
          }
          context.read<AuthCubit>().clearState();
        } else if (state is RegisterLoading) {
          AdaptiveDialogs.showLoadingAlertDialog(
            context: context,
            title: context.translate(LangKeys.register),
          );
        }
      },
      builder: (context, state) {
        return CustomButton(
          title: LangKeys.register,
          isLoading: state is RegisterLoading,
          onPressed: () => _onRegisterPressed(context),
        );
      },
    );
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
          type: ToastificationType.error,
        );
        return;
      }
      context.read<AuthCubit>().register(
            context,
            RegisterRequest(
              email: _emailController.text.trim(),
              password: _passwordController.text.trim(),
              username: _userNameController.text.trim(),
              confirmPassword: _confirmPasswordController.text.trim(),
              role: userType,
              firstName: _firstNameController.text.trim(),
              lastName: _lastNameController.text.trim(),
            ),
          );
    }
  }

  String userType = 'patient';

  Widget chooseUserType(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: ['patient', 'doctor'].map((String type) {
        final isSelected = userType == type;
        return ChoiceChip(
          checkmarkColor: Colors.white,
          label: Row(
            children: [
              if (isSelected) 15.wSpace else 30.wSpace,
              Text(
                type == 'patient'
                    ? context.translate(LangKeys.patient)
                    : context.translate(LangKeys.doctor),
                style: TextStyleApp.regular20().copyWith(
                  color: isSelected ? Colors.white : context.primaryColor,
                ),
              ),
              if (isSelected) 15.wSpace else 30.wSpace,
            ],
          ),
          selected: isSelected,
          selectedColor: context.primaryColor,
          backgroundColor: context.backgroundColor,
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          labelStyle: TextStyleApp.medium20().copyWith(
            color: isSelected ? Colors.white : context.primaryColor,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
            side: BorderSide(color: context.primaryColor),
          ),
          onSelected: (bool selected) {
            setState(() {
              userType =
                  (selected ? type.toLowerCase() : userType.toLowerCase());
            });
          },
        );
      }).toList(),
    );
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _isFormValidNotifier.dispose();
    super.dispose();
  }
}
