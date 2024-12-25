import 'package:curai_app_mobile/core/helper/functions_helper.dart';
import 'package:curai_app_mobile/features/user/data/doctors_list.dart';
import 'package:curai_app_mobile/features/user/presentation/widgets/home/popular_doctor/popular_doctor_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PopularDoctorWidget extends StatelessWidget {
  const PopularDoctorWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130.h,
      child: ListView.separated(
        itemCount: doctorsList.length,
        padding: padding(horizontal: 20),
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => spaceWidth(25.w),
        itemBuilder: (context, index) {
          return PopularDoctorItemWidget(
            modelDoctor: doctorsList[index],
          );
        },
      ),
    );
  }
}
