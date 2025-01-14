import 'package:carousel_slider/carousel_slider.dart';
import 'package:curai_app_mobile/features/user/data/doctors_list.dart';
import 'package:curai_app_mobile/features/user/presentation/widgets/home/popular_doctor/popular_doctor_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PopularDoctorWidget extends StatelessWidget {
  const PopularDoctorWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      options: CarouselOptions(
        height: 135.h,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 10),
        autoPlayCurve: Curves.easeInBack,
        enlargeCenterPage: true,
        viewportFraction: .9,
      ),
      itemCount: doctorsList.length,
      itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
        return PopularDoctorItemWidget(
          modelDoctor: doctorsList[itemIndex],
        );
      },
    );
  }
}
