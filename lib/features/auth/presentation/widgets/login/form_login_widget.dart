import 'package:curai_app_mobile/core/common/widgets/custom_button.dart';
import 'package:curai_app_mobile/core/common/widgets/custom_text_feild.dart';
import 'package:curai_app_mobile/core/extensions/context_navigation_extansions.dart';
import 'package:curai_app_mobile/core/extensions/context_sizer_extansions.dart';
import 'package:curai_app_mobile/core/extensions/context_system_extansions.dart';
import 'package:curai_app_mobile/core/helper/functions_helper.dart';
import 'package:curai_app_mobile/core/helper/snackbar_helper.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/routes/routes.dart';
import 'package:curai_app_mobile/features/auth/data/models/login/login_request.dart';
import 'package:curai_app_mobile/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:curai_app_mobile/features/auth/presentation/widgets/height_valid_notifier_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FormLoginWidget extends StatefulWidget {
  const FormLoginWidget({super.key});

  @override
  State<FormLoginWidget> createState() => _FormLoginWidgetState();
}

class _FormLoginWidgetState extends State<FormLoginWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final ValueNotifier<bool> _isFormValidNotifier = ValueNotifier<bool>(true);

  void _validateForm() {
    final isValid = _formKey.currentState?.validate() ?? false;
    _isFormValidNotifier.value = isValid;
  }

  void _onLoginPressed(BuildContext context) {
    hideKeyboard();
    _validateForm();
    if (_isFormValidNotifier.value) {
      TextInput.finishAutofillContext();
      _formKey.currentState?.save();
      context.read<AuthCubit>().login(
            LoginRequest(
              email: _emailController.text.trim(),
              password: _passwordController.text.trim(),
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AutofillGroup(
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            ValueListenableBuilder<bool>(
              valueListenable: _isFormValidNotifier,
              builder: (context, isValid, child) {
                return context.spaceHeight(isValid ? 35 : 20);
              },
            ),
            CustomTextFeild(
              labelText: context.translate(LangKeys.email),
              autofillHints: const [AutofillHints.email],
              keyboardType: TextInputType.emailAddress,
              controller: _emailController,
              onChanged: (_) => _validateForm(),
            ),
            HeightValidNotifier(isFormValidNotifier: _isFormValidNotifier),
            CustomTextFeild(
              labelText: context.translate(LangKeys.password),
              autofillHints: const [AutofillHints.password],
              keyboardType: TextInputType.visiblePassword,
              controller: _passwordController,
              obscureText: true,
              onChanged: (_) => _validateForm(),
            ),
            HeightValidNotifier(isFormValidNotifier: _isFormValidNotifier),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () =>
                      context.pushNamed(Routes.forgetPasswordScreen),
                  child: Text(
                    context.translate(LangKeys.forgotPassword),
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: context.colors.primary,
                    ),
                  ),
                ),
              ],
            ),
            context.spaceHeight(15),
            BlocConsumer<AuthCubit, AuthState>(
              listenWhen: (previous, current) =>
                  current is LoginLoading ||
                  current is LoginSuccess ||
                  current is LoginError,
              listener: (context, state) {
                if (state is LoginError) {
                  showMessage(
                    context,
                    message: state.message,
                    type: SnackBarType.error,
                  );
                } else if (state is LoginSuccess) {
                  showMessage(
                    context,
                    message: state.message,
                    type: SnackBarType.success,
                  );
                  context.pushNamed(Routes.mainScaffoldUser);
                }
              },
              builder: (context, state) {
                return CustomButton(
                  title: LangKeys.login,
                  isLoading: state is LoginLoading,
                  onPressed: () => _onLoginPressed(context),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _isFormValidNotifier.dispose();
    super.dispose();
  }
}
