import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/extensions/int_extensions.dart';
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/features/user/data/models/doctor/doctor_model.dart';
import 'package:flutter/material.dart';

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
          5.hSpace,
          const MedicalDegreeWidget(),
          10.hSpace,
          const WorkingTimeWidget(),
          50.hSpace,
        ],
      ).paddingSymmetric(horizontal: 10, vertical: 10),
    );
  }
}

class MedicalDegreeWidget extends StatelessWidget {
  const MedicalDegreeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AutoSizeText(
          context.translate(LangKeys.medicalDegree),
          maxLines: 1,
          textAlign: TextAlign.start,
          overflow: TextOverflow.ellipsis,
          style: TextStyleApp.bold20().copyWith(
            color: context.onPrimaryColor,
          ),
        ),
        5.hSpace,
        AutoSizeText(
          context.isStateArabic
              ? 'دكتوراه في الطب من جامعة هارفارد'
              : 'Doctor of Medicine from Harvard University',
          maxLines: 1,
          textAlign: TextAlign.start,
          overflow: TextOverflow.ellipsis,
          style: TextStyleApp.medium16().copyWith(
            color: context.onSecondaryColor,
          ),
        ),
      ],
    );
  }
}

class WorkingTimeWidget extends StatelessWidget {
  const WorkingTimeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AutoSizeText(
          context.translate(LangKeys.workingTime),
          maxLines: 1,
          textAlign: TextAlign.start,
          overflow: TextOverflow.ellipsis,
          style: TextStyleApp.bold20().copyWith(
            color: context.onPrimaryColor,
          ),
        ),
        10.hSpace,
        Divider(
          color: context.onSecondaryColor.withAlpha(80),
          thickness: .5,
        ),
        const TimeRowWidget(
          day: LangKeys.saturday,
          startTime: '10:00',
          endTime: '5:00',
        ),
        const TimeRowWidget(
          day: LangKeys.sunday,
          startTime: '10:00',
          endTime: '5:00',
        ),
        const TimeRowWidget(
          day: LangKeys.monday,
          startTime: '10:00',
          endTime: '5:00',
          isWork: false,
        ),
        const TimeRowWidget(
          day: LangKeys.tuesday,
          startTime: '10:00',
          endTime: '5:00',
        ),
        const TimeRowWidget(
          day: LangKeys.wednesday,
          startTime: '10:00',
          endTime: '5:00',
        ),
        const TimeRowWidget(
          day: LangKeys.thursday,
          startTime: '10:00',
          endTime: '5:00',
        ),
        const TimeRowWidget(
          day: LangKeys.friday,
          startTime: '10:00',
          endTime: '5:00',
          isWork: false,
        ),
      ],
    );
  }
}

class TimeRowWidget extends StatelessWidget {
  const TimeRowWidget({
    required this.day,
    required this.startTime,
    required this.endTime,
    this.isWork,
    super.key,
  });
  final bool? isWork;
  final String startTime;
  final String endTime;
  final String day;

  @override
  Widget build(BuildContext context) {
    if (isWork ?? true) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AutoSizeText(
            context.translate(day),
            maxLines: 1,
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
            style: TextStyleApp.medium16().copyWith(
              color: context.onSecondaryColor,
            ),
          ),
          AutoSizeText(
            '$startTime ${context.translate(LangKeys.am)}   :   $endTime ${context.translate(LangKeys.pm)}',
            maxLines: 1,
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
            style: TextStyleApp.regular14().copyWith(
              color: context.onPrimaryColor,
            ),
          ),
        ],
      ).paddingSymmetric(vertical: 3);
    } else {
      return const SizedBox();
    }
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
            color: context.onPrimaryColor,
          ),
        ),
        10.hSpace,
        SizedBox(
          height: context.H * .15,
          child: AutoSizeText(
            // doctorResults.bio ??
            context.isStateArabic
                ? 'د. ${doctorResults.username} هي أفضل أخصائية مناعة في مستشفى ${doctorResults.location}. حصلت على العديد من الجوائز لمساهمتها الرائعة في المجال الطبي. وهي متاحة للاستشارة الخاصة.'
                : 'Dr. ${doctorResults.username} is the top most Immunologists specialist in Hospital ${doctorResults.location}. She achived several awards for her wonderful contribution in medical field. She is available for private consultation.',
            maxLines: 6,
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
            style: TextStyleApp.medium20().copyWith(
              color: context.onSecondaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
