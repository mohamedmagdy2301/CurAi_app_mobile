import 'package:curai_app_mobile/core/utils/helper/shimmer_effect.dart';
import 'package:curai_app_mobile/features/appointment/data/models/appointment_available/appointment_available_model.dart';
import 'package:curai_app_mobile/features/appointment/presentation/cubit/appointment_avalible_cubit/appointment_avalible_cubit.dart';
import 'package:curai_app_mobile/features/appointment/presentation/cubit/appointment_avalible_cubit/appointment_avalible_state.dart';
import 'package:curai_app_mobile/features/appointment/presentation/widgets/working_time_details_doctor/working_time_details_doctor_widget.dart';
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
        .read<AppointmentAvailbleCubit>()
        .getAppointmentAvailable(doctorId: widget.doctorId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppointmentAvailbleCubit, AppointmentAvailbleState>(
      buildWhen: (previous, current) =>
          current is AppointmentAvailableFailure ||
          current is AppointmentAvailableSuccess ||
          current is AppointmentAvailableLoading,
      builder: (context, state) {
        if (state is AppointmentAvailableFailure) {
          return Center(
            child: Text(
              state.message,
              style: const TextStyle(color: Colors.red),
            ),
          );
        } else if (state is AppointmentAvailableEmpty) {
          return const SizedBox();
        } else if (state is AppointmentAvailableSuccess) {
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

List<DoctorAvailability> doctorAvailabilityListDome = List.filled(
  4,
  DoctorAvailability(
    day: 'Saturday',
    availableFrom: '10:00',
    availableTo: '5:00',
  ),
);
