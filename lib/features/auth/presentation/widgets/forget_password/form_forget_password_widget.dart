import 'package:curai_app_mobile/core/common/widgets/custom_button.dart';
import 'package:curai_app_mobile/core/common/widgets/custom_text_feild.dart';
import 'package:curai_app_mobile/core/extensions/context_navigation_extansions.dart';
import 'package:curai_app_mobile/core/extensions/context_system_extansions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FormForgetPasswordWidget extends StatefulWidget {
  const FormForgetPasswordWidget({super.key});

  @override
  State<FormForgetPasswordWidget> createState() =>
      _FormForgetPasswordWidgetState();
}

class _FormForgetPasswordWidgetState extends State<FormForgetPasswordWidget> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailOrPhoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final emailOrPhone = '${context.translate(LangKeys.email)}'
        ' ${context.translate(LangKeys.or)}'
        ' ${context.translate(LangKeys.yourNumber)}';
    return AutofillGroup(
      child: Form(
        key: formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            CustomTextFeild(
              labelText: emailOrPhone,
              autofillHints: const [
                AutofillHints.email,
                AutofillHints.telephoneNumber,
              ],
              keyboardType: TextInputType.emailAddress,
              controller: emailOrPhoneController,
            ),
            const Spacer(),
            CustemButton(
              title: LangKeys.resetPassword,
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  TextInput.finishAutofillContext();
                  formKey.currentState!.save();
                  context.pushNamed(Routes.otpVerification);
                }
                // context.pushNamed(Routes.mainScaffoldUser);
              },
            ),
          ],
        ),
      ),
    );
  }
}
