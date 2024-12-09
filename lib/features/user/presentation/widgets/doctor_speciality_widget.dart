import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartcare_app_mobile/core/helper/functions_helper.dart';
import 'package:smartcare_app_mobile/features/user/presentation/widgets/doctor_speciality_item_widget.dart';

class DoctorSpecialityWidget extends StatelessWidget {
  const DoctorSpecialityWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.h,
      child: ListView.separated(
        itemCount: 8,
        padding: padding(horizontal: 25),
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => spaceWidth(18),
        itemBuilder: (context, index) {
          return const DoctorSpecialityItemWidget();
        },
      ),
    );
  }
}
