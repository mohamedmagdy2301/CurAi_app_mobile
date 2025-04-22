import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/extensions/int_extensions.dart';
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/core/utils/helper/regex.dart';
import 'package:curai_app_mobile/features/appointment/presentation/widgets/working_time_details_doctor_widget.dart';
import 'package:curai_app_mobile/features/user/data/models/doctor/doctor_model.dart';
import 'package:curai_app_mobile/features/user/presentation/widgets/home/doctor_speciality/specialization_widget.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class AboutTap extends StatelessWidget {
  const AboutTap({
    required this.doctorResults,
    super.key,
  });

  final DoctorResults doctorResults;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AboutMeWidget(doctorResults: doctorResults),
          15.hSpace,
          MedicalDegreeWidget(doctorResults: doctorResults),
          15.hSpace,
          ConsultationPriceWidget(doctorResults: doctorResults),
          15.hSpace,
          const WorkingTimeWidget(),
          10.hSpace,
        ],
      ).paddingSymmetric(horizontal: 10, vertical: 10),
    );
  }
}

class ConsultationPriceWidget extends StatelessWidget {
  const ConsultationPriceWidget({
    required this.doctorResults,
    super.key,
  });
  final DoctorResults doctorResults;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AutoSizeText(
          context.translate(LangKeys.consultationPrice),
          maxLines: 1,
          textAlign: TextAlign.start,
          overflow: TextOverflow.ellipsis,
          style: TextStyleApp.bold18().copyWith(
            color: context.onPrimaryColor.withAlpha(180),
          ),
        ),
        5.hSpace,
        AutoSizeText(
          '${doctorResults.consultationPrice} '
          '${context.translate(LangKeys.egp)}',
          maxLines: 1,
          textAlign: TextAlign.start,
          overflow: TextOverflow.ellipsis,
          style: TextStyleApp.medium18().copyWith(
            color: context.onSecondaryColor,
          ),
        ),
      ],
    );
  }
}

class MedicalDegreeWidget extends StatelessWidget {
  const MedicalDegreeWidget({
    required this.doctorResults,
    super.key,
  });
  final DoctorResults doctorResults;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AutoSizeText(
          context.translate(LangKeys.medicalSpecialization),
          maxLines: 1,
          textAlign: TextAlign.start,
          overflow: TextOverflow.ellipsis,
          style: TextStyleApp.bold18().copyWith(
            color: context.onPrimaryColor.withAlpha(180),
          ),
        ),
        5.hSpace,
        AutoSizeText(
          ' ${specializationName(
            doctorResults.specialization ?? '',
            context.isStateArabic,
          )} ',
          maxLines: 1,
          textAlign: TextAlign.start,
          overflow: TextOverflow.ellipsis,
          style: TextStyleApp.medium18().copyWith(
            color: context.onSecondaryColor,
          ),
        ),
      ],
    );
  }
}

class AboutMeWidget extends StatelessWidget {
  const AboutMeWidget({
    required this.doctorResults,
    super.key,
  });

  final DoctorResults doctorResults;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AutoSizeText(
          context.translate(LangKeys.aboutMe),
          maxLines: 1,
          textAlign: TextAlign.start,
          overflow: TextOverflow.ellipsis,
          style: TextStyleApp.bold20().copyWith(
            color: context.onPrimaryColor.withAlpha(180),
          ),
        ),
        10.hSpace,
        ReadMoreText(
          doctorResults.bio ?? context.translate(LangKeys.noBio),
          trimLines: 3,
          colorClickableText: Theme.of(context).colorScheme.primary,
          trimMode: TrimMode.Line,
          trimCollapsedText: context.isStateArabic ? 'عرض الكل' : 'Show All',
          trimExpandedText: context.isStateArabic ? 'إخفاء' : 'Show Less',
          textAlign: TextAlign.start,
          locale:
              context.isStateArabic ? const Locale('ar') : const Locale('en'),
          textDirection: isArabicFormat(
            doctorResults.bio ?? context.translate(LangKeys.noBio),
          )
              ? TextDirection.rtl
              : TextDirection.ltr,
          style: TextStyleApp.medium18().copyWith(
            color: context.onSecondaryColor,
          ),
          moreStyle: TextStyleApp.medium16().copyWith(
            color: context.onPrimaryColor,
          ),
          lessStyle: TextStyleApp.medium16().copyWith(
            color: context.onPrimaryColor,
          ),
        ),
      ],
    );
  }
}

class ExpandableBioText extends StatefulWidget {
  const ExpandableBioText({
    required this.bio,
    required this.isArabic,
    super.key,
  });
  final String bio;
  final bool isArabic;

  @override
  State<ExpandableBioText> createState() => _ExpandableBioTextState();
}

class _ExpandableBioTextState extends State<ExpandableBioText> {
  @override
  Widget build(BuildContext context) {
    final textDirection =
        isArabicFormat(widget.bio) ? TextDirection.rtl : TextDirection.ltr;

    return ReadMoreText(
      widget.bio,
      trimLines: 3,
      colorClickableText: Theme.of(context).colorScheme.primary,
      trimMode: TrimMode.Line,
      trimCollapsedText: widget.isArabic ? 'عرض الكل' : 'Show All',
      trimExpandedText: widget.isArabic ? 'إخفاء' : 'Show Less',
      textAlign: TextAlign.start,
      locale: context.isStateArabic ? const Locale('ar') : const Locale('en'),
      textDirection: textDirection,
      style: TextStyleApp.medium18().copyWith(
        color: context.onSecondaryColor,
      ),
      moreStyle: TextStyleApp.medium16().copyWith(
        color: context.onPrimaryColor,
      ),
      lessStyle: TextStyleApp.medium16().copyWith(
        color: context.onPrimaryColor,
      ),
    );
  }
}
