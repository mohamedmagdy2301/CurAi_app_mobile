import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/utils/models/doctor_model/doctor_info_model.dart';
import 'package:curai_app_mobile/core/utils/widgets/custom_loading_widget.dart';
import 'package:curai_app_mobile/features/appointment_patient/presentation/cubit/appointment_patient_cubit/appointment_patient_cubit.dart';
import 'package:curai_app_mobile/features/appointment_patient/presentation/cubit/appointment_patient_cubit/appointment_patient_state.dart';
import 'package:curai_app_mobile/features/home/presentation/widgets/details_doctor/schedule_tap/build_empty_schedule_widget.dart';
import 'package:curai_app_mobile/features/home/presentation/widgets/details_doctor/schedule_tap/build_error_schedule_widget.dart';
import 'package:curai_app_mobile/features/home/presentation/widgets/details_doctor/schedule_tap/build_success_schedule_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScheduleTap extends StatefulWidget {
  const ScheduleTap({
    required this.doctorResults,
    super.key,
  });

  final DoctorInfoModel doctorResults;

  @override
  State<ScheduleTap> createState() => _ScheduleTapState();
}

class _ScheduleTapState extends State<ScheduleTap> {
  @override
  void initState() {
    super.initState();
    _fetchAvailableAppointments();
  }

  void _fetchAvailableAppointments() {
    context
        .read<AppointmentPatientCubit>()
        .getAppointmentPatientAvailable(doctorId: widget.doctorResults.id!);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppointmentPatientCubit, AppointmentPatientState>(
      buildWhen: (previous, current) =>
          current is AppointmentPatientAvailableFailure ||
          current is AppointmentPatientAvailableSuccess ||
          current is AppointmentPatientAvailableLoading ||
          current is AppointmentPatientAvailableEmpty,
      builder: (context, state) {
        if (state is AppointmentPatientAvailableSuccess) {
          return BuildSuccessScheduleWidget(
            appointmentAvailableModel: state.appointmentAvailableModel,
            doctorResults: widget.doctorResults,
          );
        } else if (state is AppointmentPatientAvailableFailure) {
          return BuildErrorScheduleWidget(message: state.message);
        } else if (state is AppointmentPatientAvailableEmpty) {
          return const BuildEmptyScheduleWidget();
        }
        return const CustomLoadingWidget().center();
      },
    );
  }
}
