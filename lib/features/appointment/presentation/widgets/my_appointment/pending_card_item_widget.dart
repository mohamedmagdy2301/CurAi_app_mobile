import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/extensions/int_extensions.dart'
    as int_ext;
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/navigation_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/string_extensions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/routes/routes.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/core/utils/widgets/custom_button.dart';
import 'package:curai_app_mobile/core/utils/widgets/custom_cached_network_image.dart';
import 'package:curai_app_mobile/core/utils/widgets/sankbar/snackbar_helper.dart';
import 'package:curai_app_mobile/features/appointment/data/models/my_appointment/my_appointment_patient_model.dart';
import 'package:curai_app_mobile/features/home/data/models/doctor_model/doctor_model.dart';
import 'package:curai_app_mobile/features/home/presentation/widgets/popular_doctor/rateing_doctor_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PendingCardItemWidget extends StatelessWidget {
  const PendingCardItemWidget({required this.pendingAppointment, super.key});
  final ResultsMyAppointmentPatient pendingAppointment;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: context.isDark ? Colors.black : Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
      margin: context.padding(horizontal: 20, vertical: 10),
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
                imgUrl: doctorResults(context).profilePicture ?? '',
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
                      '${context.translate(LangKeys.dr)}/ '
                              '${doctorResults(context).firstName}'
                              ' ${doctorResults(context).lastName}'
                          .capitalizeFirstChar,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyleApp.bold22().copyWith(
                        color: context.onPrimaryColor,
                      ),
                    ),
                  ),
                  2.hSpace,
                  Row(
                    children: [
                      SizedBox(
                        width: context.W * .28,
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
                        width: context.W * .23,
                        child: AutoSizeText(
                          '${doctorResults(context).consultationPrice} '
                          '${context.translate(LangKeys.egp)}',
                          maxLines: 1,
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyleApp.medium16().copyWith(
                            color: context.onSecondaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  RateingDoctorWidget(
                    isToAppointmentScreen: true,
                    doctorResults: doctorResults(context),
                  ),
                ],
              ),
            ],
          ),
          _customDivider(context),
          Row(
            children: [
              CustomButton(
                isHalf: true,
                title: LangKeys.paymentBook,
                onPressed: () {
                  context.pushNamed(
                    Routes.paymentAppointmentScreen,
                    arguments: {
                      'doctorResults': doctorResults(context),
                      'appointmentId': 1,
                    },
                  );
                },
              ).expand(),
              15.wSpace,
              CustomButton(
                isHalf: true,
                title: LangKeys.cancelAppointment,
                colorBackground: context.isDark ? Colors.black : Colors.white,
                colorBorder: Colors.redAccent,
                colorText: Colors.redAccent,
                onPressed: () {
                  showMessage(
                    context,
                    type: SnackBarType.success,
                    message: 'Cancel appointment successfully',
                  );
                },
              ).expand(),
            ],
          ),
        ],
      ).paddingSymmetric(horizontal: 16, vertical: 16),
    );
  }

  DoctorResults doctorResults(BuildContext context) {
    return DoctorResults(
      id: 1,
      firstName: context.isStateArabic ? 'أحمد' : 'John',
      lastName: context.isStateArabic ? 'محمد' : 'Smith',
      specialization: context.isStateArabic ? 'طبيب أطفال' : 'Dentist',
      consultationPrice: '1000',
      profilePicture:
          'https://images.unsplash.com/photo-1499714608240-22fc6ad53fb2?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80',
      reviews: [
        Reviews(
          id: 1,
          rating: 5,
        ),
      ],
    );
  }

  Divider _customDivider(BuildContext context) {
    return Divider(
      height: 35.h,
      thickness: .2,
      color: context.onSecondaryColor.withAlpha(120),
    );
  }
}
