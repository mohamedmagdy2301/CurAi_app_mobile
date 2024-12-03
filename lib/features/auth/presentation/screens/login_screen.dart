import 'package:flutter/material.dart';
import 'package:smartcare_app_mobile/core/extensions/context_extansions.dart';
import 'package:smartcare_app_mobile/core/helper/functions_helper.dart';
import 'package:smartcare_app_mobile/core/language/lang_keys.dart';
import 'package:smartcare_app_mobile/core/styles/fonts/font_weight_helper.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: padding(horizontal: 20, vertical: 20),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                spaceHeight(30),
                Text(
                  context.translate(LangKeys.welcomBack),
                  style: context.textTheme.headlineLarge!.copyWith(
                    color: context.colors.primaryColor,
                    fontWeight: FontWeightHelper.extraBold,
                  ),
                ),
                spaceHeight(10),
                Text(
                  context.translate(LangKeys.descraptionLogin),
                  style: context.textTheme.bodyMedium!.copyWith(
                    color: context.colors.textColorLight,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
