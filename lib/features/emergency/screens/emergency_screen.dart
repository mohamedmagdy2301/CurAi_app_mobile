// ignore_for_file: lines_longer_than_80_chars, avoid_field_initializers_in_const_classes, document_ignores

import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/extensions/int_extensions.dart';
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/core/utils/helper/url_launcher_helper.dart';
import 'package:curai_app_mobile/features/emergency/data/emergency_data_ar.dart';
import 'package:curai_app_mobile/features/emergency/data/emergency_data_en.dart';
import 'package:curai_app_mobile/features/profile/presentation/widgets/help_center/row_navigate_contact_us_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmergencyScreen extends StatefulWidget {
  const EmergencyScreen({super.key});

  @override
  State<EmergencyScreen> createState() => _EmergencyScreenState();
}

class _EmergencyScreenState extends State<EmergencyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(color: context.backgroundColor),
        title: AutoSizeText(
          context.translate(LangKeys.emergencyDepartment),
          maxLines: 1,
          style: TextStyleApp.bold22().copyWith(
            color: context.onPrimaryColor,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => UrlLauncherHelper.launchPhoneCall(context, '123'),
            icon: Icon(
              CupertinoIcons.phone,
              color: context.onPrimaryColor,
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: context.isStateArabic
            ? emergencyDataArList.length
            : emergencyDataEnList.length,
        itemBuilder: (context, index) {
          return CustomExpansionTile(
            title: context.isStateArabic
                ? (emergencyDataArList[index]['condition']) as String
                : emergencyDataEnList[index]['condition'] as String,
            contentWidget: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AutoSizeText(
                  context.isStateArabic ? 'الاعراض: ' : 'Symptoms:',
                  style: TextStyleApp.regular18().copyWith(
                    color: context.onPrimaryColor,
                  ),
                ),
                8.hSpace,
                ...(context.isStateArabic
                        ? emergencyDataArList[index]['symptoms'] as List<String>
                        : emergencyDataEnList[index]['symptoms']
                            as List<String>)
                    .map(
                  (symptom) => ListTile(
                    leading:
                        Icon(Icons.warning, color: Colors.red, size: 20.sp),
                    titleAlignment: ListTileTitleAlignment.titleHeight,
                    dense: true,
                    title: AutoSizeText(
                      symptom,
                      style: TextStyleApp.regular18().copyWith(
                        color: context.onSecondaryColor,
                      ),
                    ),
                  ),
                ),
                Divider(height: 28.h, thickness: .8),
                AutoSizeText(
                  context.isStateArabic
                      ? 'خطوات الطوارئ: '
                      : 'Emergency steps:',
                  style: TextStyleApp.regular18().copyWith(
                    color: context.onPrimaryColor,
                  ),
                ),
                8.hSpace,
                ...(context.isStateArabic
                        ? emergencyDataArList[index]['emergency_steps']
                            as List<String>
                        : emergencyDataEnList[index]['emergency_steps']
                            as List<String>)
                    .map(
                  (step) => ListTile(
                    dense: true,
                    titleAlignment: ListTileTitleAlignment.titleHeight,
                    leading:
                        const Icon(Icons.check_circle, color: Colors.green),
                    title: AutoSizeText(
                      step,
                      style: TextStyleApp.regular18().copyWith(
                        color: context.onSecondaryColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ).paddingSymmetric(horizontal: 12, vertical: 8);
        },
      ),
    );
  }
}
