import 'package:curai_app_mobile/core/helper/functions_helper.dart';
import 'package:curai_app_mobile/features/user/data/doctor_speciality_list.dart';
import 'package:curai_app_mobile/features/user/presentation/widgets/home/doctor_speciality/doctor_speciality_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoctorSpecialityWidget extends StatelessWidget {
  const DoctorSpecialityWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.h,
      child: ListView.separated(
        itemCount: doctorSpecialityList.length,
        padding: padding(horizontal: 25),
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => spaceWidth(18.w),
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
