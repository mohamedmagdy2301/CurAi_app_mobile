// ignore_for_file: lines_longer_than_80_chars

import 'package:curai_app_mobile/core/dependency_injection/service_locator.dart'
    as di;
import 'package:curai_app_mobile/features/appointment_doctor/presentation/cubit/appointment_doctor_cubit.dart';
import 'package:curai_app_mobile/features/appointment_doctor/presentation/widgets/build_working_time_doctor_listview.dart';
import 'package:curai_app_mobile/features/appointment_doctor/presentation/widgets/custom_appbar_working_time_appointment_doctor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WorkingTimeDoctorAvailableScreen extends StatefulWidget {
  const WorkingTimeDoctorAvailableScreen({super.key});

  @override
  State<WorkingTimeDoctorAvailableScreen> createState() =>
      _WorkingTimeDoctorAvailableScreenState();
}

class _WorkingTimeDoctorAvailableScreenState
    extends State<WorkingTimeDoctorAvailableScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppointmentDoctorCubit>(
      create: (context) => di.sl<AppointmentDoctorCubit>(),
      child: const Scaffold(
        appBar: CustomAppbarWorkingTimeAppointmentDoctor(),
        body: BuildWorkingTimeDoctorListview(),
      ),
    );
  }
}
