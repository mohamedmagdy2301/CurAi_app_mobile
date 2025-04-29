import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/extensions/int_extensions.dart'
    as int_ext;
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/navigation_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/routes/routes.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/core/utils/widgets/adaptive_dialogs/adaptive_dialogs.dart';
import 'package:curai_app_mobile/core/utils/widgets/custom_button.dart';
import 'package:curai_app_mobile/core/utils/widgets/sankbar/snackbar_helper.dart';
import 'package:curai_app_mobile/features/appointment/data/models/add_appointment_patient/add_appointment_patient_request.dart';
import 'package:curai_app_mobile/features/appointment/data/models/appointment_available/appointment_available_model.dart';
import 'package:curai_app_mobile/features/appointment/presentation/cubit/appointment_patient_cubit/appointment_patient_cubit.dart';
import 'package:curai_app_mobile/features/appointment/presentation/cubit/appointment_patient_cubit/appointment_patient_state.dart';
import 'package:curai_app_mobile/features/appointment/presentation/widgets/book_appointment/available_time_widget.dart';
import 'package:curai_app_mobile/features/appointment/presentation/widgets/book_appointment/custom_appbar_book_appointment.dart';
import 'package:curai_app_mobile/features/appointment/presentation/widgets/book_appointment/date_selector_horizontal.dart';
import 'package:curai_app_mobile/features/home/data/models/doctor_model/doctor_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookAppointmentScreen extends StatefulWidget {
  const BookAppointmentScreen({
    required this.doctorResults,
    required this.appointmentAvailableModel,
    required this.isReschedule,
    super.key,
  });
  final bool isReschedule;
  final DoctorResults doctorResults;
  final AppointmentAvailableModel appointmentAvailableModel;

  @override
  State<BookAppointmentScreen> createState() => _BookAppointmentScreenState();
}

class _BookAppointmentScreenState extends State<BookAppointmentScreen> {
  DateTime selectedDate = DateTime.now();
  String? selectedTime;

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

      if (availableTimes.isNotEmpty) {
        selectedTime = availableTimes.first;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbarBookAppointment(isReschedule: widget.isReschedule),
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
              selectDateManualWidget(context),
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
                selectedTime =
                    availableTimes.isNotEmpty ? availableTimes.first : null;
              });
            },
          ),
          30.hSpace,
          AvailableTimeWidget(
            doctorResults: widget.doctorResults,
            availableTimes: availableTimes,
            onTimeSelected: (time) {
              selectedTime = time;
            },
            initialSelectedTime: selectedTime,
          ),
          if (widget.isReschedule)
            RescheduleAppointmentButton(
              widget: widget,
              selectedDate: selectedDate,
              selectedTime: selectedTime,
              availableTimes: availableTimes,
            )
          else
            AddAppointmentButton(
              widget: widget,
              selectedDate: selectedDate,
              selectedTime: selectedTime,
              availableTimes: availableTimes,
            ),
        ],
      ),
    );
  }

  InkWell selectDateManualWidget(BuildContext context) {
    return InkWell(
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
              mergeAndSortByDate(widget.appointmentAvailableModel).firstWhere(
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
            selectedTime =
                availableTimes.isNotEmpty ? availableTimes.first : null;
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
    );
  }
}

class AddAppointmentButton extends StatelessWidget {
  const AddAppointmentButton({
    required this.widget,
    required this.selectedDate,
    required this.selectedTime,
    required this.availableTimes,
    super.key,
  });

  final BookAppointmentScreen widget;
  final DateTime selectedDate;
  final String? selectedTime;
  final List<String> availableTimes;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppointmentPatientCubit, AppointmentPatientState>(
      listenWhen: (previous, current) =>
          current is AddAppointmentPatientFailure ||
          current is AddAppointmentPatientLoading ||
          current is AddAppointmentPatientSuccess,
      buildWhen: (previous, current) =>
          current is AddAppointmentPatientLoading ||
          current is AddAppointmentPatientSuccess ||
          current is AddAppointmentPatientFailure,
      listener: (context, state) {
        if (state is AddAppointmentPatientFailure) {
          Navigator.pop(context);
          showMessage(
            context,
            message: state.message,
            type: SnackBarType.error,
          );
        } else if (state is AddAppointmentPatientSuccess) {
          Navigator.pop(context);
          if (state.addAppointmentPatientModel.message != null) {
            showMessage(
              context,
              message: state.addAppointmentPatientModel.message!,
              type: SnackBarType.success,
            );
          }
          context.pushNamed(
            Routes.paymentAppointmentScreen,
            arguments: {
              'doctorResults': widget.doctorResults,
              'appointmentId': state.addAppointmentPatientModel.appointmentId,
            },
          );
        } else if (state is AddAppointmentPatientLoading) {
          AdaptiveDialogs.showLoadingAlertDialog(
            context: context,
            title: context.translate(LangKeys.bookAppointment),
          );
        }
      },
      builder: (context, state) {
        return CustomButton(
          title: LangKeys.bookAppointment,
          onPressed: () {
            context.read<AppointmentPatientCubit>()
              ..addAppointmentPatient(
                params: AddAppointmentPatientRequest(
                  doctorId: widget.doctorResults.id!,
                  appointmentDate: selectedDate.toString().split(' ')[0],
                  appointmentTime: selectedTime ?? availableTimes.first,
                ),
              )
              ..getAppointmentAvailable(
                doctorId: widget.doctorResults.id!,
              );
          },
        )
            .paddingSymmetric(horizontal: 15)
            .paddingOnly(bottom: Platform.isIOS ? 17 : 10);
      },
    );
  }
}

class RescheduleAppointmentButton extends StatelessWidget {
  const RescheduleAppointmentButton({
    required this.widget,
    required this.selectedDate,
    required this.selectedTime,
    required this.availableTimes,
    super.key,
  });

  final BookAppointmentScreen widget;
  final DateTime selectedDate;
  final String? selectedTime;
  final List<String> availableTimes;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppointmentPatientCubit, AppointmentPatientState>(
      listenWhen: (previous, current) =>
          current is AddAppointmentPatientFailure ||
          current is AddAppointmentPatientLoading ||
          current is AddAppointmentPatientSuccess,
      buildWhen: (previous, current) =>
          current is AddAppointmentPatientLoading ||
          current is AddAppointmentPatientSuccess ||
          current is AddAppointmentPatientFailure,
      listener: (context, state) {
        if (state is AddAppointmentPatientFailure) {
          Navigator.pop(context);
          showMessage(
            context,
            message: state.message,
            type: SnackBarType.error,
          );
        } else if (state is AddAppointmentPatientSuccess) {
          Navigator.pop(context);
          if (state.addAppointmentPatientModel.message != null) {
            showMessage(
              context,
              message: state.addAppointmentPatientModel.message!,
              type: SnackBarType.success,
            );
          }
          context.pushNamed(
            Routes.paymentAppointmentScreen,
            arguments: {
              'doctorResults': widget.doctorResults,
              'appointmentId': state.addAppointmentPatientModel.appointmentId,
            },
          );
        } else if (state is AddAppointmentPatientLoading) {
          AdaptiveDialogs.showLoadingAlertDialog(
            context: context,
            title: context.translate(LangKeys.reschedule),
          );
        }
      },
      builder: (context, state) {
        return CustomButton(
          title: LangKeys.reschedule,
          onPressed: () {
            context.read<AppointmentPatientCubit>()
              ..addAppointmentPatient(
                params: AddAppointmentPatientRequest(
                  doctorId: widget.doctorResults.id!,
                  appointmentDate: selectedDate.toString().split(' ')[0],
                  appointmentTime: selectedTime ?? availableTimes.first,
                ),
              )
              ..getAppointmentAvailable(
                doctorId: widget.doctorResults.id!,
              );
          },
        )
            .paddingSymmetric(horizontal: 15)
            .paddingOnly(bottom: Platform.isIOS ? 17 : 10);
      },
    );
  }
}
