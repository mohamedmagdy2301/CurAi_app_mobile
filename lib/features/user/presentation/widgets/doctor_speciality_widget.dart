import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartcare_app_mobile/core/extensions/context_extansions.dart';
import 'package:smartcare_app_mobile/core/helper/functions_helper.dart';

class DoctorSpecialityWidget extends StatelessWidget {
  const DoctorSpecialityWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.h,
      child: ListView.separated(
        itemCount: 8,
        padding: padding(horizontal: 8),
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => spaceWidth(25),
        itemBuilder: (context, index) {
          return Column(
            children: [
              CircleAvatar(
                backgroundColor: context.colors.iconSocialBG!.withOpacity(.6),
                radius: 28.r,
                child: Image.asset(
                  'assets/images/Brain.png',
                  height: 26.h,
                  width: 26.w,
                  fit: BoxFit.fill,
                ),
              ),
              spaceHeight(15),
              Text(
                'Neurologic',
                style: context.textTheme.bodySmall!.copyWith(
                  //TODO: change color
                  color: context.colors.bodyTextOnboarding,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
