import 'package:curai_app_mobile/core/helper/functions_helper.dart';
import 'package:curai_app_mobile/features/user/models/doctor_model/popular_doctor_model.dart';
import 'package:curai_app_mobile/features/user/presentation/widgets/home/popular_doctor/popular_doctor_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AllDoctorListviewWidget extends StatelessWidget {
  const AllDoctorListviewWidget({
    required this.filteredItems,
    super.key,
  });

  final List<DoctorModel> filteredItems;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding(horizontal: 20),
      child: ListView.separated(
        itemCount: filteredItems.length,
        separatorBuilder: (context, index) => spaceHeight(20),
        itemBuilder: (context, index) {
          return SizedBox(
            height: 130.h,
            child: PopularDoctorItemWidget(
              modelDoctor: filteredItems[index],
            ),
          );
        },
      ),
    );
  }
}
