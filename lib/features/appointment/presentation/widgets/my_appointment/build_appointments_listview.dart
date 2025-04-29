// ignore_for_file: inference_failure_on_instance_creation, use_build_context_synchronously

import 'dart:developer';

import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/navigation_context_extansions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/routes/routes.dart';
import 'package:curai_app_mobile/core/utils/widgets/adaptive_dialogs/adaptive_dialogs.dart';
import 'package:curai_app_mobile/core/utils/widgets/custom_button.dart';
import 'package:curai_app_mobile/core/utils/widgets/sankbar/snackbar_helper.dart';
import 'package:curai_app_mobile/features/appointment/data/models/my_appointment/my_appointment_patient_model.dart';
import 'package:curai_app_mobile/features/appointment/presentation/cubit/appointment_patient_cubit/appointment_patient_cubit.dart';
import 'package:curai_app_mobile/features/appointment/presentation/cubit/appointment_patient_cubit/appointment_patient_state.dart';
import 'package:curai_app_mobile/features/appointment/presentation/widgets/my_appointment/appointment_card_widget.dart';
import 'package:curai_app_mobile/features/appointment/presentation/widgets/my_appointment/my_appointment_loading_card.dart';
import 'package:curai_app_mobile/features/home/data/models/doctor_model/doctor_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class BuildAppointmentsList extends StatefulWidget {
  const BuildAppointmentsList({
    required this.cubit,
    required this.appointments,
    required this.scrollController,
    required this.isLoadingMore,
    required this.isPending,
    super.key,
  });

  final AppointmentPatientCubit cubit;
  final List<ResultsMyAppointmentPatient> appointments;
  final ScrollController scrollController;
  final bool isLoadingMore;
  final bool isPending;

  @override
  State<BuildAppointmentsList> createState() => _BuildAppointmentsListState();
}

class _BuildAppointmentsListState extends State<BuildAppointmentsList> {
  final Map<int, bool> isSwitchedMap = {};

  @override
  void didUpdateWidget(covariant BuildAppointmentsList oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.appointments != oldWidget.appointments) {
      for (final appointment in widget.appointments) {
        isSwitchedMap.putIfAbsent(appointment.id!, () => false);
      }
    }
  }

  final RefreshController _refreshController = RefreshController();
  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      // enablePullUp: widget.cubit.isLast,
      controller: _refreshController,
      header: const WaterDropHeader(),
      // footer: const ClassicFooter(),
      onRefresh: () async {
        log(' --------------------------------------------------');

        try {
          await Future.delayed(const Duration(milliseconds: 500));

          await widget.cubit.refreshMyAppointmentPatient();
          _refreshController.refreshCompleted();
        } on Exception {
          _refreshController.refreshFailed();
        }
      },
      // onLoading: () async {
      //   log('onLoading--------------------------------------------------');
      //   try {
      //     await Future.delayed(const Duration(milliseconds: 500));
      //     await widget.cubit.getMyAppointmentPatient();
      //     _refreshController.loadComplete();
      //   } on Exception {
      //     _refreshController.loadFailed();
      //   }
      // },
      child: ListView.builder(
        controller: widget.scrollController,
        physics: const AlwaysScrollableScrollPhysics(
          parent: ClampingScrollPhysics(),
        ),
        itemCount: widget.appointments.length + (widget.isLoadingMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index < widget.appointments.length) {
            final appointment = widget.appointments[index];
            final doctorResults =
                widget.cubit.doctorsData[appointment.doctorId];

            if (doctorResults == null) {
              return const SizedBox();
            }

            final isSwitched = isSwitchedMap[appointment.id] ?? false;

            if (widget.isPending) {
              return AppointmentCardWidget(
                appointment: appointment,
                doctorResults: doctorResults,
                topTrailingWidget: const Spacer(),
                bottomButton: _buildPaymentBookButton(
                  context,
                  doctorResults,
                  appointment,
                ),
              );
            } else {
              return AppointmentCardWidget(
                appointment: appointment,
                doctorResults: doctorResults,
                topTrailingWidget: _buildNotificationSwitch(
                  isSwitched,
                  appointment,
                  context,
                ),
                bottomButton: _buildRescheduleButton(
                  context,
                  doctorResults,
                  appointment,
                ),
              );
            }
          }
          return const MyAppointmentCardLoadingList();
        },
      ),
    );
  }

  CustomButton _buildRescheduleButton(
    BuildContext context,
    DoctorResults doctorResults,
    ResultsMyAppointmentPatient appointment,
  ) {
    return CustomButton(
      isHalf: true,
      title: LangKeys.reschedule,
      onPressed: () async {
        await AdaptiveDialogs.showOkCancelAlertDialog(
          context: context,
          title: context.translate(LangKeys.reschedule),
          message: context.translate(LangKeys.rescheduleMessage),
          onPressedOk: () async {
            final cubit = context.read<AppointmentPatientCubit>();

            await cubit.getAppointmentAvailable(
              doctorId: appointment.doctorId!,
            );

            if (cubit.state is AppointmentPatientAvailableSuccess &&
                cubit.appointmentAvailableModel != null) {
              await context.pushNamed(
                Routes.bookAppointmentScreen,
                arguments: {
                  'isReschedule': true,
                  'appointmentId': appointment.id,
                  'doctorResults': doctorResults,
                  'appointmentAvailableModel': cubit.appointmentAvailableModel,
                },
              );
            }
          },
        );
      },
    );
  }

  CustomButton _buildPaymentBookButton(
    BuildContext context,
    DoctorResults doctorResults,
    ResultsMyAppointmentPatient appointment,
  ) {
    return CustomButton(
      isHalf: true,
      title: LangKeys.paymentBook,
      onPressed: () {
        context.pushNamed(
          Routes.paymentAppointmentScreen,
          arguments: {
            'doctorResults': doctorResults,
            'appointmentId': appointment.id,
          },
        );
      },
    );
  }

  Switch _buildNotificationSwitch(
    bool isSwitched,
    ResultsMyAppointmentPatient appointment,
    BuildContext context,
  ) {
    return Switch.adaptive(
      value: isSwitched,
      onChanged: (value) {
        setState(() {
          isSwitchedMap[appointment.id!] = value;
        });

        showMessage(
          context,
          type: SnackBarType.success,
          message: value
              ? 'You have successfully enabled notifications 🔔'
              : 'You have successfully disabled notifications 🔕',
        );
      },
    );
  }
}
