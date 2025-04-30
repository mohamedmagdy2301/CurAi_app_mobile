import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/extensions/int_extensions.dart'
    as int_ext;
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/navigation_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/string_extensions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/core/utils/widgets/adaptive_dialogs/adaptive_dialogs.dart';
import 'package:curai_app_mobile/core/utils/widgets/custom_cached_network_image.dart';
import 'package:curai_app_mobile/core/utils/widgets/sankbar/snackbar_helper.dart';
import 'package:curai_app_mobile/features/appointment_patient/data/models/my_appointment_patient/my_appointment_patient_model.dart';
import 'package:curai_app_mobile/features/appointment_patient/presentation/cubit/appointment_patient_cubit/appointment_patient_cubit.dart';
import 'package:curai_app_mobile/features/appointment_patient/presentation/cubit/appointment_patient_cubit/appointment_patient_state.dart';
import 'package:curai_app_mobile/features/home/data/models/doctor_model/doctor_model.dart';
import 'package:curai_app_mobile/features/home/presentation/widgets/popular_doctor/rateing_doctor_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppointmentPatientCardWidget extends StatelessWidget {
  const AppointmentPatientCardWidget({
    required this.appointment,
    required this.doctorResults,
    required this.topTrailingWidget,
    required this.bottomButton,
    super.key,
  });
  final ResultsMyAppointmentPatient appointment;
  final DoctorResults doctorResults;
  final Widget topTrailingWidget;
  final Widget bottomButton;

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
                '${appointment.id}---${appointment.appointmentDate!.toReadableDate(context)}',
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
                imgUrl: doctorResults.profilePicture ?? '',
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
        Row(
          children: [
            AutoSizeText(
              doctorResults.specialization ?? '',
              style: TextStyleApp.semiBold16()
                  .copyWith(color: context.onSecondaryColor),
            ).withWidth(context.W * .25),
            AutoSizeText(
              '${doctorResults.consultationPrice} '
              '${context.translate(LangKeys.egp)}',
              style: TextStyleApp.medium16()
                  .copyWith(color: context.onSecondaryColor),
            ).withWidth(context.W * .23),
          ],
        ),
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
      listener: (context, state) {
        if (state is DeleteAppointmentPatientFailure) {
          Navigator.pop(context);
          showMessage(
            context,
            message: state.message,
            type: SnackBarType.error,
          );
        } else if (state is DeleteAppointmentPatientSuccess) {
          Navigator.pop(context);
          showMessage(
            context,
            message: context.isStateArabic
                ? 'تم الغاء الموعد بنجاح'
                : 'Appointment canceled successfully',
            type: SnackBarType.success,
          );
          context.read<AppointmentPatientCubit>().refreshMyAppointmentPatient();
        } else if (state is DeleteAppointmentPatientLoading) {
          AdaptiveDialogs.showLoadingAlertDialog(
            context: context,
            title: context.translate(LangKeys.cancelAppointment),
          );
        }
      },
      builder: (context, state) {
        return InkWell(
          onTap: () {
            AdaptiveDialogs.showOkCancelAlertDialog(
              context: context,
              title: context.translate(LangKeys.cancelAppointment),
              message: context.translate(LangKeys.cancelAppointmentMessage),
              onPressedOk: () {
                context.pop();

                context
                    .read<AppointmentPatientCubit>()
                    .deleteAppointmentPatient(
                      appointmentId: appointment.id!,
                    );
              },
              onPressedCancel: () => context.pop(),
            );
          },
          child: Container(
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
