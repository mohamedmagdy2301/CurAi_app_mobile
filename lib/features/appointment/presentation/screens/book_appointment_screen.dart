import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/extensions/int_extensions.dart'
    as int_ext;
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/core/utils/widgets/custom_button.dart';
import 'package:curai_app_mobile/features/appointment/data/models/appointment_available/appointment_available_model.dart';
import 'package:curai_app_mobile/features/appointment/presentation/widgets/available_time_widget.dart';
import 'package:curai_app_mobile/features/appointment/presentation/widgets/custom_appbar_book_appointment.dart';
import 'package:curai_app_mobile/features/appointment/presentation/widgets/date_selector_horizontal.dart';
import 'package:curai_app_mobile/features/user/data/models/doctor/doctor_model.dart';
import 'package:flutter/material.dart';

class BookAppointmentScreen extends StatefulWidget {
  const BookAppointmentScreen({
    required this.doctorResults,
    required this.appointmentAvailableModel,
    super.key,
  });
  final DoctorResults doctorResults;
  final AppointmentAvailableModel appointmentAvailableModel;

  @override
  State<BookAppointmentScreen> createState() => _BookAppointmentScreenState();
}

class _BookAppointmentScreenState extends State<BookAppointmentScreen> {
  DateTime selectedDate = DateTime.now();
  List<String> availableTimes = [];
  List<DateTime> availableDates = [];

  @override
  void initState() {
    super.initState();

    final merged = mergeAndSortByDate(widget.appointmentAvailableModel);
    availableDates = merged.map((e) => e.date).toList();

    if (merged.isNotEmpty) {
      selectedDate = merged.first.date;
      availableTimes = merged.first.freeSlots;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbarBookAppointment(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          30.hSpace,
          Row(
            children: [
              AutoSizeText(
                context.translate(LangKeys.selectDate),
                maxLines: 1,
                style: TextStyleApp.bold20().copyWith(
                  color: context.onPrimaryColor,
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 30)),
                    initialDate: selectedDate,
                    currentDate: DateTime.now(),
                    cancelText: context.translate(LangKeys.cancel),
                    confirmText: context.translate(LangKeys.ok),
                    helpText: context.translate(LangKeys.selectDate),
                    keyboardType: TextInputType.number,
                    selectableDayPredicate: (DateTime day) {
                      return availableDates.any(
                        (available) =>
                            available.year == day.year &&
                            available.month == day.month &&
                            available.day == day.day,
                      );
                    },
                  );
                  if (picked != null) {
                    final matched =
                        mergeAndSortByDate(widget.appointmentAvailableModel)
                            .firstWhere(
                      (element) =>
                          element.date.year == picked.year &&
                          element.date.month == picked.month &&
                          element.date.day == picked.day,
                      orElse: () => MergedDateAvailability(
                        day: '',
                        dateString: '',
                        date: picked,
                        availableFrom: '',
                        availableTo: '',
                        freeSlots: [],
                      ),
                    );
                    setState(() {
                      selectedDate = picked;
                      availableTimes = matched.freeSlots;
                    });
                  }
                },
                child: AutoSizeText(
                  context.translate(LangKeys.setManual),
                  maxLines: 1,
                  style: TextStyleApp.medium16().copyWith(
                    color: Colors.blue,
                  ),
                ),
              ),
            ],
          ).paddingSymmetric(horizontal: 15),
          20.hSpace,
          DateSelectorHorizontal(
            selectedDate: selectedDate,
            availableDates:
                mergeAndSortByDate(widget.appointmentAvailableModel),
            onSelect: (MergedDateAvailability selected) {
              setState(() {
                selectedDate = selected.date;
                availableTimes = selected.freeSlots;
              });
            },
          ),
          30.hSpace,
          AvailableTimeWidget(
            doctorResults: widget.doctorResults,
            availableTimes: availableTimes,
          ),
          CustomButton(
            title: LangKeys.bookAppointment,
            onPressed: () {
              // تنفيذ الحجز
            },
          )
              .paddingSymmetric(horizontal: 15)
              .paddingOnly(bottom: Platform.isIOS ? 17 : 10),
        ],
      ),
    );
  }
}
