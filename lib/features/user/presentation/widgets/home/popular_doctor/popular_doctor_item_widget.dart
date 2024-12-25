import 'package:curai_app_mobile/core/extensions/context_extansions.dart';
import 'package:curai_app_mobile/core/helper/functions_helper.dart';
import 'package:curai_app_mobile/core/styles/fonts/font_weight_helper.dart';
import 'package:curai_app_mobile/features/user/models/doctor_model/popular_doctor_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PopularDoctorItemWidget extends StatelessWidget {
  const PopularDoctorItemWidget({
    required this.modelDoctor,
    super.key,
  });
  final DoctorModel modelDoctor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 310.w,
      child: Card(
        // color: context.colors.doctorCardBg,
        elevation: .3,
        child: Row(
          children: [
            ImageDoctorWidget(modelDoctor: modelDoctor),
            Padding(
              padding: padding(horizontal: 15, vertical: 10),
              child: SizedBox(
                width: 172.w,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isArabic() ? modelDoctor.nameAr : modelDoctor.nameEn,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.textTheme.bodyLarge!.copyWith(
                        color: context.colors.bodyTextOnboarding,
                        fontWeight: FontWeightHelper.extraBold,
                      ),
                    ),
                    spaceHeight(8),
                    Text(
                      isArabic()
                          ? modelDoctor.locationAr
                          : modelDoctor.locationEn,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.textTheme.bodySmall!.copyWith(
                        color: context.colors.textColorLight,
                        fontWeight: FontWeightHelper.regular,
                      ),
                    ),
                    spaceHeight(5),
                    Text(
                      context.translate(modelDoctor.specialty),
                      style: context.textTheme.bodySmall!.copyWith(
                        color: context.colors.textColorLight,
                      ),
                    ),
                    const Spacer(),
                    DateDoctorWidget(modelDoctor: modelDoctor),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DateDoctorWidget extends StatelessWidget {
  const DateDoctorWidget({
    required this.modelDoctor,
    super.key,
  });

  final DoctorModel modelDoctor;
  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8.w,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          isArabic() ? modelDoctor.dateAr : modelDoctor.dateEn,
          style: context.textTheme.labelSmall!.copyWith(
            color: context.colors.bodyTextOnboarding,
            fontWeight: FontWeightHelper.regular,
          ),
        ),
        RateingDoctorWidget(modelDoctor: modelDoctor),
      ],
    );
  }
}

class ImageDoctorWidget extends StatelessWidget {
  const ImageDoctorWidget({
    required this.modelDoctor,
    super.key,
  });

  final DoctorModel modelDoctor;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(isArabic() ? 12.r : 2.r),
        bottomRight: Radius.circular(isArabic() ? 12.r : 2.r),
        bottomLeft: Radius.circular(isArabic() ? 2.r : 12.r),
        topLeft: Radius.circular(isArabic() ? 2.r : 12.r),
      ),
      child: Image.asset(
        modelDoctor.imageUrl,
        height: 130.w,
        width: 90.w,
        fit: BoxFit.cover,
      ),
    );
  }
}

class RateingDoctorWidget extends StatelessWidget {
  const RateingDoctorWidget({
    required this.modelDoctor,
    super.key,
  });

  final DoctorModel modelDoctor;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 5.w,
      children: [
        Icon(Icons.star, color: Colors.amber, size: 15.sp),
        Text(
          isArabic() ? modelDoctor.ratingAr : modelDoctor.ratingEn,
          style: context.textTheme.labelSmall!.copyWith(
            color: context.colors.bodyTextOnboarding,
            fontWeight: FontWeightHelper.bold,
          ),
        ),
      ],
    );
  }
}
