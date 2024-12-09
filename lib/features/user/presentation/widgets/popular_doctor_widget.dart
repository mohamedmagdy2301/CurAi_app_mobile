import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartcare_app_mobile/core/extensions/context_extansions.dart';
import 'package:smartcare_app_mobile/core/helper/functions_helper.dart';
import 'package:smartcare_app_mobile/core/styles/fonts/font_weight_helper.dart';
//TODO: change images, names ,colors

class PopularDoctorWidget extends StatelessWidget {
  const PopularDoctorWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200.h,
      child: ListView.separated(
        itemCount: 8,
        padding: padding(horizontal: 30),
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => spaceWidth(25),
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15.r),
                child: Image.asset(
                  'assets/images/onboarding-doctor-4.png',
                  height: 120.h,
                  width: 140.w,
                  fit: BoxFit.fill,
                ),
              ),
              spaceHeight(10),
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.amber, size: 15),
                  Text(
                    '4.5',
                    style: context.textTheme.bodySmall!.copyWith(
                      color: context.colors.bodyTextOnboarding,
                    ),
                  ),
                ],
              ),
              spaceHeight(5),
              Text(
                'Mohamed Magdy',
                style: context.textTheme.labelLarge!.copyWith(
                  color: context.colors.bodyTextOnboarding,
                  fontWeight: FontWeightHelper.black,
                ),
              ),
              spaceHeight(5),
              Text(
                'Neurologist',
                style: context.textTheme.bodySmall!.copyWith(
                  color: context.colors.textColorLight,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
