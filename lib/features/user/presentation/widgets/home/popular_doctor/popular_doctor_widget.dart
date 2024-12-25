import 'package:carousel_slider/carousel_slider.dart';
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
      child: CarouselSlider.builder(
        options: CarouselOptions(
          height: 130.h,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 5),
          autoPlayCurve: Curves.easeInBack,
          enlargeCenterPage: true,
          viewportFraction: 0.85,
        ),
        itemCount: doctorsList.length,
        itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
          return PopularDoctorItemWidget(
            modelDoctor: doctorsList[itemIndex],
          );
        },
      ),
    );
  }
}
