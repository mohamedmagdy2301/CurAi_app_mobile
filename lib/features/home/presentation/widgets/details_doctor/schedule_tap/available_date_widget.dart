// ignore_for_file: library_private_types_in_public_api, document_ignores

import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/extensions/int_extensions.dart';
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
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
      height: context.H * 0.11,
      child: Row(
        children: [
          IconButton(
            padding: EdgeInsets.zero,
            icon: const Icon(Icons.chevron_left),
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

                return GestureDetector(
                  onTap: () => selectDay(index),
                  child: Container(
                    key: _itemKeys[index],
                    width: context.W * 0.165,
                    margin: EdgeInsets.symmetric(horizontal: 6.w),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? context.primaryColor
                          : context.onSecondaryColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: context.W * 0.15,
                          child: AutoSizeText(
                            context.isStateArabic ? weekdayAr : weekdayEn,
                            maxLines: 1,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyleApp.medium16().copyWith(
                              color: isSelected
                                  ? Colors.white
                                  : context.onPrimaryColor.withAlpha(180),
                            ),
                          ),
                        ),
                        3.hSpace,
                        SizedBox(
                          width: context.W * 0.15,
                          child: AutoSizeText(
                            "${toArabicNumber(date.day.toString().padLeft(2, '0'))}/${toArabicNumber(date.month.toString().padLeft(2, '0'))}",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: TextStyleApp.medium16().copyWith(
                              color: isSelected
                                  ? Colors.white
                                  : context.onPrimaryColor.withAlpha(180),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          IconButton(
            padding: EdgeInsets.zero,
            icon: const Icon(Icons.chevron_right),
            onPressed: goToNextDay,
          ),
        ],
      ),
    );
  }
}
