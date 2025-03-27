import 'package:curai_app_mobile/core/extensions/int_extensions.dart'
    as int_ext;
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
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
      width: 310,
      child: Card(
        // color: context.colors.doctorCardBg,
        elevation: .3,
        child: Row(
          children: [
            ImageDoctorWidget(doctorModel: modelDoctor),
            Padding(
              padding: context.padding(horizontal: 15, vertical: 10),
              child: SizedBox(
                width: 172,
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
                      style: TextStyleApp.extraBold16().copyWith(
                        color: context.onPrimaryColor,
                      ),
                    ),
                    8.hSpace,
                    Text(
                      context.isStateArabic
                          ? modelDoctor.locationAr
                          : modelDoctor.locationEn,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyleApp.regular12().copyWith(
                        color: context.onPrimaryColor,
                      ),
                    ),
                    5.hSpace,
                    Text(
                      context.translate(modelDoctor.specialty),
                      style: TextStyleApp.medium12().copyWith(
                        color: context.onPrimaryColor,
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
