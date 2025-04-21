import 'package:curai_app_mobile/core/extensions/int_extensions.dart'
    as int_ext;
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DateSelectorHorizontal extends StatefulWidget {
  const DateSelectorHorizontal({super.key});

  @override
  _DateSelectorHorizontalState createState() => _DateSelectorHorizontalState();
}

class _DateSelectorHorizontalState extends State<DateSelectorHorizontal> {
  final ScrollController _scrollController = ScrollController();
  final double itemWidth = 70;
  final int totalDays = 10000;
  final int todayIndex = 0;
  int selectedIndex = 0;

  DateTime get startDate => DateTime.now();
  void selectDay(int index) {
    setState(() {
      selectedIndex = index;
    });

    // نستخدم GlobalKey عشان نجيب العنصر الفعلي ونخليه يظهر في المنتصف
    final key = _itemKeys[index];
    final context = key.currentContext;

    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        alignment: 0.5, // 0 = بداية الشاشة، 0.5 = المنتصف، 1 = نهاية الشاشة
      );
    }
  }

  void goToPreviousDay() {
    if (selectedIndex > 0) {
      selectDay(selectedIndex - 1);
    }
  }

  void goToNextDay() {
    if (selectedIndex < totalDays - 1) {
      selectDay(selectedIndex + 1);
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      selectDay(selectedIndex);
    });
  }

  final List<GlobalKey> _itemKeys =
      List.generate(10000, (_) => GlobalKey()); // احفظ مفاتيح العناصر

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
              itemCount: totalDays,
              itemBuilder: (context, index) {
                final date = startDate.add(Duration(days: index));
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
                  'الاربعاء',
                  'الخميس',
                  'الجمعة',
                  'السبت',
                  'الاحد',
                ][date.weekday - 1];
                final isSelected = index == selectedIndex;

                return GestureDetector(
                  onTap: () => selectDay(index),
                  child: Container(
                    key: _itemKeys[index],
                    width: itemWidth.w,
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
