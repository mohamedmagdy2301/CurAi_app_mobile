import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/dependency_injection/service_locator.dart'
    as di;
import 'package:curai_app_mobile/core/extensions/int_extensions.dart';
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/navigation_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/routes/routes.dart';
import 'package:curai_app_mobile/core/services/local_storage/shared_pref_key.dart';
import 'package:curai_app_mobile/core/services/local_storage/shared_preferences_manager.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/core/utils/helper/funcations_helper.dart';
import 'package:curai_app_mobile/core/utils/widgets/adaptive_dialogs/adaptive_dialogs.dart';
import 'package:curai_app_mobile/core/utils/widgets/custom_button.dart';
import 'package:curai_app_mobile/core/utils/widgets/custom_text_feild.dart';
import 'package:curai_app_mobile/core/utils/widgets/sankbar/snackbar_helper.dart';
import 'package:curai_app_mobile/features/auth/data/models/login/login_request.dart';
import 'package:curai_app_mobile/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:curai_app_mobile/features/auth/presentation/widgets/height_valid_notifier_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';

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
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

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
            context,
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
                return isValid ? 35.hSpace : 20.hSpace;
              },
            ),
            CustomTextFeild(
              labelText: context.translate(LangKeys.email),
              autofillHints: const [
                AutofillHints.email,
                AutofillHints.username,
              ],
              keyboardType: TextInputType.emailAddress,
              controller: _emailController,
              focusNode: _emailFocusNode,
              nextFocusNode: _passwordFocusNode,
              textInputAction: TextInputAction.next,
              onChanged: (_) => _validateForm(),
            ),
            HeightValidNotifier(isFormValidNotifier: _isFormValidNotifier),
            CustomTextFeild(
              labelText: context.translate(LangKeys.password),
              autofillHints: const [AutofillHints.password],
              keyboardType: TextInputType.visiblePassword,
              controller: _passwordController,
              focusNode: _passwordFocusNode,
              textInputAction: TextInputAction.done,
              obscureText: true,
              onChanged: (_) => _validateForm(),
            ),
            5.hSpace,
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => context.pushNamed(Routes.forgetPasswordScreen),
                child: AutoSizeText(
                  context.translate(LangKeys.forgotPassword),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyleApp.regular14().copyWith(
                    decoration: TextDecoration.underline,
                    decorationStyle: TextDecorationStyle.solid,
                    decorationColor: context.primaryColor,
                    color: context.primaryColor,
                  ),
                ),
              ),
            ),
            25.hSpace,
            _buildLoginButton(),
          ],
        ),
      ),
    );
  }

  BlocConsumer<AuthCubit, AuthState> _buildLoginButton() {
    return BlocConsumer<AuthCubit, AuthState>(
      listenWhen: (previous, current) =>
          current is LoginLoading ||
          current is LoginSuccess ||
          current is LoginError,
      buildWhen: (previous, current) =>
          current is LoginLoading ||
          current is LoginSuccess ||
          current is LoginError,
      listener: (context, state) {
        if (state is LoginError) {
          context.pop();

          showMessage(
            context,
            message: state.message,
            type: ToastificationType.error,
          );
          context.read<AuthCubit>().clearState();
        }
        if (state is LoginSuccess) {
          context.pop();
          showMessage(
            context,
            message: state.message,
            type: ToastificationType.success,
          );
          di.sl<CacheDataManager>().setData(
                key: SharedPrefKey.keyIsLoggedIn,
                value: true,
              );
          context.pushNamedAndRemoveUntil(Routes.mainScaffoldUser);
          context.read<AuthCubit>().clearState();
        }
        if (state is LoginLoading) {
          AdaptiveDialogs.showLoadingAlertDialog(
            context: context,
            title: context.translate(LangKeys.login),
          );
        }
      },
      builder: (context, state) {
        return CustomButton(
          title: LangKeys.login,
          isLoading: state is LoginLoading,
          onPressed: () => _onLoginPressed(context),
        );
      },
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
