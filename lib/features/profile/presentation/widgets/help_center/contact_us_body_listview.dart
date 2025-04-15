// ignore_for_file: inference_failure_on_function_invocation

import 'package:curai_app_mobile/core/extensions/int_extensions.dart';
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/navigation_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/utils/widgets/custom_button.dart';
import 'package:curai_app_mobile/core/utils/widgets/custom_text_feild.dart';
import 'package:curai_app_mobile/features/profile/presentation/widgets/help_center/row_navigate_contact_us_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContactUsBodyListview extends StatelessWidget {
  const ContactUsBodyListview({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        CustomNavagationTile(
          title: context.translate(LangKeys.customerService),
          leadingIcon: const Icon(Icons.support_agent_outlined),
          onTap: () {
            showModalBottomSheet(
              context: context,
              backgroundColor: context.backgroundColor,
              isScrollControlled: true,
              builder: (context) => const CustomerServiceFormWidget(),
            );
          },
          // contentWidget: const CustomerServiceFormWidget(),
        ),
        20.hSpace,
        CustomExpansionTile(
          leadingIcon: const Icon(Icons.email_outlined),
          title: context.translate(LangKeys.email),
        ),
        20.hSpace,
        CustomExpansionTile(
          leadingIcon: const Icon(Icons.phone),
          contentWidget: const Text('123456789'),
          title: context.translate(LangKeys.phone),
        ),
        20.hSpace,
        CustomExpansionTile(
          leadingIcon: const Icon(Icons.email_outlined),
          title: context.translate(LangKeys.email),
        ),
        20.hSpace,
        CustomExpansionTile(
          leadingIcon: const Icon(Icons.phone),
          contentWidget: const Text('123456789'),
          title: context.translate(LangKeys.phone),
        ),
        20.hSpace,
        CustomExpansionTile(
          leadingIcon: const Icon(Icons.email_outlined),
          title: context.translate(LangKeys.email),
        ),
      ],
    ).paddingSymmetric(horizontal: 15, vertical: 10);
  }
}

class CustomerServiceFormWidget extends StatefulWidget {
  const CustomerServiceFormWidget({
    super.key,
  });

  @override
  State<CustomerServiceFormWidget> createState() =>
      _CustomerServiceFormWidgetState();
}

class _CustomerServiceFormWidgetState extends State<CustomerServiceFormWidget> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  void onPressed() {
    if (_formKey.currentState!.validate()) {
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          spacing: 15.h,
          children: [
            0.hSpace,
            CustomTextFeild(
              labelText: context.translate(LangKeys.fullName),
              controller: _fullNameController,
              isLable: false,
            ),
            CustomTextFeild(
              labelText: context.translate(LangKeys.email),
              controller: _emailController,
              isLable: false,
            ),
            CustomTextFeild(
              labelText: context.translate(LangKeys.howDoWeHelpYou),
              controller: _messageController,
              isLable: false,
              maxLines: 5,
            ),
            CustomButton(
              title: LangKeys.send,
              onPressed: onPressed,
            ),
          ],
        ).paddingSymmetric(horizontal: 20, vertical: 10),
      ),
    );
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }
}
