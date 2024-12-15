import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:curai_app_mobile/core/helper/functions_helper.dart';
import 'package:curai_app_mobile/features/user/presentation/widgets/home/popular_doctor/popular_doctor_item_widget.dart';

class PopularDoctorWidget extends StatelessWidget {
  const PopularDoctorWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200.h,
      child: ListView.separated(
        itemCount: 8,
        padding: padding(horizontal: 30),
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => spaceWidth(25.w),
        itemBuilder: (context, index) {
          return const PopularDoctorItemWidget();
        },
      ),
    );
  }
}
