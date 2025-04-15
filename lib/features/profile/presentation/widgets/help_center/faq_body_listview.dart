import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/features/profile/data/models/faq_list_data.dart';
import 'package:curai_app_mobile/features/profile/presentation/widgets/help_center/row_navigate_contact_us_widget.dart';
import 'package:flutter/material.dart';

class FAQBodyListView extends StatelessWidget {
  const FAQBodyListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: faqItems.length,
      itemBuilder: (context, index) {
        return CustomExpansionTile(
          title: context.isStateArabic
              ? faqItems[index]['question']!['ar']!
              : faqItems[index]['question']!['en']!,
          contentWidget: AutoSizeText(
            context.isStateArabic
                ? faqItems[index]['answer']!['ar']!
                : faqItems[index]['answer']!['en']!,
            style: TextStyleApp.regular18().copyWith(
              color: context.onSecondaryColor,
            ),
          ),
        ).paddingSymmetric(horizontal: 12, vertical: 8);
      },
    );
  }
}
