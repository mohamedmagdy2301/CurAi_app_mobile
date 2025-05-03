import 'package:curai_app_mobile/core/utils/helper/shimmer_effect.dart';
import 'package:curai_app_mobile/features/appointment_patient/data/models/appointment_patient_available/appointment_patient_available_model.dart';
import 'package:curai_app_mobile/features/appointment_patient/presentation/cubit/appointment_patient_cubit/appointment_patient_cubit.dart';
import 'package:curai_app_mobile/features/appointment_patient/presentation/cubit/appointment_patient_cubit/appointment_patient_state.dart';
import 'package:curai_app_mobile/features/appointment_patient/presentation/widgets/working_time_details_doctor/working_time_details_doctor_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class BuildWorkingTimeDetailsDoctorWidget extends StatefulWidget {
  const BuildWorkingTimeDetailsDoctorWidget({
    required this.doctorId,
    super.key,
  });
  final int doctorId;

  @override
  State<BuildWorkingTimeDetailsDoctorWidget> createState() =>
      _BuildWorkingTimeDetailsDoctorWidgetState();
}

class _BuildWorkingTimeDetailsDoctorWidgetState
    extends State<BuildWorkingTimeDetailsDoctorWidget> {
  @override
  void initState() {
    context
        .read<AppointmentPatientCubit>()
        .getAppointmentPatientAvailable(doctorId: widget.doctorId);
    super.initState();
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
        if (state is AppointmentPatientAvailableFailure) {
          return Center(
            child: Text(
              state.message,
              style: const TextStyle(color: Colors.red),
            ),
          );
        } else if (state is AppointmentPatientAvailableEmpty) {
          return const SizedBox();
        } else if (state is AppointmentPatientAvailableSuccess) {
          return WorkingTimeDetailsDoctorWidget(
            doctorAvailability:
                state.appointmentAvailableModel.doctorAvailability!,
          );
        }
        return Skeletonizer(
          effect: shimmerEffect(context),
          child: WorkingTimeDetailsDoctorWidget(
            doctorAvailability: doctorAvailabilityListDome,
          ),
        );
      },
    );
  }
}

List<DoctorPatientAvailability> doctorAvailabilityListDome = List.filled(
  4,
  DoctorPatientAvailability(
    day: 'Saturday',
    availableFrom: '10:00',
    availableTo: '5:00',
  ),
);
