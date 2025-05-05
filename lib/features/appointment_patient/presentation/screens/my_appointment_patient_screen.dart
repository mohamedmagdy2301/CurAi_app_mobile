import 'package:curai_app_mobile/core/dependency_injection/service_locator.dart';
import 'package:curai_app_mobile/features/appointment_patient/presentation/cubit/appointment_patient_cubit/appointment_patient_cubit.dart';
import 'package:curai_app_mobile/features/appointment_patient/presentation/widgets/my_appointment/appointments_patient_body_widget.dart';
import 'package:curai_app_mobile/features/appointment_patient/presentation/widgets/my_appointment/custom_appbar_my_appointment_patient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyAppointmentPatientScreen extends StatefulWidget {
  const MyAppointmentPatientScreen({super.key});

  @override
  State<MyAppointmentPatientScreen> createState() =>
      _MyAppointmentPatientScreenState();
}

class _MyAppointmentPatientScreenState extends State<MyAppointmentPatientScreen>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppointmentPatientCubit>(
      create: (context) => sl<AppointmentPatientCubit>(),
      child: Scaffold(
        appBar: CustomAppbarMyAppointmentPatient(tabController: tabController),
        body: TabBarView(
          controller: tabController,
          children: const [
            AppointmentsPatientBodyWidget(isPending: true),
            AppointmentsPatientBodyWidget(isPending: false),
          ],
        ),
      ),
    );
  }
}
