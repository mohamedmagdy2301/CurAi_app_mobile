import 'package:curai_app_mobile/core/extensions/context_extansions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/features/user/presentation/widgets/filter_doctor_speciality_widget.dart';
import 'package:flutter/material.dart';

class DoctorSpecialitiesScreen extends StatelessWidget {
  const DoctorSpecialitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(context.translate(LangKeys.doctorSpeciality)),
        centerTitle: true,
      ),
      body: const FilterDoctorSpeciality(),
    );
  }
}
