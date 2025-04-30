// ignore_for_file: lines_longer_than_80_chars

import 'package:curai_app_mobile/features/appointment_doctor/presentation/widgets/build_working_time_doctor_listview.dart';
import 'package:curai_app_mobile/features/appointment_doctor/presentation/widgets/custom_appbar_working_time_appointment_doctor.dart';
import 'package:flutter/material.dart';

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
    return const Scaffold(
      appBar: CustomAppbarWorkingTimeAppointmentDoctor(),
      body: BuildWorkingTimeDoctorListview(),
    );
  }
}
