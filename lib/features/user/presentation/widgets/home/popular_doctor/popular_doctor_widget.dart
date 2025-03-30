import 'package:curai_app_mobile/features/user/data/models/doctor/doctor_model.dart';
import 'package:curai_app_mobile/features/user/presentation/widgets/home/popular_doctor/popular_doctor_item_widget.dart';
import 'package:flutter/material.dart';

class PopularDoctorWidget extends StatelessWidget {
  const PopularDoctorWidget({required this.doctorsList, super.key});
  final List<DoctorModel> doctorsList;
  @override
  Widget build(BuildContext context) {
    return
        //  CarouselSlider.builder(
        //   options: CarouselOptions(
        //     height: context.H * 0.16,
        //     autoPlay: true,
        //     autoPlayInterval: const Duration(seconds: 10),
        //     autoPlayCurve: Curves.easeInBack,
        //     enlargeCenterPage: true,
        //     viewportFraction: .9,
        //   ),
        ListView.builder(
      itemCount: doctorsList.length,
      itemBuilder: (BuildContext context, int itemIndex) {
        return PopularDoctorItemWidget(
          doctorModel: doctorsList[itemIndex],
        );
      },
    );
  }
}
