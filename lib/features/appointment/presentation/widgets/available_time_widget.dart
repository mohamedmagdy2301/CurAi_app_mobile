import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/extensions/int_extensions.dart'
    as int_ext;
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/features/user/data/models/doctor/doctor_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AvailableTimeWidget extends StatefulWidget {
  const AvailableTimeWidget({required this.doctorResults, super.key});
  final DoctorResults doctorResults;

  @override
  State<AvailableTimeWidget> createState() => _AvailableTimeWidgetState();
}

class _AvailableTimeWidgetState extends State<AvailableTimeWidget> {
  List<AvailableTime> availableTimes = [];

  @override
  void initState() {
    super.initState();
    availableTimes = [
      AvailableTime(time: '9:00 AM'),
      AvailableTime(time: '10:00 AM'),
      AvailableTime(time: '11:00 AM'),
      AvailableTime(time: '12:00 PM'),
      AvailableTime(time: '1:00 PM'),
      AvailableTime(time: '2:00 PM'),
      AvailableTime(time: '3:00 PM'),
      AvailableTime(time: '4:00 PM'),
      AvailableTime(time: '5:00 PM'),
      AvailableTime(time: '6:00 PM'),
      AvailableTime(time: '4:00 PM'),
      AvailableTime(time: '5:00 PM'),
      AvailableTime(time: '6:00 PM'),
    ];
  }

  void selectAvailableTime(AvailableTime selectedTime) {
    setState(() {
      selectedIndex = availableTimes.indexOf(selectedTime);
    });
  }

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AutoSizeText(
          context.translate(LangKeys.availableTime),
          maxLines: 1,
          style: TextStyleApp.bold20().copyWith(
            color: context.onPrimaryColor,
          ),
        ).paddingSymmetric(horizontal: 15),
        10.hSpace,
        GridView.builder(
          itemCount: availableTimes.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 2.8,
          ),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () => selectAvailableTime(availableTimes[index]),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  color: index == selectedIndex
                      ? context.primaryColor
                      : context.onSecondaryColor.withAlpha(10),
                ),
                alignment: Alignment.center,
                child: AutoSizeText(
                  availableTimes[index].time,
                  maxLines: 1,
                  style: TextStyleApp.medium18().copyWith(
                    color: index == selectedIndex
                        ? Colors.white
                        : context.onSecondaryColor,
                  ),
                ),
              ),
            );
          },
        ).paddingSymmetric(horizontal: 15, vertical: 5).expand(),
      ],
    ).expand();
  }
}

class AvailableTime {
  AvailableTime({required this.time});
  final String time;
}
