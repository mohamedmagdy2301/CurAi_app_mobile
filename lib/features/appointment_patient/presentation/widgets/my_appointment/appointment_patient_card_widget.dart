import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/dependency_injection/service_locator.dart'
    as di;
import 'package:curai_app_mobile/core/extensions/int_extensions.dart';
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/navigation_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/string_extensions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/core/styles/images/app_images.dart';
import 'package:curai_app_mobile/core/utils/helper/to_arabic_number.dart';
import 'package:curai_app_mobile/core/utils/models/doctor_model/doctor_info_model.dart';
import 'package:curai_app_mobile/core/utils/widgets/adaptive_dialogs/adaptive_dialogs.dart';
import 'package:curai_app_mobile/core/utils/widgets/custom_cached_network_image.dart';
import 'package:curai_app_mobile/core/utils/widgets/custom_loading_widget.dart';
import 'package:curai_app_mobile/core/utils/widgets/sankbar/snackbar_helper.dart';
import 'package:curai_app_mobile/features/appointment_patient/data/models/my_appointment_patient/my_appointment_patient_model.dart';
import 'package:curai_app_mobile/features/appointment_patient/presentation/cubit/appointment_patient_cubit/appointment_patient_cubit.dart';
import 'package:curai_app_mobile/features/appointment_patient/presentation/cubit/appointment_patient_cubit/appointment_patient_state.dart';
import 'package:curai_app_mobile/features/home/presentation/screens/details_doctor_screen.dart';
import 'package:curai_app_mobile/features/home/presentation/widgets/doctor_speciality/specialization_widget.dart';
import 'package:curai_app_mobile/features/home/presentation/widgets/popular_doctor/rateing_doctor_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toastification/toastification.dart';

class AppointmentPatientCardWidget extends StatelessWidget {
  const AppointmentPatientCardWidget({
    required this.appointment,
    required this.doctorResults,
    required this.topTrailingWidget,
    required this.bottomButton,
    super.key,
  });
  final ResultsMyAppointmentPatient appointment;
  final DoctorInfoModel doctorResults;
  final Widget topTrailingWidget;
  final Widget bottomButton;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.push(
        BlocProvider<AppointmentPatientCubit>(
          create: (context) => di.sl<AppointmentPatientCubit>(),
          child: DoctorDetailsScreen(doctorResults: doctorResults),
        ),
      ),
      child: Card(
        color: context.isDark ? Colors.black : Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
        margin: context.padding(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            Row(
              children: [
                AutoSizeText(
                  appointment.appointmentDate?.toReadableDate(context) ?? '',
                  style: TextStyleApp.semiBold18()
                      .copyWith(color: context.onPrimaryColor),
                ),
                10.wSpace,
                AutoSizeText(
                  appointment.appointmentTime!.toLocalizedTime(context),
                  style: TextStyleApp.semiBold16()
                      .copyWith(color: context.onPrimaryColor),
                ),
                const Spacer(),
                topTrailingWidget,
              ],
            ),
            _customDivider(context),
            Row(
              children: [
                CustomCachedNetworkImage(
                  imgUrl: doctorResults.profilePicture ??
                      AppImages.avatarOnlineDoctor,
                  height: context.H * 0.13,
                  width: context.H * 0.13,
                  errorIconSize: 60.sp,
                  loadingImgPadding: 60.w,
                ).cornerRadiusWithClipRRect(8.r),
                20.wSpace,
                _doctorInfo(context),
              ],
            ),
            _customDivider(context),
            Row(
              children: [
                bottomButton.expand(),
                15.wSpace,
                DeleteAppointmentButton(appointment: appointment),
              ],
            ),
          ],
        ).paddingSymmetric(horizontal: 16, vertical: 16),
      ),
    );
  }

  Widget _doctorInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 3.h,
      children: [
        AutoSizeText(
          '${context.translate(LangKeys.dr)}/ '
                  '${doctorResults.firstName} ${doctorResults.lastName}'
              .capitalizeFirstChar,
          maxLines: 1,
          style:
              TextStyleApp.medium22().copyWith(color: context.onPrimaryColor),
        ).withWidth(context.W * .45),
        AutoSizeText(
          '${context.translate(LangKeys.specialty)}: '
          '${specializationName(
            doctorResults.specialization,
            isArabic: context.isStateArabic,
          )}',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyleApp.medium14().copyWith(
            color: context.onPrimaryColor.withAlpha(140),
          ),
        ).withWidth(context.W * .45),
        AutoSizeText(
          '${context.translate(LangKeys.consultationPrice)}: '
          '${context.isStateArabic ? toArabicNumber(doctorResults.consultationPrice!.split('.')[0]) : doctorResults.consultationPrice!.split('.')[0]} '
          '${context.translate(LangKeys.egp)}',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyleApp.medium14().copyWith(
            color: context.onPrimaryColor.withAlpha(140),
          ),
        ).withWidth(context.W * .45),
        RateingDoctorWidget(
          isToAppointmentScreen: true,
          doctorResults: doctorResults,
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

class DeleteAppointmentButton extends StatelessWidget {
  const DeleteAppointmentButton({
    required this.appointment,
    super.key,
  });

  final ResultsMyAppointmentPatient appointment;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppointmentPatientCubit, AppointmentPatientState>(
      buildWhen: (previous, current) =>
          current is DeleteAppointmentPatientFailure ||
          current is DeleteAppointmentPatientSuccess ||
          current is DeleteAppointmentPatientLoading,
      listenWhen: (previous, current) =>
          current is DeleteAppointmentPatientFailure ||
          current is DeleteAppointmentPatientSuccess ||
          current is DeleteAppointmentPatientLoading,
      listener: (context, state) async {
        if (state is DeleteAppointmentPatientFailure) {
          showMessage(
            context,
            message: state.message,
            type: ToastificationType.error,
          );
        }
        if (state is DeleteAppointmentPatientSuccess) {
          await context
              .read<AppointmentPatientCubit>()
              .refreshMyAppointmentPatient();
        }
      },
      builder: (context, state) {
        return InkWell(
          onTap: () {
            AdaptiveDialogs.showOkCancelAlertDialog<bool>(
              context: context,
              title: context.translate(LangKeys.cancelAppointment),
              message: context.translate(LangKeys.cancelAppointmentMessage),
              onPressedOk: () async {
                context.pop();

                await context
                    .read<AppointmentPatientCubit>()
                    .deleteAppointmentPatient(
                      appointmentId: appointment.id!,
                    );
              },
              onPressedCancel: () => context.pop(),
            );
          },
          child: state is DeleteAppointmentPatientLoading
              ? const CustomLoadingWidget()
              : Container(
                  padding: context.padding(horizontal: 8, vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(color: Colors.redAccent),
                    color: context.isDark ? Colors.black : Colors.white,
                  ),
                  child: Icon(
                    CupertinoIcons.trash,
                    size: 26.sp,
                    color: Colors.redAccent,
                  ),
                ),
        );
      },
    );
  }
}
