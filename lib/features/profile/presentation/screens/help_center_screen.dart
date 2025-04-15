// ignore_for_file: lines_longer_than_80_chars, avoid_field_initializers_in_const_classes, document_ignores

import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/features/profile/presentation/widgets/help_center/contact_us_body_listview.dart';
import 'package:curai_app_mobile/features/profile/presentation/widgets/help_center/faq_body_listview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HelpCenterScreen extends StatefulWidget {
  const HelpCenterScreen({super.key});

  @override
  State<HelpCenterScreen> createState() => _HelpCenterScreenState();
}

class _HelpCenterScreenState extends State<HelpCenterScreen>
    with TickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(color: context.backgroundColor),
        title: AutoSizeText(
          context.translate(LangKeys.helpCenter),
          maxLines: 1,
          style: TextStyleApp.bold22().copyWith(
            color: context.onPrimaryColor,
          ),
        ),
        bottom: TabBar(
          labelColor: context.primaryColor,
          unselectedLabelColor: context.onPrimaryColor,
          indicatorColor: context.primaryColor,
          indicatorWeight: 3.w,
          indicatorSize: TabBarIndicatorSize.tab,
          labelStyle: TextStyleApp.bold16().copyWith(
            color: context.primaryColor,
          ),
          unselectedLabelStyle: TextStyleApp.regular16().copyWith(
            color: context.onPrimaryColor,
          ),
          dividerColor: context.onSecondaryColor.withAlpha(120),
          overlayColor: WidgetStateProperty.all(
            context.primaryColor.withAlpha(25),
          ),
          controller: tabController,
          onTap: (value) {
            setState(() {});
            tabController.index = value;
          },
          tabs: [
            Tab(text: context.translate(LangKeys.faq)),
            Tab(text: context.translate(LangKeys.contactUs)),
          ],
        ),
        centerTitle: true,
      ),
      body: _bodyWidget[tabController.index],
    );
  }

  final List<Widget> _bodyWidget = [
    const FAQBodyListView(),
    const ContactUsBodyListview(),
  ];
}
