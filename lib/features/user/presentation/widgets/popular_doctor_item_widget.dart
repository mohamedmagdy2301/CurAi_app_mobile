import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartcare_app_mobile/core/extensions/context_extansions.dart';
import 'package:smartcare_app_mobile/core/helper/functions_helper.dart';
import 'package:smartcare_app_mobile/core/styles/fonts/font_weight_helper.dart';

//TODO: change images, names ,colors
class PopularDoctorItemWidget extends StatelessWidget {
  const PopularDoctorItemWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
            const Icon(Icons.star, color: Colors.amber, size: 15),
            const Icon(Icons.star, color: Colors.amber, size: 15),
            const Icon(Icons.star, color: Colors.amber, size: 15),
            spaceWidth(20),
            Text(
              '4.0',
              style: context.textTheme.bodySmall!.copyWith(
                color: context.colors.bodyTextOnboarding,
              ),
            ),
          ],
        ),
        spaceHeight(5),
        Text(
          isArabic() ? 'محــمد مجـــدي' : 'Mohamed Magdy',
          style: context.textTheme.labelLarge!.copyWith(
            color: context.colors.bodyTextOnboarding,
            fontWeight: FontWeightHelper.black,
          ),
        ),
        spaceHeight(5),
        Text(
          isArabic() ? 'العصبية' : 'Neurologic',
          style: context.textTheme.bodySmall!.copyWith(
            color: context.colors.textColorLight,
          ),
        ),
      ],
    );
  }
}
