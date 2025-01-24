import 'package:curai_app_mobile/core/extensions/context_sizer_extansions.dart';
import 'package:curai_app_mobile/features/user/data/doctor_speciality_list.dart';
import 'package:curai_app_mobile/features/user/presentation/widgets/home/doctor_speciality/doctor_speciality_item_widget.dart';
import 'package:flutter/material.dart';

class DoctorSpecialityWidget extends StatelessWidget {
  const DoctorSpecialityWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.setH(100),
      child: ListView.separated(
        itemCount: doctorSpecialityList.length,
        padding: context.padding(horizontal: 25),
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => context.spaceWidth(18),
        itemBuilder: (context, index) {
          return DoctorSpecialityItemWidget(
            title: doctorSpecialityList[index].name,
            image: doctorSpecialityList[index].image,
          );
        },
      ),
    );
  }
}
