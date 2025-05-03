// ignore_for_file: inference_failure_on_function_invocation, document_ignores

import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/navigation_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/routes/routes.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:flutter/material.dart';

class ChangePasswordWidget extends StatelessWidget {
  const ChangePasswordWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.password, color: context.backgroundColor),
      title: Text(
        context.translate(LangKeys.changePassword),
        style: TextStyleApp.regular14().copyWith(color: context.onPrimaryColor),
      ),
      onTap: () => context.pushNamed(Routes.changePasswordScreen),
    );
  }
}
