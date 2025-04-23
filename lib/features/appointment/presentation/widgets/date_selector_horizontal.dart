import 'package:curai_app_mobile/core/extensions/int_extensions.dart'
    as int_ext;
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/features/appointment/data/models/appointment_available/appointment_available_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DateSelectorHorizontal extends StatefulWidget {
  const DateSelectorHorizontal({
    required this.onSelect,
    required this.selectedDate,
    required this.availableDates,
    super.key,
  });

  final void Function(MergedDateAvailability selected) onSelect;
  final DateTime selectedDate;
  final List<MergedDateAvailability> availableDates;

  @override
  _DateSelectorHorizontalState createState() => _DateSelectorHorizontalState();
}

class _DateSelectorHorizontalState extends State<DateSelectorHorizontal> {
  final ScrollController _scrollController = ScrollController();
  int selectedIndex = 0;
  List<MergedDateAvailability>? dates;
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
  void didUpdateWidget(covariant DateSelectorHorizontal oldWidget) {
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
      height: 100.h,
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
                    width: 70.w,
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
                        Text(
                          context.isStateArabic ? weekdayAr : weekdayEn,
                          style: TextStyleApp.medium16().copyWith(
                            color: isSelected
                                ? context.onPrimaryColor
                                : context.onPrimaryColor.withAlpha(180),
                          ),
                        ),
                        5.hSpace,
                        Text(
                          date.day.toString().padLeft(2, '0'),
                          style: TextStyleApp.bold16().copyWith(
                            color: isSelected
                                ? context.onPrimaryColor
                                : context.onPrimaryColor.withAlpha(180),
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
