// ignore_for_file: inference_failure_on_function_invocation

import 'package:curai_app_mobile/core/extensions/int_extensions.dart';
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/features/profile/presentation/widgets/help_center/customer_service_form_widget.dart';
import 'package:curai_app_mobile/features/profile/presentation/widgets/help_center/row_navigate_contact_us_widget.dart';
import 'package:flutter/material.dart';

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
