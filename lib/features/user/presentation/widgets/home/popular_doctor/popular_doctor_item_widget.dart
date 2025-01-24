import 'package:curai_app_mobile/core/extensions/context_system_extansions.dart';
import 'package:curai_app_mobile/core/styles/fonts/font_weight_helper.dart';
import 'package:curai_app_mobile/features/user/models/doctor_model/popular_doctor_model.dart';
import 'package:curai_app_mobile/features/user/presentation/widgets/home/popular_doctor/date_doctor_widget.dart';
import 'package:curai_app_mobile/features/user/presentation/widgets/home/popular_doctor/image_doctor_widget.dart';
import 'package:flutter/material.dart';

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
            ImageDoctorWidget(doctorModel: modelDoctor),
            Padding(
              padding: context.padding(horizontal: 15, vertical: 10),
              child: SizedBox(
                width: 172.w,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.isStateArabic
                          ? modelDoctor.nameAr
                          : modelDoctor.nameEn,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.textTheme.bodyLarge!.copyWith(
                        // color: context.colors.bodyTextOnboarding,
                        fontWeight: FontWeightHelper.extraBold,
                      ),
                    ),
                    spaceHeight(8),
                    Text(
                      context.isStateArabic
                          ? modelDoctor.locationAr
                          : modelDoctor.locationEn,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.textTheme.bodySmall!.copyWith(
                        // color: context.colors.textColorLight,
                        fontWeight: FontWeightHelper.regular,
                      ),
                    ),
                    spaceHeight(5),
                    Text(
                      context.translate(modelDoctor.specialty),
                      style: context.textTheme.bodySmall!.copyWith(
                          // color: context.colors.textColorLight,
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
