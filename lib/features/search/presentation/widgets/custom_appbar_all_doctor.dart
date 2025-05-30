// ignore_for_file: lines_longer_than_80_chars

import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/navigation_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/routes/routes.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/features/home/presentation/widgets/doctor_speciality/specialization_widget.dart';
import 'package:flutter/material.dart';

class CustomAppBarAllDoctor extends StatefulWidget {
  const CustomAppBarAllDoctor({
    super.key,
    this.title,
  });
  final String? title;

  @override
  State<CustomAppBarAllDoctor> createState() => _CustomAppBarAllDoctorState();
}

class _CustomAppBarAllDoctorState extends State<CustomAppBarAllDoctor> {
  int count = 5;
  String? getTitleSpecializationNameLoacl() {
    if (widget.title != null) {
      return specializationName(
        widget.title,
        isArabic: context.isStateArabic,
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      // floating: true,
      // snap: true,
      pinned: true,
      elevation: 0,
      flexibleSpace: Container(color: context.backgroundColor),
      title: AutoSizeText(
        getTitleSpecializationNameLoacl() ??
            context.translate(LangKeys.doctors),
        maxLines: 1,
        style: TextStyleApp.bold20().copyWith(
          color: context.onPrimaryColor,
        ),
      ),
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: () {
          context.pushNamedAndRemoveUntil(Routes.mainScaffoldUser);
        },
      ),
    );
  }
}
