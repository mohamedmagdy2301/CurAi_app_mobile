import 'package:curai_app_mobile/core/extensions/int_extensions.dart';
import 'package:curai_app_mobile/features/user/models/doctor_model/popular_doctor_model.dart';
import 'package:curai_app_mobile/features/user/presentation/widgets/home/popular_doctor/popular_doctor_item_widget.dart';
import 'package:flutter/material.dart';

class AllDoctorListviewWidget extends StatelessWidget {
  const AllDoctorListviewWidget({
    required this.filteredItems,
    super.key,
  });

  final List<DoctorModel> filteredItems;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: filteredItems.length,
      separatorBuilder: (context, index) => 10.hSpace,
      itemBuilder: (context, index) {
        return SizedBox(
          height: 130,
          child: PopularDoctorItemWidget(
            doctorModel: filteredItems[index],
          ),
        );
      },
    );
  }
}
