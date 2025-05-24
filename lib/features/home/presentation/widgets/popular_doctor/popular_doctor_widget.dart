import 'package:curai_app_mobile/features/home/data/models/doctor_model/doctor_model.dart';
import 'package:curai_app_mobile/features/home/presentation/widgets/popular_doctor/popular_doctor_item_widget.dart';
import 'package:flutter/material.dart';

class PopularDoctorWidget extends StatelessWidget {
  const PopularDoctorWidget({required this.doctorsList, super.key});
  final List<DoctorResults> doctorsList;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: doctorsList.length,
      itemBuilder: (BuildContext context, int itemIndex) {
        return DoctorItemWidget(
          doctorResults: doctorsList[itemIndex],
        );
      },
    );
  }
}
