import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/features/user/data/models/doctor/doctor_model.dart';
import 'package:curai_app_mobile/features/user/presentation/widgets/home/popular_doctor/date_doctor_widget.dart';
import 'package:curai_app_mobile/features/user/presentation/widgets/home/popular_doctor/image_doctor_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PopularDoctorItemWidget extends StatelessWidget {
  const PopularDoctorItemWidget({
    required this.doctorModel,
    super.key,
  });
  final DoctorModel doctorModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // onTap: () => context.push(DoctorDetailsScreen(doctorModel: doctorModel)),
      borderRadius: BorderRadius.circular(10.r),
      child: Card(
        elevation: 4,
        shadowColor: context.primaryColor.withAlpha(100),
        child: Row(
          children: [
            ImageDoctorWidget(doctorModel: doctorModel),
            Column(
              spacing: 3.h,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: context.W * .55,
                  child: AutoSizeText(
                    doctorModel.username ?? '',
                    maxLines: 1,
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyleApp.extraBold24().copyWith(
                      color: context.onPrimaryColor,
                    ),
                  ),
                ),
                SizedBox(
                  width: context.W * .55,
                  child: AutoSizeText(
                    doctorModel.email ?? '',
                    maxLines: 1,
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyleApp.bold16().copyWith(
                      color: context.onPrimaryColor,
                    ),
                  ),
                ),
                SizedBox(
                  width: context.W * .55,
                  child: AutoSizeText(
                    doctorModel.location ?? '',
                    maxLines: 1,
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyleApp.medium14().copyWith(
                      color: context.onPrimaryColor,
                    ),
                  ),
                ),
                DateDoctorWidget(doctorModel: doctorModel),
              ],
            ).paddingSymmetric(horizontal: 12, vertical: 5),
          ],
        ),
      ),
    ).paddingSymmetric(horizontal: 18);
  }
}
