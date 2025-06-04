// ignore_for_file: library_private_types_in_public_api, document_ignores

import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/extensions/int_extensions.dart';
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/core/utils/helper/to_arabic_number.dart';
import 'package:curai_app_mobile/features/appointment_patient/data/models/appointment_patient_available/appointment_patient_available_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AvailbleDatesWidget extends StatefulWidget {
  const AvailbleDatesWidget({
    required this.onSelect,
    required this.selectedDate,
    required this.availableDates,
    super.key,
  });

  final void Function(MergedDateAvailabilityForPatient selected) onSelect;
  final DateTime selectedDate;
  final List<MergedDateAvailabilityForPatient> availableDates;

  @override
  _AvailbleDatesWidgetState createState() => _AvailbleDatesWidgetState();
}

class _AvailbleDatesWidgetState extends State<AvailbleDatesWidget> {
  final ScrollController _scrollController = ScrollController();
  int selectedIndex = 0;
  List<MergedDateAvailabilityForPatient>? dates;
  void selectDay(int index) {
    setState(() {
      selectedIndex = index;
    });
    widget.onSelect(dates![index]);

    final key = _itemKeys[index];
    final context = key.currentContext;

    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        alignment: 0.5,
      );
    }
  }

  void goToPreviousDay() {
    if (selectedIndex > 0) {
      selectDay(selectedIndex - 1);
    }
  }

  void goToNextDay() {
    if (selectedIndex < dates!.length - 1) {
      selectDay(selectedIndex + 1);
    }
  }

  final List<GlobalKey> _itemKeys = [];
  @override
  void initState() {
    super.initState();
    dates = widget.availableDates;
    _itemKeys.addAll(List.generate(dates!.length, (_) => GlobalKey()));
  }

  @override
  void didUpdateWidget(covariant AvailbleDatesWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.selectedDate != oldWidget.selectedDate) {
      final newIndex = dates!.indexWhere(
        (element) =>
            element.date.year == widget.selectedDate.year &&
            element.date.month == widget.selectedDate.month &&
            element.date.day == widget.selectedDate.day,
      );

      if (newIndex != -1 && newIndex != selectedIndex) {
        setState(() {
          selectedIndex = newIndex;
        });

        final key = _itemKeys[newIndex];
        final ctx = key.currentContext;
        if (ctx != null) {
          Scrollable.ensureVisible(
            ctx,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            alignment: 0.5,
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: context.H * 0.12,
      child: Row(
        children: [
          IconButton(
            alignment: context.isStateArabic
                ? Alignment.centerRight
                : Alignment.centerLeft,
            padding: EdgeInsets.zero,
            icon: Icon(
              Icons.chevron_left,
              size: 30.sp,
              color: context.onPrimaryColor,
            ),
            onPressed: goToPreviousDay,
          ),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: dates!.length,
              itemBuilder: (context, index) {
                final mergedDate = dates![index];
                final date = mergedDate.date;

                final weekdayEn = [
                  'Mon',
                  'Tue',
                  'Wed',
                  'Thu',
                  'Fri',
                  'Sat',
                  'Sun',
                ][date.weekday - 1];

                final weekdayAr = [
                  'الاثنين',
                  'الثلاثاء',
                  'الأربعاء',
                  'الخميس',
                  'الجمعة',
                  'السبت',
                  'الأحد',
                ][date.weekday - 1];

                final isSelected = index == selectedIndex;

                return InkWell(
                  borderRadius: BorderRadius.circular(12.r),
                  onTap: () => selectDay(index),
                  child: Container(
                    key: _itemKeys[index],
                    padding: context.padding(horizontal: 6),
                    margin: context.padding(horizontal: 6),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? context.primaryColor
                          : context.onSecondaryColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AutoSizeText(
                          context.isStateArabic ? weekdayAr : weekdayEn,
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyleApp.medium16().copyWith(
                            color: isSelected
                                ? Colors.white
                                : context.onPrimaryColor.withAlpha(180),
                          ),
                        ).withWidth(context.W * 0.15),
                        3.hSpace,
                        AutoSizeText(
                          context.isStateArabic
                              ? "${toArabicNumber(date.day.toString().padLeft(2, '0'))}/${toArabicNumber(date.month.toString().padLeft(2, '0'))}"
                              : "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: TextStyleApp.medium(
                            context.isStateArabic ? 16 : 14,
                          ).copyWith(
                            color: isSelected
                                ? Colors.white
                                : context.onPrimaryColor.withAlpha(180),
                          ),
                        ).withWidth(context.W * 0.15),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          IconButton(
            padding: EdgeInsets.zero,
            alignment: context.isStateArabic
                ? Alignment.centerLeft
                : Alignment.centerRight,
            icon: Icon(
              Icons.chevron_right,
              size: 30.sp,
              color: context.onPrimaryColor,
            ),
            onPressed: goToNextDay,
          ),
        ],
      ),
    );
  }
}
