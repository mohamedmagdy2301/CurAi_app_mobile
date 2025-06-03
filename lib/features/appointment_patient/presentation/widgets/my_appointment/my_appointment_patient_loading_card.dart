import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/extensions/int_extensions.dart';
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/string_extensions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/core/styles/images/app_images.dart';
import 'package:curai_app_mobile/core/utils/helper/shimmer_effect.dart';
import 'package:curai_app_mobile/core/utils/models/doctor_model/doctor_info_model.dart';
import 'package:curai_app_mobile/core/utils/widgets/custom_button.dart';
import 'package:curai_app_mobile/core/utils/widgets/custom_cached_network_image.dart';
import 'package:curai_app_mobile/features/home/presentation/widgets/popular_doctor/rateing_doctor_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MyAppointmentPatientCardLoading extends StatelessWidget {
  const MyAppointmentPatientCardLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          color: context.isDark ? Colors.black : Colors.white,
          margin: const EdgeInsets.only(top: 20),
          child: Column(
            children: [
              Row(
                children: [
                  AutoSizeText(
                    '2025-04-29'.toReadableDate(context),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyleApp.semiBold18().copyWith(
                      color: context.onPrimaryColor,
                    ),
                  ),
                  10.wSpace,
                  AutoSizeText(
                    '11:00:00:00'.toLocalizedTime(context),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyleApp.semiBold16().copyWith(
                      color: context.onPrimaryColor,
                    ),
                  ),
                ],
              ),
              _customDivider(context),
              Row(
                children: [
                  CustomCachedNetworkImage(
                    imgUrl: doctorResults(context).profilePicture ??
                        AppImages.avatarOnlinePatient,
                    height: context.H * 0.13,
                    width: context.H * 0.13,
                    errorIconSize: 60.sp,
                    loadingImgPadding: 60.w,
                  ).cornerRadiusWithClipRRect(8.r),
                  20.wSpace,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    spacing: 3.h,
                    children: [
                      SizedBox(
                        width: context.W * .5,
                        child: AutoSizeText(
                          '${doctorResults(context).firstName}'
                                  ' ${doctorResults(context).lastName}'
                              .capitalizeFirstChar,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyleApp.extraBold24().copyWith(
                            color: context.onPrimaryColor,
                          ),
                        ),
                      ),
                      RateingDoctorWidget(
                        isToAppointmentScreen: true,
                        doctorResults: doctorResults(context),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            width: context.W * .25,
                            child: AutoSizeText(
                              doctorResults(context).specialization ?? '',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyleApp.semiBold16().copyWith(
                                color: context.onSecondaryColor,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: context.W * .24,
                            child: AutoSizeText(
                              '${doctorResults(context).consultationPrice} '
                              '${context.translate(LangKeys.egp)}',
                              maxLines: 1,
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyleApp.bold18().copyWith(
                                color: context.onPrimaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              _customDivider(context),
              Row(
                children: [
                  const CustomButton(
                    title: LangKeys.paymentBook,
                  ).expand(),
                  15.wSpace,
                  Container(
                    padding: context.padding(horizontal: 8, vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(
                        color: context.isDark
                            ? Colors.grey.shade600
                            : Colors.grey.shade100,
                      ),
                      color: context.isDark ? Colors.black : Colors.white,
                    ),
                    child: Icon(
                      CupertinoIcons.trash,
                      size: 28.sp,
                      color: Colors.redAccent,
                    ),
                  ),
                ],
              ),
            ],
          ).paddingSymmetric(horizontal: 15, vertical: 10),
        ),
      ],
    ).paddingSymmetric(horizontal: 15);
  }

  DoctorInfoModel doctorResults(BuildContext context) {
    return DoctorInfoModel(
      id: 1,
      firstName: context.isStateArabic ? 'أحمد' : 'John',
      lastName: context.isStateArabic ? 'محمد' : 'Smith',
      specialization: context.isStateArabic ? 'طبيب' : 'Dentist',
      consultationPrice: '1000',
      profilePicture:
          'https://images.unsplash.com/photo-1499714608240-22fc6ad53fb2?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80',
      reviews: [
        DoctorReviews(
          id: 1,
          rating: 5,
        ),
      ],
    );
  }

  Divider _customDivider(BuildContext context) {
    return Divider(
      height: 32.h,
      thickness: .2,
      color: context.onSecondaryColor.withAlpha(120),
    );
  }
}

class MyAppointmentCardLoadingList extends StatelessWidget {
  const MyAppointmentCardLoadingList({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      effect: shimmerEffect(context),
      child: ListView.builder(
        itemCount: 5,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (_, index) => const MyAppointmentPatientCardLoading(),
      ),
    );
  }
}
