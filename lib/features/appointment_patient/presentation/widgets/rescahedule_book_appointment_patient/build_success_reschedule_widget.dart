import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/dependency_injection/service_locator.dart'
    as di;
import 'package:curai_app_mobile/core/extensions/int_extensions.dart';
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/navigation_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/services/local_notification/local_notification_manager.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/core/utils/models/doctor_model/doctor_info_model.dart';
import 'package:curai_app_mobile/core/utils/widgets/adaptive_dialogs/adaptive_dialogs.dart';
import 'package:curai_app_mobile/core/utils/widgets/custom_button.dart';
import 'package:curai_app_mobile/core/utils/widgets/sankbar/snackbar_helper.dart';
import 'package:curai_app_mobile/features/appointment_patient/data/models/appointment_patient_available/appointment_patient_available_model.dart';
import 'package:curai_app_mobile/features/appointment_patient/data/models/my_appointment_patient/my_appointment_patient_model.dart';
import 'package:curai_app_mobile/features/appointment_patient/data/models/schedule_appointment_patient/schedule_appointment_patient_request.dart';
import 'package:curai_app_mobile/features/appointment_patient/presentation/cubit/appointment_patient_cubit/appointment_patient_cubit.dart';
import 'package:curai_app_mobile/features/appointment_patient/presentation/cubit/appointment_patient_cubit/appointment_patient_state.dart';
import 'package:curai_app_mobile/features/home/presentation/widgets/details_doctor/schedule_tap/available_date_widget.dart';
import 'package:curai_app_mobile/features/home/presentation/widgets/details_doctor/schedule_tap/available_time_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';

class BuildSuccessRescheduleWidget extends StatefulWidget {
  const BuildSuccessRescheduleWidget({
    required this.appointmentAvailableModel,
    required this.doctorResults,
    required this.appointment,
    super.key,
  });

  final AppointmentPatientAvailableModel appointmentAvailableModel;
  final ResultsMyAppointmentPatient appointment;
  final DoctorInfoModel doctorResults;

  @override
  State<BuildSuccessRescheduleWidget> createState() =>
      _BuildSuccessRescheduleWidgetState();
}

class _BuildSuccessRescheduleWidgetState
    extends State<BuildSuccessRescheduleWidget> {
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
    final mergedData = mergeAndSortByDate(widget.appointmentAvailableModel);
    if (mergedData.isNotEmpty) {
      _availableDates = mergedData.map((e) => e.date).toList();
      _selectedDate = mergedData.first.date;
      _availableTimes = mergedData.first.freeSlots;
      _selectedTime = _availableTimes.isNotEmpty ? _availableTimes.first : null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final mergedData = mergeAndSortByDate(widget.appointmentAvailableModel);

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
                  style: TextStyleApp.bold20().copyWith(
                    color: context.onPrimaryColor,
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
          listenWhen: _shouldListenForRescheduling,
          buildWhen: _shouldListenForRescheduling,
          listener: _handleReschedulingStateChanges,
          builder: (context, state) {
            return CustomButton(
              title: LangKeys.reschedule,
              isLoading: state is RescheduleAppointmentPatientLoading,
              onPressed: _rescheduleAppointment,
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
    final mergedData = mergeAndSortByDate(widget.appointmentAvailableModel);
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

    setState(() {
      _selectedDate = picked;
      _availableTimes = matched.freeSlots;
      _selectedTime = _availableTimes.isNotEmpty ? _availableTimes.first : null;
    });
  }

  void _rescheduleAppointment() {
    final doctorId = widget.doctorResults.id;
    if (doctorId == null || _selectedTime == null) return;

    final request = ScheduleAppointmentPatientRequest(
      doctorId: doctorId,
      appointmentDate: _selectedDate.toString().split(' ')[0],
      appointmentTime: _selectedTime!,
    );

    context.read<AppointmentPatientCubit>().rescheduleAppointmentPatient(
          appointmentId: widget.appointment.id!,
          params: request,
        );
  }

  bool _shouldListenForRescheduling(
    AppointmentPatientState previous,
    AppointmentPatientState current,
  ) {
    return current is RescheduleAppointmentPatientFailure ||
        current is RescheduleAppointmentPatientLoading ||
        current is RescheduleAppointmentPatientSuccess;
  }

  String _getErrorMessage(String originalMessage) {
    if (originalMessage.contains('This appointment slot is already booked')) {
      return context.translate(LangKeys.alreadyBooked);
    }
    return originalMessage;
  }

  Future<void> _handleReschedulingStateChanges(
    BuildContext context,
    AppointmentPatientState state,
  ) async {
    switch (state) {
      case RescheduleAppointmentPatientFailure():
        context.pop();
        showMessage(
          context,
          message: _getErrorMessage(state.message),
          type: ToastificationType.error,
        );
      case RescheduleAppointmentPatientSuccess():
        context.pop();
        showMessage(
          context,
          message: context.translate(LangKeys.rescheduleSuccess),
          type: ToastificationType.success,
        );
        context.pop();

        if (!context.mounted) return;
        await context
            .read<AppointmentPatientCubit>()
            .refreshMyAppointmentPatient();

        await di.sl<LocalNotificationService>().cancelNotificationById(
              widget.appointment.id!,
            );

        if (!context.mounted) return;
        context.pop();
      case RescheduleAppointmentPatientLoading():
        await AdaptiveDialogs.showLoadingAlertDialog(
          context: context,
          title: context.translate(LangKeys.reschedule),
        );
    }
  }
}
