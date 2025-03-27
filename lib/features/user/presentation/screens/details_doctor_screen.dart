import 'package:curai_app_mobile/core/extensions/int_extensions.dart'
    as int_ext;
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/core/utils/widgets/custom_button.dart';
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
      body:
          //  Hero(
          //   tag: doctorModel.id.toString(),
          //   child:
          Image.asset(
        doctorModel.imageUrl,
        height: 395,
        width: double.infinity,
        fit: BoxFit.fill,
      ),
      // ),
      bottomSheet: Container(
        height: context.H - 380,
        width: double.infinity,
        decoration: const BoxDecoration(
          // color: context.colors.appBarHome,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(18),
            topRight: Radius.circular(18),
          ),
        ),
        child: Padding(
          padding: context.padding(horizontal: 20, vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              20.hSpace,
              FittedBox(
                child: Text(
                  context.isStateArabic
                      ? doctorModel.nameAr
                      : doctorModel.nameEn,
                  style: TextStyleApp.bold24().copyWith(
                    color: context.onPrimaryColor,
                  ),
                ),
              ),
              10.hSpace,
              FittedBox(
                child: Text(
                  context.isStateArabic
                      ? doctorModel.locationAr
                      : doctorModel.locationEn,
                  style: TextStyleApp.bold24().copyWith(
                    color: context.onPrimaryColor,
                  ),
                ),
              ),
              10.hSpace,
              FittedBox(
                child: Row(
                  spacing: 5,
                  children: [
                    Row(
                      spacing: 3,
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
                      style: TextStyleApp.bold24().copyWith(
                        color: context.onPrimaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Image.asset(
                'assets/images/Map.png',
                height: 140,
                width: double.infinity,
                fit: BoxFit.fill,
              ),
              const Spacer(),
              CustomButton(
                title: LangKeys.appName,
                onPressed: () {},
              ),
              10.hSpace,
            ],
          ),
        ),
      ),
    );
  }
}
