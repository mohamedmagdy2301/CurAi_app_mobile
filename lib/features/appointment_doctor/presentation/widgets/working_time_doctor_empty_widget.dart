// ignore_for_file: use_build_context_synchronously

import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/extensions/int_extensions.dart';
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/core/utils/widgets/adaptive_dialogs/adaptive_dialogs.dart';
import 'package:curai_app_mobile/core/utils/widgets/custom_loading_widget.dart';
import 'package:curai_app_mobile/core/utils/widgets/sankbar/snackbar_helper.dart';
import 'package:curai_app_mobile/features/appointment_doctor/presentation/cubit/appointment_doctor_cubit.dart';
import 'package:curai_app_mobile/features/appointment_doctor/presentation/widgets/add_working_time_doctor_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toastification/toastification.dart';

class WorkingTimeDoctorEmptyWidget extends StatefulWidget {
  const WorkingTimeDoctorEmptyWidget({super.key});

  @override
  State<WorkingTimeDoctorEmptyWidget> createState() =>
      _WorkingTimeDoctorEmptyWidgetState();
}

class _WorkingTimeDoctorEmptyWidgetState
    extends State<WorkingTimeDoctorEmptyWidget> {
  Future<void> showAvailabilityBottomSheet(BuildContext context) async {
    final result = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => const AddWorkingTimeDoctorBottomSheet(),
    );

    if (result != null && mounted) {
      final shouldDelete = await AdaptiveDialogs.showOkCancelAlertDialog<bool>(
        context: context,
        title: context.translate(LangKeys.addWorkingTime),
        message: context.translate(LangKeys.addWorkingTimeMessage),
        onPressedOk: () => Navigator.of(context).pop(true),
        onPressedCancel: () => Navigator.of(context).pop(false),
      );

      if (shouldDelete!) {
        if (mounted) {
          await context.read<AppointmentDoctorCubit>().addWorkingTimeDoctor(
                day: result['days_of_week'] as String,
                startTime: result['available_from'] as String,
                endTime: result['available_to'] as String,
              );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppointmentDoctorCubit, AppointmentDoctorState>(
      listenWhen: (previous, current) =>
          current is AddWorkingTimeDoctorFailure ||
          current is AddWorkingTimeDoctorSuccess ||
          current is AddWorkingTimeDoctorLoading,
      builder: (context, state) {
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                CupertinoIcons.calendar_badge_plus,
                size: 180.sp,
                color: context.onSecondaryColor.withAlpha(80),
              ),
              28.hSpace,
              AutoSizeText(
                context.isStateArabic
                    ? 'لا يوجد مواعيد حالياً بدء مواعيدك الان'
                    : 'No working time yet, Start your working time now',
                maxLines: 3,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyleApp.bold26().copyWith(
                  color: context.onSecondaryColor.withAlpha(90),
                ),
              ).paddingSymmetric(horizontal: 20),
              46.hSpace,
              if (state is AddWorkingTimeDoctorLoading)
                const CustomLoadingWidget(height: 50, width: 50)
                    .paddingSymmetric(horizontal: 15)
              else
                IconButton(
                  onPressed: () => showAvailabilityBottomSheet(context),
                  icon: Icon(
                    CupertinoIcons.add_circled,
                    color: context.primaryColor.withAlpha(90),
                    size: 90.sp,
                  ),
                ),
            ],
          ),
        );
      },
      listener: (context, state) async {
        if (state is AddWorkingTimeDoctorSuccess) {
          if (mounted) {
            await context
                .read<AppointmentDoctorCubit>()
                .getWorkingTimeAvailableDoctor();
            if (mounted) {
              showMessage(
                context,
                type: ToastificationType.success,
                message: context.translate(LangKeys.addWorkingTimeSuccess),
              );
            }
          }
        }

        if (state is AddWorkingTimeDoctorFailure) {
          if (mounted) {
            showMessage(
              context,
              type: ToastificationType.error,
              message: '${context.translate(LangKeys.addWorkingTimeFailed)}'
                  '\n'
                  '${state.message}',
            );
          }
        }
      },
    );
  }
}
