import 'package:curai_app_mobile/features/user/models/doctor_speciality_model/doctor_speciality_model.dart';
import 'package:curai_app_mobile/features/user/presentation/widgets/home/doctor_speciality/doctor_speciality_item_widget.dart';
import 'package:flutter/material.dart';

class DoctorSpecialitiesGridList extends StatelessWidget {
  const DoctorSpecialitiesGridList({
    required this.filteredItems,
    super.key,
  });

  final List<DoctorSpecialityModel> filteredItems;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: filteredItems.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 20,
        crossAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        return DoctorSpecialityItemWidget(
          title: filteredItems[index].name,
          image: filteredItems[index].image,
        );
      },
    );
  }
}
