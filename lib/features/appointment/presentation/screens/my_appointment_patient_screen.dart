// ignore_for_file: lines_longer_than_80_chars, avoid_field_initializers_in_const_classes, document_ignores

import 'package:curai_app_mobile/features/appointment/presentation/widgets/my_appointment/custom_appbar_my_appointment.dart';
import 'package:curai_app_mobile/features/profile/presentation/widgets/help_center/contact_us_body_listview.dart';
import 'package:curai_app_mobile/features/profile/presentation/widgets/help_center/faq_body_listview.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbarMyAppointment(tabController: tabController),
      body: _bodyWidget[tabController.index],
    );
  }

  final List<Widget> _bodyWidget = [
    const FAQBodyListView(),
    const ContactUsBodyListview(),
  ];
}
