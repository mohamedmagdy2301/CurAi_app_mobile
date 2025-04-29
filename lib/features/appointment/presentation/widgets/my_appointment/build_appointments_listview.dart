// ignore_for_file: inference_failure_on_instance_creation

import 'package:curai_app_mobile/core/extensions/navigation_context_extansions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/routes/routes.dart';
import 'package:curai_app_mobile/core/utils/widgets/custom_button.dart';
import 'package:curai_app_mobile/core/utils/widgets/custom_loading_widget.dart';
import 'package:curai_app_mobile/core/utils/widgets/sankbar/snackbar_helper.dart';
import 'package:curai_app_mobile/features/appointment/data/models/my_appointment/my_appointment_patient_model.dart';
import 'package:curai_app_mobile/features/appointment/presentation/cubit/appointment_patient_cubit/appointment_patient_cubit.dart';
import 'package:curai_app_mobile/features/appointment/presentation/cubit/appointment_patient_cubit/appointment_patient_state.dart';
import 'package:curai_app_mobile/features/appointment/presentation/widgets/my_appointment/appointment_card_widget.dart';
import 'package:curai_app_mobile/features/appointment/presentation/widgets/my_appointment/my_appointment_loading_card.dart';
import 'package:curai_app_mobile/features/home/data/models/doctor_model/doctor_model.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  @override
  Widget build(BuildContext context) {
    return CustomRefreshIndicator(
      onRefresh: () async {
        await Future.delayed(const Duration(milliseconds: 500));
        await widget.cubit.refreshMyAppointmentPatient();
      },
      builder: (context, child, controller) {
        return AnimatedBuilder(
          animation: controller,
          builder: (context, _) {
            return Stack(
              children: [
                if (!controller.isIdle)
                  Positioned(
                    top: controller.value.clamp(0, 1) * 30,
                    left: MediaQuery.of(context).size.width / 2 - 15,
                    child: Transform.scale(
                      scale: controller.value.clamp(0, 1) * 1.5,
                      child: const CustomLoadingWidget(),
                    ),
                  ),
                Transform.translate(
                  offset: Offset(0, 90 * controller.value),
                  child: child,
                ),
              ],
            );
          },
        );
      },
      child: ListView.builder(
        controller: widget.scrollController,
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
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
                topTrailingWidget:
                    _buildNotificationSwitch(isSwitched, appointment, context),
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
        await context
            .read<AppointmentPatientCubit>()
            .getAppointmentAvailable(doctorId: appointment.doctorId!);
        if (context.mounted &&
            context.read<AppointmentPatientCubit>().state
                is AppointmentPatientAvailableSuccess &&
            context.read<AppointmentPatientCubit>().appointmentAvailableModel !=
                null) {
          await context.pushNamed(
            Routes.bookAppointmentScreen,
            arguments: {
              'doctorResults': doctorResults,
              'appointmentAvailableModel': context
                  .read<AppointmentPatientCubit>()
                  .appointmentAvailableModel,
            },
          );
        }
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
