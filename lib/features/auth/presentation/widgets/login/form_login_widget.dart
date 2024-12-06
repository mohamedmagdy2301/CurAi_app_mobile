import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smartcare_app_mobile/core/common/widgets/custom_button.dart';
import 'package:smartcare_app_mobile/core/common/widgets/custom_text_feild.dart';
import 'package:smartcare_app_mobile/core/extensions/context_extansions.dart';
import 'package:smartcare_app_mobile/core/helper/functions_helper.dart';
import 'package:smartcare_app_mobile/core/language/lang_keys.dart';
import 'package:smartcare_app_mobile/core/routes/routes.dart';

class FormLoginWidget extends StatefulWidget {
  const FormLoginWidget({super.key});

  @override
  State<FormLoginWidget> createState() => _FormLoginWidgetState();
}

class _FormLoginWidgetState extends State<FormLoginWidget> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AutofillGroup(
      child: Form(
        key: formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            CustomTextFeild(
              labelText: context.translate(LangKeys.email),
              autofillHints: const [AutofillHints.email],
              keyboardType: TextInputType.emailAddress,
              controller: emailController,
            ),
            spaceHeight(20),
            CustomTextFeild(
              labelText: context.translate(LangKeys.password),
              autofillHints: const [AutofillHints.password],
              keyboardType: TextInputType.visiblePassword,
              controller: passwordController,
              obscureText: true,
            ),
            spaceHeight(15),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  context.translate(LangKeys.forgotPassword),
                  style: context.textTheme.bodyMedium!.copyWith(
                    color: context.colors.primaryColor,
                  ),
                ),
              ],
            ),
            spaceHeight(20),
            CustemButton(
              title: LangKeys.login,
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  TextInput.finishAutofillContext();
                  formKey.currentState!.save();
                  context.pushNamed(Routes.mainScaffoldUser);
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
