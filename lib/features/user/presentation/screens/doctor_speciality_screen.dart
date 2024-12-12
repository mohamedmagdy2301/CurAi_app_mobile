import 'package:curai_app_mobile/features/user/presentation/widgets/custom_appbar_doctor_specialities.dart';
import 'package:curai_app_mobile/features/user/presentation/widgets/filter_doctor_speciality_widget.dart';
import 'package:flutter/material.dart';

class DoctorSpecialitiesScreen extends StatelessWidget {
  const DoctorSpecialitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBarDoctorSpecialities(),
      body: FilterDoctorSpeciality(),
    );
  }
}
