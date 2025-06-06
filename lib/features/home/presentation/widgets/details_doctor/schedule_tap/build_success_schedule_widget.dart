import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/extensions/int_extensions.dart';
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/navigation_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/routes/routes.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/core/utils/helper/to_arabic_number.dart';
import 'package:curai_app_mobile/core/utils/models/doctor_model/doctor_info_model.dart';
import 'package:curai_app_mobile/core/utils/widgets/adaptive_dialogs/adaptive_dialogs.dart';
import 'package:curai_app_mobile/core/utils/widgets/custom_button.dart';
import 'package:curai_app_mobile/core/utils/widgets/sankbar/snackbar_helper.dart';
import 'package:curai_app_mobile/features/appointment_patient/data/models/appointment_patient_available/appointment_patient_available_model.dart';
import 'package:curai_app_mobile/features/appointment_patient/data/models/schedule_appointment_patient/schedule_appointment_patient_request.dart';
import 'package:curai_app_mobile/features/appointment_patient/presentation/cubit/appointment_patient_cubit/appointment_patient_cubit.dart';
import 'package:curai_app_mobile/features/appointment_patient/presentation/cubit/appointment_patient_cubit/appointment_patient_state.dart';
import 'package:curai_app_mobile/features/home/presentation/widgets/details_doctor/schedule_tap/available_date_widget.dart';
import 'package:curai_app_mobile/features/home/presentation/widgets/details_doctor/schedule_tap/available_time_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';

class BuildSuccessScheduleWidget extends StatefulWidget {
  const BuildSuccessScheduleWidget({
    required this.appointmentAvailableModel,
    required this.doctorResults,
    super.key,
  });

  final AppointmentPatientAvailableModel appointmentAvailableModel;
  final DoctorInfoModel doctorResults;

  @override
  State<BuildSuccessScheduleWidget> createState() =>
      _BuildSuccessScheduleWidgetState();
}

class _BuildSuccessScheduleWidgetState
    extends State<BuildSuccessScheduleWidget> {
  DateTime _selectedDate = DateTime.now();
  String? _selectedTime;
  List<String> _availableTimes = [];
  List<DateTime> _availableDates = [];

  @override
  void initState() {
    super.initState();
    _initializeDateTime();
  }

  void _initializeDateTime() {
    final allMergedData = mergeAndSortByDate(widget.appointmentAvailableModel);

    final filteredMergedData = allMergedData.where((e) {
      final futureTimes = _filterFutureTimes(e.freeSlots, e.date);
      return futureTimes.isNotEmpty;
    }).toList();

    if (filteredMergedData.isNotEmpty) {
      _availableDates = filteredMergedData.map((e) => e.date).toList();
      _selectedDate = filteredMergedData.first.date;

      final filteredTimes =
          _filterFutureTimes(filteredMergedData.first.freeSlots, _selectedDate);

      _availableTimes = filteredTimes;
      _selectedTime = _availableTimes.isNotEmpty ? _availableTimes.first : null;
    }
  }

  List<String> _filterFutureTimes(List<String> times, DateTime date) {
    final now = DateTime.now();

    return times.where((timeStr) {
      final timeParts = timeStr.split(':');
      final time = DateTime(
        date.year,
        date.month,
        date.day,
        int.parse(timeParts[0]),
        int.parse(timeParts[1]),
      );
      return time.isAfter(now);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final mergedData = mergeAndSortByDate(widget.appointmentAvailableModel)
        .where((e) => _filterFutureTimes(e.freeSlots, e.date).isNotEmpty)
        .toList();
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            15.hSpace,
            Row(
              children: [
                AutoSizeText(
                  context.translate(LangKeys.selectDate),
                  maxLines: 1,
                  style: TextStyleApp.bold18().copyWith(
                    color: context.onPrimaryColor.withAlpha(180),
                  ),
                ),
                const Spacer(),
                InkWell(
                  onTap: _showDatePicker,
                  child: AutoSizeText(
                    context.translate(LangKeys.setManual),
                    maxLines: 1,
                    style: TextStyleApp.medium16().copyWith(
                      color: context.primaryColor,
                    ),
                  ),
                ),
              ],
            ).paddingSymmetric(horizontal: 15),
            20.hSpace,
            AvailbleDatesWidget(
              selectedDate: _selectedDate,
              availableDates: mergedData,
              onSelect: _onDateSelected,
            ),
            20.hSpace,
            AvailableTimeWidget(
              availableTimes: _availableTimes,
              onTimeSelected: _onTimeSelected,
              initialSelectedTime: _selectedTime,
            ),
          ],
        ).expand(),
        BlocConsumer<AppointmentPatientCubit, AppointmentPatientState>(
          listenWhen: _shouldListenForScheduling,
          buildWhen: _shouldListenForScheduling,
          listener: _handleSchedulingStateChanges,
          builder: (context, state) {
            return CustomButton(
              title: '${context.translate(LangKeys.bookAppointment)}  '
                  '${context.isStateArabic ? toArabicNumber(widget.doctorResults.consultationPrice!.split('.')[0]) : widget.doctorResults.consultationPrice!.split('.')[0]} '
                  '${context.translate(LangKeys.egp)}',
              isNoLang: true,
              colorBackground: context.primaryColor,
              onPressed: _scheduleAppointment,
            ).paddingBottom(17);
          },
        ),
      ],
    );
  }

  void _onDateSelected(MergedDateAvailabilityForPatient selected) {
    setState(() {
      _selectedDate = selected.date;
      _availableTimes = selected.freeSlots;
      _selectedTime = _availableTimes.isNotEmpty ? _availableTimes.first : null;
    });
  }

  void _onTimeSelected(String time) {
    setState(() {
      _selectedTime = time;
    });
  }

  Future<void> _showDatePicker() async {
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
      initialDate: _selectedDate,
      currentDate: DateTime.now(),
      cancelText: context.translate(LangKeys.cancel),
      confirmText: context.translate(LangKeys.ok),
      helpText: context.translate(LangKeys.selectDate),
      keyboardType: TextInputType.number,
      selectableDayPredicate: _isDateSelectable,
    );

    if (picked != null) {
      _handleDateSelection(picked);
    }
  }

  bool _isDateSelectable(DateTime day) {
    return _availableDates.any(
      (available) =>
          available.year == day.year &&
          available.month == day.month &&
          available.day == day.day,
    );
  }

  void _handleDateSelection(DateTime picked) {
    final mergedData = mergeAndSortByDate(widget.appointmentAvailableModel)
        .where((e) => _filterFutureTimes(e.freeSlots, e.date).isNotEmpty)
        .toList();

    final matched = mergedData.firstWhere(
      (element) =>
          element.date.year == picked.year &&
          element.date.month == picked.month &&
          element.date.day == picked.day,
      orElse: () => MergedDateAvailabilityForPatient(
        day: '',
        dateString: '',
        date: picked,
        availableFrom: '',
        availableTo: '',
        freeSlots: [],
      ),
    );

    final filteredTimes = _filterFutureTimes(matched.freeSlots, picked);

    setState(() {
      _selectedDate = picked;
      _availableTimes = filteredTimes;
      _selectedTime = _availableTimes.isNotEmpty ? _availableTimes.first : null;
    });
  }

  void _scheduleAppointment() {
    final doctorId = widget.doctorResults.id;
    if (doctorId == null || _selectedTime == null) return;

    final request = ScheduleAppointmentPatientRequest(
      doctorId: doctorId,
      appointmentDate: _selectedDate.toString().split(' ')[0],
      appointmentTime: _selectedTime!,
    );

    context
        .read<AppointmentPatientCubit>()
        .scheduleAppointmentPatient(params: request);
  }

  bool _shouldListenForScheduling(
    AppointmentPatientState previous,
    AppointmentPatientState current,
  ) {
    return current is ScheduleAppointmentPatientFailure ||
        current is ScheduleAppointmentPatientLoading ||
        current is ScheduleAppointmentPatientSuccess;
  }

  String _getErrorMessage(String originalMessage) {
    if (originalMessage.contains('This appointment slot is already booked')) {
      return context.translate(LangKeys.alreadyBooked);
    }
    return originalMessage;
  }

  void _handleSchedulingStateChanges(
    BuildContext context,
    AppointmentPatientState state,
  ) {
    switch (state) {
      case ScheduleAppointmentPatientFailure():
        context.pop();
        showMessage(
          context,
          message: _getErrorMessage(state.message),
          type: ToastificationType.error,
        );
      case ScheduleAppointmentPatientSuccess():
        context.pop();
        context.pushReplacementNamed(
          Routes.paymentAppointmentScreen,
          arguments: {
            'doctorResults': widget.doctorResults,
            'appointmentId':
                state.scheduleAppointmentPatientModel.appointmentId,
          },
        );
      case ScheduleAppointmentPatientLoading():
        AdaptiveDialogs.showLoadingAlertDialog(
          context: context,
          title: context.translate(LangKeys.bookAppointment),
        );
    }
  }
}
