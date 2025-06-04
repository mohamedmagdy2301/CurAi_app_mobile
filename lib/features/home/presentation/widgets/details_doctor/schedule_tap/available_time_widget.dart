import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/extensions/int_extensions.dart';
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/string_extensions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AvailableTimeWidget extends StatefulWidget {
  const AvailableTimeWidget({
    required this.availableTimes,
    required this.onTimeSelected,
    super.key,
    this.initialSelectedTime,
  });
  final String? initialSelectedTime;

  final List<String> availableTimes;
  final ValueChanged<String> onTimeSelected;

  @override
  State<AvailableTimeWidget> createState() => _AvailableTimeWidgetState();
}

class _AvailableTimeWidgetState extends State<AvailableTimeWidget> {
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _updateSelectedIndex();
  }

  @override
  void didUpdateWidget(covariant AvailableTimeWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.availableTimes != oldWidget.availableTimes ||
        widget.initialSelectedTime != oldWidget.initialSelectedTime) {
      _updateSelectedIndex();
    }
  }

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
          style: TextStyleApp.bold18().copyWith(
            color: context.onPrimaryColor.withAlpha(180),
          ),
        ).paddingSymmetric(horizontal: 15),
        15.hSpace,
        GridView.builder(
          itemCount: widget.availableTimes.length,
          scrollDirection: Axis.horizontal,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            mainAxisExtent: 90,
          ),
          itemBuilder: (context, index) {
            return InkWell(
              borderRadius: BorderRadius.circular(16.r),
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
                  widget.availableTimes[index]
                      .toLocalizedTimeWordDay(context, isTwoLine: true),
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyleApp.medium(
                    context.isStateArabic ? 16 : 14,
                  ).copyWith(
                    color: index == selectedIndex
                        ? Colors.white
                        : context.onSecondaryColor,
                  ),
                ),
              ),
            );
          },
        ).expand(),
        20.hSpace,
      ],
    ).expand();
  }
}

class AvailableTime {
  AvailableTime({required this.time});
  final String time;
}
