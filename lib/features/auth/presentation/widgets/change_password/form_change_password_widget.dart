import 'package:curai_app_mobile/core/extensions/int_extensions.dart';
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/navigation_context_extansions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/routes/routes.dart';
import 'package:curai_app_mobile/core/utils/helper/funcations_helper.dart';
import 'package:curai_app_mobile/core/utils/widgets/adaptive_dialogs/adaptive_dialogs.dart';
import 'package:curai_app_mobile/core/utils/widgets/custom_button.dart';
import 'package:curai_app_mobile/core/utils/widgets/custom_text_feild.dart';
import 'package:curai_app_mobile/core/utils/widgets/sankbar/snackbar_helper.dart';
import 'package:curai_app_mobile/features/auth/data/models/change_password/change_password_request.dart';
import 'package:curai_app_mobile/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:curai_app_mobile/features/auth/presentation/widgets/height_valid_notifier_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';

class FormChangePasswordWidget extends StatefulWidget {
  const FormChangePasswordWidget({super.key});

  @override
  State<FormChangePasswordWidget> createState() =>
      _FormChangePasswordWidgetState();
}

class _FormChangePasswordWidgetState extends State<FormChangePasswordWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmNewPasswordController =
      TextEditingController();
  final ValueNotifier<bool> _isFormValidNotifier = ValueNotifier<bool>(true);

  void _validateForm() {
    final isValid = _formKey.currentState?.validate() ?? false;
    _isFormValidNotifier.value = isValid;
  }

  void _onChangePasswordPressed(BuildContext context) {
    hideKeyboard();
    _validateForm();
    if (_isFormValidNotifier.value) {
      _formKey.currentState?.save();
      if (_newPasswordController.text.trim() !=
          _confirmNewPasswordController.text.trim()) {
        showMessage(
          context,
          message: context.translate(LangKeys.passwordNotMatch),
          type: ToastificationType.error,
        );
        return;
      }
      context.read<AuthCubit>().changePassword(
            context,
            ChangePasswordRequest(
              currentPassword: _currentPasswordController.text.trim(),
              newPassword: _newPasswordController.text.trim(),
              confirmNewPassword: _confirmNewPasswordController.text.trim(),
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
              labelText: context.translate(LangKeys.currentPassword),
              keyboardType: TextInputType.visiblePassword,
              controller: _currentPasswordController,
              obscureText: true,
              onChanged: (_) => _validateForm(),
            ),
            HeightValidNotifier(isFormValidNotifier: _isFormValidNotifier),
            CustomTextFeild(
              labelText: context.translate(LangKeys.newPassword),
              autofillHints: const [AutofillHints.password],
              keyboardType: TextInputType.visiblePassword,
              controller: _newPasswordController,
              obscureText: true,
              onChanged: (_) => _validateForm(),
            ),
            HeightValidNotifier(isFormValidNotifier: _isFormValidNotifier),
            CustomTextFeild(
              labelText: context.translate(LangKeys.confirmNewPassword),
              autofillHints: const [AutofillHints.password],
              keyboardType: TextInputType.visiblePassword,
              controller: _confirmNewPasswordController,
              obscureText: true,
              onChanged: (_) => _validateForm(),
            ),
            HeightValidNotifier(isFormValidNotifier: _isFormValidNotifier),
            10.hSpace,
            BlocConsumer<AuthCubit, AuthState>(
              listenWhen: (previous, current) =>
                  current is ChangePasswordLoading ||
                  current is ChangePasswordSuccess ||
                  current is ChangePasswordError,
              listener: (context, state) {
                if (state is ChangePasswordError) {
                  context.pop();
                  showMessage(
                    context,
                    message: state.message,
                    type: ToastificationType.error,
                  );
                  context.read<AuthCubit>().clearState();
                } else if (state is ChangePasswordSuccess) {
                  showMessage(
                    context,
                    message: state.message,
                    type: ToastificationType.success,
                  );
                  context.pushNamed(Routes.loginScreen);
                  context.read<AuthCubit>().clearState();
                } else if (state is ChangePasswordLoading) {
                  AdaptiveDialogs.showLoadingAlertDialog(
                    context: context,
                    title: context.translate(LangKeys.changePassword),
                  );
                }
              },
              builder: (context, state) {
                return CustomButton(
                  title: LangKeys.changePassword,
                  onPressed: () => _onChangePasswordPressed(context),
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
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmNewPasswordController.dispose();
    _isFormValidNotifier.dispose();
    super.dispose();
  }
}
