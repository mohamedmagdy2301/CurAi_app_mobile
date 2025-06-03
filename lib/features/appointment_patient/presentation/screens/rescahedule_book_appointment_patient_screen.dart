import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/utils/models/doctor_model/doctor_info_model.dart';
import 'package:curai_app_mobile/core/utils/widgets/custom_loading_widget.dart';
import 'package:curai_app_mobile/features/appointment_patient/data/models/my_appointment_patient/my_appointment_patient_model.dart';
import 'package:curai_app_mobile/features/appointment_patient/presentation/cubit/appointment_patient_cubit/appointment_patient_cubit.dart';
import 'package:curai_app_mobile/features/appointment_patient/presentation/cubit/appointment_patient_cubit/appointment_patient_state.dart';
import 'package:curai_app_mobile/features/appointment_patient/presentation/widgets/rescahedule_book_appointment_patient/build_success_reschedule_widget.dart';
import 'package:curai_app_mobile/features/appointment_patient/presentation/widgets/rescahedule_book_appointment_patient/custom_appbar_rescahedule_book_appointment.dart';
import 'package:curai_app_mobile/features/home/presentation/widgets/details_doctor/schedule_tap/build_empty_schedule_widget.dart';
import 'package:curai_app_mobile/features/home/presentation/widgets/details_doctor/schedule_tap/build_error_schedule_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RescaheduleBookAppointmentScreen extends StatefulWidget {
  const RescaheduleBookAppointmentScreen({
    required this.doctorResults,
    required this.appointment,
    super.key,
  });
  final DoctorInfoModel doctorResults;
  final ResultsMyAppointmentPatient appointment;

  @override
  State<RescaheduleBookAppointmentScreen> createState() =>
      _RescaheduleBookAppointmentScreenState();
}

class _RescaheduleBookAppointmentScreenState
    extends State<RescaheduleBookAppointmentScreen> {
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
    return Scaffold(
      appBar: const CustomAppbarRescaheduleBookAppointment(),
      body: BlocBuilder<AppointmentPatientCubit, AppointmentPatientState>(
        buildWhen: (previous, current) =>
            current is AppointmentPatientAvailableFailure ||
            current is AppointmentPatientAvailableSuccess ||
            current is AppointmentPatientAvailableLoading ||
            current is AppointmentPatientAvailableEmpty,
        builder: (context, state) {
          if (state is AppointmentPatientAvailableSuccess) {
            return BuildSuccessRescheduleWidget(
              appointmentAvailableModel: state.appointmentAvailableModel,
              doctorResults: widget.doctorResults,
              appointment: widget.appointment,
            );
          } else if (state is AppointmentPatientAvailableFailure) {
            return BuildErrorScheduleWidget(message: state.message);
          } else if (state is AppointmentPatientAvailableEmpty) {
            return const BuildEmptyScheduleWidget();
          }
          return const CustomLoadingWidget().center();
        },
      ),
    );
  }
}
