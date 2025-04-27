// ignore_for_file: flutter_style_todos

import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/extensions/int_extensions.dart'
    as int_ext;
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/string_extensions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/core/utils/widgets/custom_button.dart';
import 'package:curai_app_mobile/core/utils/widgets/custom_cached_network_image.dart';
import 'package:curai_app_mobile/core/utils/widgets/sankbar/snackbar_helper.dart';
import 'package:curai_app_mobile/features/appointment/data/models/my_appointment/my_appointment_patient_model.dart';
import 'package:curai_app_mobile/features/appointment/presentation/cubit/appointment_patient_cubit/appointment_patient_cubit.dart';
import 'package:curai_app_mobile/features/home/data/models/doctor_model/doctor_model.dart';
import 'package:curai_app_mobile/features/home/presentation/widgets/popular_doctor/rateing_doctor_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaidedCardItemWidget extends StatefulWidget {
  const PaidedCardItemWidget({
    required this.paidAppointment,
    super.key,
  });
  final ResultsMyAppointmentPatient paidAppointment;

  @override
  State<PaidedCardItemWidget> createState() => _PaidedCardItemWidgetState();
}

class _PaidedCardItemWidgetState extends State<PaidedCardItemWidget> {
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    final doctorResults =
        context.select<AppointmentPatientCubit, DoctorResults?>(
      (cubit) => cubit.doctorsData[widget.paidAppointment.doctorId],
    );

    if (doctorResults == null) {
      return const SizedBox();
    }
    return Card(
      color: context.isDark ? Colors.black : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.r),
      ),
      margin: context.padding(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          Row(
            children: [
              AutoSizeText(
                widget.paidAppointment.appointmentDate!.toReadableDate(context),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyleApp.semiBold18().copyWith(
                  color: context.onPrimaryColor,
                ),
              ),
              10.wSpace,
              AutoSizeText(
                widget.paidAppointment.appointmentTime!
                    .toLocalizedTime(context),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyleApp.semiBold16().copyWith(
                  color: context.onPrimaryColor,
                ),
              ),
              const Spacer(),
              Switch.adaptive(
                value: isSwitched,
                onChanged: (_) {
                  setState(() => isSwitched = !isSwitched);
                  if (isSwitched) {
                    showMessage(
                      context,
                      type: SnackBarType.success,
                      message: context.isStateArabic
                          ? 'تم تفعيل الاشعار للموعد بنجاح 🔔'
                          : 'You have successfully enabled '
                              'notifications for the appointment 🔔',
                    );
                  }
                  if (!isSwitched) {
                    showMessage(
                      context,
                      type: SnackBarType.success,
                      message: context.isStateArabic
                          ? 'تم تعطيل الاشعار للموعد بنجاح 🔕'
                          : 'You have successfully disabled '
                              'notifications for the appointment 🔕',
                    );
                  }
                },
              ),
            ],
          ),
          _customDivider(context),
          Row(
            children: [
              CustomCachedNetworkImage(
                imgUrl: doctorResults.profilePicture ?? '',
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
                              '${doctorResults.firstName}'
                              ' ${doctorResults.lastName}'
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
                          doctorResults.specialization ?? '',
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
                          '${doctorResults.consultationPrice} '
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
                    doctorResults: doctorResults,
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
                title: LangKeys.reschedule,
                onPressed: () {
                  showMessage(
                    context,
                    type: SnackBarType.success,
                    message: 'Reschedule appointment successfully',
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

  Divider _customDivider(BuildContext context) {
    return Divider(
      height: 35.h,
      thickness: .2,
      color: context.onSecondaryColor.withAlpha(120),
    );
  }
}
