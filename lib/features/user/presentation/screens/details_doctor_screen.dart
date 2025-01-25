import 'package:curai_app_mobile/core/common/widgets/custom_button.dart';
import 'package:curai_app_mobile/core/extensions/context_sizer_extansions.dart';
import 'package:curai_app_mobile/core/extensions/context_system_extansions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/styles/fonts/font_weight_helper.dart';
import 'package:curai_app_mobile/features/user/models/doctor_model/popular_doctor_model.dart';
import 'package:flutter/material.dart';

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
          height: context.setH(395),
          width: double.infinity,
          fit: BoxFit.fill,
        ),
      ),
      bottomSheet: Container(
        height: context.height - context.setH(380),
        width: double.infinity,
        decoration: BoxDecoration(
          // color: context.colors.appBarHome,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(context.setR(18)),
            topRight: Radius.circular(context.setR(18)),
          ),
        ),
        child: Padding(
          padding: context.padding(horizontal: 20, vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              context.spaceHeight(20),
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
              context.spaceHeight(10),
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
              context.spaceHeight(10),
              FittedBox(
                child: Row(
                  spacing: context.setW(5),
                  children: [
                    Row(
                      spacing: context.setW(3),
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
                height: context.setH(140),
                width: double.infinity,
                fit: BoxFit.fill,
              ),
              const Spacer(),
              CustomButton(
                title: LangKeys.appName,
                onPressed: () {},
              ),
              context.spaceHeight(10),
            ],
          ),
        ),
      ),
    );
  }
}
