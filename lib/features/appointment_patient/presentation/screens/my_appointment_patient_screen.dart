import 'package:curai_app_mobile/features/appointment_patient/presentation/widgets/my_appointment/appointments_patient_body_widget.dart';
import 'package:curai_app_mobile/features/appointment_patient/presentation/widgets/my_appointment/custom_appbar_my_appointment_patient.dart';
import 'package:flutter/material.dart';

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
    return Scaffold(
      appBar: CustomAppbarMyAppointmentPatient(tabController: tabController),
      body: TabBarView(
        controller: tabController,
        children: const [
          AppointmentsPatientBodyWidget(isPending: false),
          AppointmentsPatientBodyWidget(isPending: true),
        ],
      ),
    );
  }
}
