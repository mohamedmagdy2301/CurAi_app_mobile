import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/extensions/int_extensions.dart'
    as int_ext;
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/string_extensions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/features/home/data/models/doctor_model/doctor_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AvailableTimePatientWidget extends StatefulWidget {
  const AvailableTimePatientWidget({
    required this.doctorResults,
    required this.availableTimes,
    required this.onTimeSelected,
    super.key,
    this.initialSelectedTime,
  });
  final String? initialSelectedTime;

  final DoctorResults doctorResults;
  final List<String> availableTimes;
  final ValueChanged<String> onTimeSelected;

  @override
  State<AvailableTimePatientWidget> createState() =>
      _AvailableTimePatientWidgetState();
}

class _AvailableTimePatientWidgetState
    extends State<AvailableTimePatientWidget> {
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _updateSelectedIndex();
  }

  @override
  void didUpdateWidget(covariant AvailableTimePatientWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.availableTimes != oldWidget.availableTimes ||
        widget.initialSelectedTime != oldWidget.initialSelectedTime) {
      _updateSelectedIndex();
    }
  }

  // void _updateSelectedIndex() {
  //   final index =
  //       widget.availableTimes.indexOf(widget.initialSelectedTime ?? '');
  //   setState(() {
  //     selectedIndex = index >= 0 ? index : 0;
  //   });

  //   if (widget.availableTimes.isNotEmpty) {
  //     widget.onTimeSelected(widget.availableTimes[selectedIndex]);
  //   }
  // }

  void _updateSelectedIndex() {
    final index =
        widget.availableTimes.indexOf(widget.initialSelectedTime ?? '');
    setState(() {
      selectedIndex = index >= 0 ? index : 0;
    });
  }

  void selectAvailableTime(String selectedTime) {
    setState(() {
      selectedIndex = widget.availableTimes.indexOf(selectedTime);
    });
    widget.onTimeSelected(selectedTime);
  }

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
          itemCount: widget.availableTimes.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 2.8,
          ),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () => selectAvailableTime(widget.availableTimes[index]),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  color: index == selectedIndex
                      ? context.primaryColor
                      : context.onSecondaryColor.withAlpha(10),
                ),
                alignment: Alignment.center,
                child: AutoSizeText(
                  widget.availableTimes[index].toLocalizedTime(context),
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
