// ignore_for_file: lines_longer_than_80_chars

import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/extensions/int_extensions.dart';
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/string_extensions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/core/utils/widgets/custom_button.dart';
import 'package:curai_app_mobile/core/utils/widgets/sankbar/snackbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toastification/toastification.dart';

class AddWorkingTimeDoctorBottomSheet extends StatefulWidget {
  const AddWorkingTimeDoctorBottomSheet({super.key, this.existingData});
  final Map<String, dynamic>? existingData;
  @override
  State<AddWorkingTimeDoctorBottomSheet> createState() =>
      _AddWorkingTimeDoctorBottomSheetState();
}

class _AddWorkingTimeDoctorBottomSheetState
    extends State<AddWorkingTimeDoctorBottomSheet> {
  int step = 0;
  String? selectedDay;
  TimeOfDay? fromTime;
  TimeOfDay? toTime;
  @override
  void initState() {
    super.initState();
    final data = widget.existingData;
    if (data != null) {
      selectedDay = data['days_of_week'] as String;
      fromTime = _parseTimeOfDay(data['available_from'] as String);
      toTime = _parseTimeOfDay(data['available_to'] as String);
      step = 1;
    }
  }

  TimeOfDay _parseTimeOfDay(String time) {
    final parts = time.split(':');
    return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
  }

  final Map<String, String> daysMap = {
    'Saturday': 'السبت',
    'Sunday': 'الأحد',
    'Monday': 'الاثنين',
    'Tuesday': 'الثلاثاء',
    'Wednesday': 'الأربعاء',
    'Thursday': 'الخميس',
    'Friday': 'الجمعة',
  };

  Future<void> _pickTime(bool isFrom) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.input,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            timePickerTheme: TimePickerThemeData(
              dayPeriodColor: context.primaryColor.withAlpha(90),
              dayPeriodBorderSide: BorderSide(
                width: .6,
                color: context.onSecondaryColor.withAlpha(190),
              ),
              dayPeriodTextColor: context.onPrimaryColor,
              hourMinuteColor: context.primaryColor.withAlpha(30),
              hourMinuteTextColor: context.onPrimaryColor,
              dialHandColor: context.primaryColor,
              dialTextColor: context.onPrimaryColor,
              entryModeIconColor: context.onPrimaryColor,
            ),
            colorScheme: Theme.of(context).colorScheme.copyWith(
                  primary: context.primaryColor,
                  onPrimary: context.backgroundColor,
                  surface: context.backgroundColor,
                  onSurface: context.onPrimaryColor,
                ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: context.onPrimaryColor,
                textStyle: TextStyleApp.medium18().copyWith(
                  color: context.onPrimaryColor,
                ),
              ),
            ),
          ),
          child: Directionality(
            textDirection:
                context.isStateArabic ? TextDirection.rtl : TextDirection.ltr,
            child: child!,
          ),
        );
      },
      helpText: isFrom
          ? context.isStateArabic
              ? 'اختر الوقت المبدئي'
              : 'Select start time'
          : context.isStateArabic
              ? 'اختر الوقت النهائي'
              : 'Select end time',
      cancelText: context.isStateArabic ? 'اغلاق' : 'Close',
      confirmText: context.isStateArabic ? 'حفظ' : 'Save',
      hourLabelText: context.isStateArabic ? 'ساعة' : 'Hour',
      minuteLabelText: context.isStateArabic ? 'دقيقة' : 'Minute',
    );
    if (picked != null) {
      setState(() {
        if (isFrom) {
          fromTime = picked;
        } else {
          toTime = picked;
        }
      });
    }
  }

  void _submit() {
    if (selectedDay != null && fromTime != null && toTime != null) {
      final fromMinutes = fromTime!.hour * 60 + fromTime!.minute;
      final toMinutes = toTime!.hour * 60 + toTime!.minute;

      if (fromMinutes >= toMinutes) {
        showMessage(
          context,
          type: ToastificationType.info,
          message: context.isStateArabic
              ? 'الوقت المبدئي يجب ان يكون قبل الوقت النهائي'
              : 'Start time must be before end time',
        );
        return;
      }

      final data = {
        'available_from': fromTime!.format(context).to24HourTimeFormat(),
        'available_to': toTime!.format(context).to24HourTimeFormat(),
        'days_of_week': selectedDay!,
      };
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pop(context, data);
      });
    } else {
      showMessage(
        context,
        type: ToastificationType.info,
        message: context.isStateArabic
            ? 'من فضلك اختار اليوم والوقت المبدئي والوقت النهائي'
            : 'Please select day, start time and end time',
      );
    }
  }

  Widget _buildStep() {
    switch (step) {
      case 0:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 8.w,
              runSpacing: 8.h,
              children: daysMap.keys.map((day) {
                final isSelected = selectedDay == day;
                return ChoiceChip(
                  selectedColor: context.primaryColor,
                  backgroundColor: context.backgroundColor.withAlpha(10),
                  labelPadding: EdgeInsets.symmetric(horizontal: 9.w),
                  elevation: isSelected ? 3 : 0,
                  avatarBorder: Border.all(
                    width: .6,
                    color: context.onSecondaryColor.withAlpha(190),
                  ),
                  labelStyle: TextStyleApp.regular14().copyWith(
                    color: isSelected ? Colors.white : context.onPrimaryColor,
                  ),
                  checkmarkColor: Colors.white,
                  label: Text(
                    context.isStateArabic ? daysMap[day]! : day,
                  ),
                  selected: isSelected,
                  onSelected: (_) {
                    setState(() {
                      selectedDay = day;
                    });
                  },
                );
              }).toList(),
            ),
          ],
        );
      case 1:
        return Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AutoSizeText(
                  context.translate(LangKeys.starTime),
                  maxLines: 1,
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyleApp.regular16().copyWith(
                    color: context.onPrimaryColor.withAlpha(180),
                  ),
                ),
                CustomButton(
                  isHalf: true,
                  isNoLang: fromTime != null,
                  title: fromTime == null
                      ? LangKeys.selectTime
                      : fromTime!.format(context),
                  onPressed: () {
                    _pickTime(true);
                  },
                ),
              ],
            ).expand(),
            10.wSpace,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AutoSizeText(
                  context.translate(LangKeys.endTime),
                  maxLines: 1,
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyleApp.regular16().copyWith(
                    color: context.onPrimaryColor.withAlpha(180),
                  ),
                ),
                CustomButton(
                  isHalf: true,
                  isNoLang: toTime != null,
                  title: toTime == null
                      ? LangKeys.selectTime
                      : toTime!.format(context),
                  onPressed: () {
                    _pickTime(false);
                  },
                ),
              ],
            ).expand(),
          ],
        );
      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 20.h,
      runSpacing: 20.h,
      children: [
        Container(
          height: 3.5.h,
          width: 70.w,
          margin: EdgeInsets.only(bottom: 8.h),
          decoration: BoxDecoration(
            color: context.onSecondaryColor.withAlpha(160),
            borderRadius: BorderRadius.circular(2),
          ),
        ).center(),
        AutoSizeText(
          step == 0
              ? context.translate(LangKeys.selectWorkingDay)
              : context.translate(LangKeys.addWorkingHours),
          maxLines: 1,
          textAlign: TextAlign.start,
          overflow: TextOverflow.ellipsis,
          style: TextStyleApp.bold18().copyWith(
            color: context.onPrimaryColor,
          ),
        ).paddingBottom(12),
        _buildStep(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (step > 0)
              TextButton(
                onPressed: () => setState(() => step--),
                child: AutoSizeText(
                  context.translate(LangKeys.back),
                  style: TextStyleApp.semiBold16().copyWith(
                    color: context.onPrimaryColor,
                  ),
                  maxLines: 1,
                ),
              ),
            CustomButton(
              title: step == 1 ? LangKeys.save : LangKeys.next,
              onPressed: () {
                if (step < 1) {
                  if (selectedDay != null) {
                    setState(() => step++);
                  } else {
                    showMessage(
                      context,
                      type: ToastificationType.info,
                      message: context.isStateArabic
                          ? 'من فضلك اختار اليوم'
                          : 'Please select day first',
                    );
                  }
                } else {
                  if (fromTime != null) {
                    if (toTime != null) {
                      _submit();
                    } else {
                      showMessage(
                        context,
                        type: ToastificationType.info,
                        message: context.isStateArabic
                            ? 'من فضلك اختار الوقت النهائي'
                            : 'Please select end time',
                      );
                    }
                  } else {
                    if (toTime == null) {
                      showMessage(
                        context,
                        type: ToastificationType.info,
                        message: context.isStateArabic
                            ? 'من فضلك اختار الوقت المبدئي والوقت النهائي'
                            : 'Please select start time and end time',
                      );
                    } else {
                      showMessage(
                        context,
                        type: ToastificationType.info,
                        message: context.isStateArabic
                            ? 'من فضلك اختار الوقت المبدئي'
                            : 'Please select start time',
                      );
                    }
                  }
                }
              },
            ).expand(),
          ],
        ),
      ],
    ).paddingOnly(
      bottom: MediaQuery.of(context).viewInsets.bottom + 16.h,
      left: 16.w,
      right: 16.w,
      top: 24.h,
    );
  }
}
