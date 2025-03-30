import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/navigation_context_extansions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/routes/routes.dart';
import 'package:curai_app_mobile/core/utils/widgets/custom_button.dart';
import 'package:curai_app_mobile/core/utils/widgets/custom_text_feild.dart';
import 'package:flutter/material.dart';

class ResetPasswordFormWidget extends StatefulWidget {
  const ResetPasswordFormWidget({super.key});

  @override
  State<ResetPasswordFormWidget> createState() =>
      _ResetPasswordFormWidgetState();
}

class _ResetPasswordFormWidgetState extends State<ResetPasswordFormWidget> {
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
            CustomButton(
              title: LangKeys.resetPassword,
              onPressed: () {
                // if (formKey.currentState!.validate()) {
                // TextInput.finishAutofillContext();
                // formKey.currentState!.save();
                context.pushNamed(Routes.otpVerification);
                // }
                // context.pushNamed(Routes.mainScaffoldUser);
              },
            ),
          ],
        ),
      ),
    );
  }
}
