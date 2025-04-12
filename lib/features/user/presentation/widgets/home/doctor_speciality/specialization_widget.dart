import 'package:curai_app_mobile/core/extensions/int_extensions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/features/user/data/models/specializations_model/specializations_model.dart';
import 'package:curai_app_mobile/features/user/presentation/widgets/home/doctor_speciality/doctor_speciality_item_widget.dart';
import 'package:flutter/material.dart';

class SpecializationWidget extends StatelessWidget {
  const SpecializationWidget({required this.specializationsList, super.key});
  final List<SpecializationsModel> specializationsList;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.H * 0.15,
      child: ListView.separated(
        itemCount: specializationsList.length,
        padding: context.padding(horizontal: 10),
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => 16.wSpace,
        itemBuilder: (context, index) {
          return DoctorSpecialityItemWidget(
            title: specializationsList[index].name,
            image: specializationsList[index].image,
          );
        },
      ),
    );
  }
}
