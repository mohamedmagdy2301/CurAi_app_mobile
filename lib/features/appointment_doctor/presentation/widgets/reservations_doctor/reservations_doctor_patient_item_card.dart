import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/extensions/int_extensions.dart';
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/navigation_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/string_extensions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/routes/routes.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/core/styles/images/app_images.dart';
import 'package:curai_app_mobile/core/utils/widgets/custom_button.dart';
import 'package:curai_app_mobile/core/utils/widgets/custom_cached_network_image.dart';
import 'package:curai_app_mobile/core/utils/widgets/custom_divider.dart';
import 'package:curai_app_mobile/core/utils/widgets/image_viewer_full_screen.dart';
import 'package:curai_app_mobile/features/appointment_doctor/data/models/reservations_doctor_model.dart';
import 'package:curai_app_mobile/features/patient_history/presentation/widgets/bottom_sheet_add_history_patient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReservationsDoctorItemPatientCard extends StatelessWidget {
  const ReservationsDoctorItemPatientCard({
    required this.appointment,
    required this.isExpanded,
    super.key,
  });
  final ReservationsDoctorModel appointment;
  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: context.padding(vertical: 8, horizontal: 14),
      elevation: 0,
      color: context.isDark
          ? Colors.black
          : const Color.fromARGB(255, 254, 251, 251),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
      child: Column(
        children: [
          Row(
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(10.r),
                onTap: () {
                  showImageViewerFullScreen(
                    context,
                    imageUrl: appointment.patientPicture ??
                        AppImages.avatarOnlineDoctor,
                  );
                },
                child: CustomCachedNetworkImage(
                  imgUrl: appointment.patientPicture ??
                      AppImages.avatarOnlineDoctor,
                  width: context.H * 0.1,
                  height: context.H * 0.1,
                  loadingImgPadding: 40.sp,
                  errorIconSize: 60.sp,
                ).cornerRadiusWithClipRRect(10.r),
              ),
              16.wSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      appointment.patient,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyleApp.medium22().copyWith(
                        color: context.onPrimaryColor,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time_rounded,
                          color: context.onSecondaryColor,
                          size: 18.sp,
                        ),
                        4.wSpace,
                        AutoSizeText(
                          appointment.appointmentTime.toLocalizedTime(context),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.start,
                          style: TextStyleApp.medium16().copyWith(
                            color: context.onSecondaryColor,
                          ),
                        ),
                        const Spacer(),
                        _buildPaymentStatusChip(
                          context,
                          appointment.paymentStatus,
                        ),
                      ],
                    ),
                    8.hSpace,
                  ],
                ),
              ),
            ],
          ),
          16.hSpace,
          const CustomDivider(),
          16.hSpace,
          Row(
            children: [
              CustomButton(
                title: LangKeys.viewHistory,
                isHalf: true,
                colorBackground: context.isDark
                    ? Colors.black
                    : const Color.fromARGB(255, 254, 251, 251),
                colorBorder: context.primaryColor,
                colorText: context.primaryColor,
                onPressed: () {
                  context.pushNamed(
                    Routes.patientHistoryScreen,
                    arguments: {
                      'patientId': appointment.patientId,
                    },
                  );
                },
              ).expand(),
              16.wSpace,
              CustomButton(
                title: LangKeys.addHistory,
                isHalf: true,
                colorBackground: context.primaryColor.withAlpha(140),
                onPressed: () {
                  showModalBottomSheet<void>(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) {
                      return BottomSheetAddHistoryPatient(
                        patientId: appointment.patientId,
                      );
                    },
                  );
                },
              ).expand(),
            ],
          ),
        ],
      ).paddingSymmetric(horizontal: 16, vertical: 16),
    );
  }

  Widget _buildPaymentStatusChip(BuildContext context, String paymentStatus) {
    final isPaid = paymentStatus == 'paid';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isPaid
              ? [Colors.green.shade600, Colors.green.shade400]
              : [Colors.orange.shade600, Colors.orange.shade400],
        ),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: isPaid
                ? Colors.green.withAlpha(50)
                : Colors.orange.withAlpha(50),
            blurRadius: 8,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: AutoSizeText(
        isPaid
            ? context.translate(LangKeys.paided)
            : context.translate(LangKeys.unpaid),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
        style: TextStyleApp.semiBold12().copyWith(color: Colors.white),
      ),
    );
  }
}
