// ignore_for_file: inference_failure_on_function_invocation

import 'package:curai_app_mobile/core/extensions/context_system_extansions.dart';
import 'package:curai_app_mobile/core/extensions/styletext_context_extansions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:flutter/material.dart';

class ChangePasswordWidget extends StatelessWidget {
  const ChangePasswordWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.password, color: context.color.primary),
      title: Text(
        context.translate(LangKeys.changePassword),
        style: context.styleRegular14,
      ),
      onTap: () {
        // context.read<AuthCubit>().changePassword();
      },
    );
  }
}
