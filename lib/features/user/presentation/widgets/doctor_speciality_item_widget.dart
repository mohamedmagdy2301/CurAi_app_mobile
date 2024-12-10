import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:curai_app_mobile/core/extensions/context_extansions.dart';
import 'package:curai_app_mobile/core/helper/functions_helper.dart';

class DoctorSpecialityItemWidget extends StatelessWidget {
  const DoctorSpecialityItemWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: context.colors.iconSocialBG!.withOpacity(.6),
          radius: 26.r,
          child: Image.asset(
            'assets/images/Brain.png',
            height: 25.h,
            width: 25.w,
            fit: BoxFit.fill,
          ),
        ),
        spaceHeight(15),
        Text(
          isArabic() ? 'العصبية' : 'Neurologic',
          style: context.textTheme.bodySmall!.copyWith(
            //TODO: change color
            color: context.colors.bodyTextOnboarding,
          ),
        ),
      ],
    );
  }
}
