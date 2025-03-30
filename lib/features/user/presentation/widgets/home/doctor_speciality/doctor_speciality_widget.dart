import 'package:curai_app_mobile/core/extensions/int_extensions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/features/user/data/doctor_speciality_list.dart';
import 'package:curai_app_mobile/features/user/presentation/widgets/home/doctor_speciality/doctor_speciality_item_widget.dart';
import 'package:flutter/material.dart';

class DoctorSpecialityWidget extends StatelessWidget {
  const DoctorSpecialityWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.H * 0.15,
      child: ListView.separated(
        itemCount: doctorSpecialityList.length,
        padding: context.padding(horizontal: 10),
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => 16.wSpace,
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
