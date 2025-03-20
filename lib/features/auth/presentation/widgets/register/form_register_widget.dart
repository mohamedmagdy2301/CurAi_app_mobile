import 'package:curai_app_mobile/core/common/widgets/custom_button.dart';
import 'package:curai_app_mobile/core/common/widgets/custom_text_feild.dart';
import 'package:curai_app_mobile/core/extensions/context_navigation_extansions.dart';
import 'package:curai_app_mobile/core/extensions/context_sizer_extansions.dart';
import 'package:curai_app_mobile/core/extensions/context_system_extansions.dart';
import 'package:curai_app_mobile/core/helper/functions_helper.dart';
import 'package:curai_app_mobile/core/helper/snackbar_helper.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/routes/routes.dart';
import 'package:curai_app_mobile/features/auth/data/models/register/register_request.dart';
import 'package:curai_app_mobile/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:curai_app_mobile/features/auth/presentation/widgets/height_valid_notifier_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  // A ValueNotifier to track the form validation status
  final ValueNotifier<bool> _isFormValidNotifier = ValueNotifier<bool>(true);

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
            labelText: context.translate(LangKeys.email),
            keyboardType: TextInputType.emailAddress,
            controller: _emailController,
            onChanged: (_) => _validateForm(),
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
          context.spaceHeight(5),
          BlocConsumer<AuthCubit, AuthState>(
            listenWhen: (previous, current) =>
                current is RegisterLoading ||
                current is RegisterSuccess ||
                current is RegisterError,
            listener: (context, state) {
              if (state is RegisterError) {
                showMessage(
                  context,
                  message: state.message,
                  type: SnackBarType.error,
                );
              } else if (state is RegisterSuccess) {
                showMessage(
                  context,
                  message: state.message,
                  type: SnackBarType.success,
                );
                context.pushNamed(Routes.loginScreen);
              }
            },
            builder: (context, state) {
              return CustomButton(
                title: LangKeys.register,
                isLoading: state is RegisterLoading,
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
