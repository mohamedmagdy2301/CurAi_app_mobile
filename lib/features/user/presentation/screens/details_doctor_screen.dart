import 'package:curai_app_mobile/core/common/widgets/custom_button.dart';
import 'package:curai_app_mobile/core/extensions/context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/settings_context_extansions.dart';
import 'package:curai_app_mobile/core/helper/functions_helper.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/styles/fonts/font_weight_helper.dart';
import 'package:curai_app_mobile/features/user/models/doctor_model/popular_doctor_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoctorDetailsScreen extends StatelessWidget {
  const DoctorDetailsScreen({required this.doctorModel, super.key});

  final DoctorModel doctorModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(context.isStateArabic ? doctorModel.nameAr : doctorModel.nameEn),
      //   centerTitle: true,
      // ),
      body: Hero(
        tag: doctorModel.id.toString(),
        child: Image.asset(
          doctorModel.imageUrl,
          height: 395.h,
          width: double.infinity,
          fit: BoxFit.fill,
        ),
      ),
      bottomSheet: Container(
        height: context.height - 380.h,
        width: double.infinity,
        decoration: BoxDecoration(
          // color: context.colors.appBarHome,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(18.r),
            topRight: Radius.circular(18.r),
          ),
        ),
        child: Padding(
          padding: padding(horizontal: 20, vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              spaceHeight(20),
              FittedBox(
                child: Text(
                  context.isStateArabic
                      ? doctorModel.nameAr
                      : doctorModel.nameEn,
                  style: context.textTheme.headlineLarge!.copyWith(
                    // color: context.colors.bodyTextOnboarding,
                    fontWeight: FontWeightHelper.bold,
                  ),
                ),
              ),
              spaceHeight(10),
              FittedBox(
                child: Text(
                  context.isStateArabic
                      ? doctorModel.locationAr
                      : doctorModel.locationEn,
                  style: context.textTheme.bodyMedium!.copyWith(
                      // color: context.colors.bodyTextOnboarding,
                      ),
                ),
              ),
              spaceHeight(10),
              FittedBox(
                child: Row(
                  spacing: 10.w,
                  children: [
                    Row(
                      spacing: 3.w,
                      children: List.generate(
                        int.parse(doctorModel.ratingEn.split('.').first),
                        (index) => const Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 18,
                        ),
                      ),
                    ),
                    Text(
                      context.isStateArabic
                          ? doctorModel.ratingAr
                          : doctorModel.ratingEn,
                      style: context.textTheme.bodyLarge!.copyWith(
                        // color: context.colors.bodyTextOnboarding,
                        fontWeight: FontWeightHelper.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Image.asset(
                'assets/images/Map.png',
                height: 140.h,
                width: double.infinity,
                fit: BoxFit.fill,
              ),
              const Spacer(),
              CustemButton(
                title: LangKeys.appName,
                onPressed: () {},
              ),
              spaceHeight(10),
            ],
          ),
        ),
      ),
    );
  }
}
