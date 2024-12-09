import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartcare_app_mobile/core/common/widgets/custom_button.dart';
import 'package:smartcare_app_mobile/core/common/widgets/custom_text_feild.dart';
import 'package:smartcare_app_mobile/core/extensions/context_extansions.dart';
import 'package:smartcare_app_mobile/core/helper/functions_helper.dart';
import 'package:smartcare_app_mobile/core/language/lang_keys.dart';
import 'package:smartcare_app_mobile/core/routes/routes.dart';
import 'package:smartcare_app_mobile/features/auth/presentation/widgets/height_valid_notifier_widget.dart';

class FormRegisterWidget extends StatefulWidget {
  const FormRegisterWidget({super.key});

  @override
  State<FormRegisterWidget> createState() => _FormRegisterWidgetState();
}

class _FormRegisterWidgetState extends State<FormRegisterWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  // A ValueNotifier to track the form validation status
  final ValueNotifier<bool> _isFormValidNotifier = ValueNotifier<bool>(true);

  final bool _isPasswordObscure = true;

  void _validateForm() {
    // Update the validation status in the notifier
    final isValid = _formKey.currentState?.validate() ?? false;
    _isFormValidNotifier.value = isValid;
  }

  void _onRegisterPressed(BuildContext context) {
    _validateForm();
    if (_isFormValidNotifier.value) {
      _formKey.currentState?.save();
      context.pushNamed(Routes.mainScaffoldUser);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          ValueListenableBuilder<bool>(
            valueListenable: _isFormValidNotifier,
            builder: (context, isValid, child) {
              return spaceHeight(isValid ? 20 : 10);
            },
          ),
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
            labelText: context.translate(LangKeys.yourNumber),
            keyboardType: TextInputType.phone,
            controller: _phoneController,
            onChanged: (_) => _validateForm(),
          ),
          HeightValidNotifier(isFormValidNotifier: _isFormValidNotifier),
          CustemButton(
            title: LangKeys.login,
            onPressed: () => _onRegisterPressed(context),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    _isFormValidNotifier.dispose();
    super.dispose();
  }
}
