// ignore_for_file: use_build_context_synchronously

import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/extensions/int_extensions.dart';
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/core/utils/widgets/adaptive_dialogs/adaptive_dialogs.dart';
import 'package:curai_app_mobile/core/utils/widgets/sankbar/snackbar_helper.dart';
import 'package:curai_app_mobile/features/appointment_doctor/presentation/cubit/appointment_doctor_cubit.dart';
import 'package:curai_app_mobile/features/appointment_doctor/presentation/widgets/add_working_time_doctor_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WorkingTimeDoctorEmptyWidget extends StatefulWidget {
  const WorkingTimeDoctorEmptyWidget({super.key});

  @override
  State<WorkingTimeDoctorEmptyWidget> createState() =>
      _WorkingTimeDoctorEmptyWidgetState();
}

class _WorkingTimeDoctorEmptyWidgetState
    extends State<WorkingTimeDoctorEmptyWidget> {
  bool isLoading = false;

  Future<void> showAvailabilityBottomSheet(BuildContext context) async {
    final result = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => const AddWorkingTimeDoctorBottomSheet(),
    );

    if (result != null && context.mounted) {
      final shouldDelete = await AdaptiveDialogs.showOkCancelAlertDialog<bool>(
        context: context,
        title: context.translate(LangKeys.addWorkingTime),
        message: context.translate(LangKeys.addWorkingTimeMessage),
        onPressedOk: () => Navigator.of(context).pop(true),
        onPressedCancel: () => Navigator.of(context).pop(false),
      );

      if (shouldDelete!) {
        if (context.mounted) {
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
      buildWhen: (previous, current) =>
          current is AddWorkingTimeDoctorFailure ||
          current is AddWorkingTimeDoctorSuccess ||
          current is AddWorkingTimeDoctorLoading,
      listener: (context, state) async {
        if (state is AddWorkingTimeDoctorSuccess) {
          await context
              .read<AppointmentDoctorCubit>()
              .getWorkingTimeAvailableDoctor();
          showMessage(
            context,
            type: SnackBarType.success,
            message: context.translate(LangKeys.addWorkingTimeSuccess),
          );
          if (isLoading) {
            Navigator.pop(context);
            setState(() {
              isLoading = false;
            });
          }
        }
        if (state is AddWorkingTimeDoctorFailure) {
          showMessage(
            context,
            type: SnackBarType.error,
            message: '${context.translate(LangKeys.addWorkingTimeFailed)}'
                '\n'
                '${state.message}',
          );
          if (isLoading) {
            Navigator.pop(context);
            setState(() {
              isLoading = false;
            });
          }
        }
        if (state is AddWorkingTimeDoctorLoading && !isLoading) {
          await AdaptiveDialogs.showLoadingAlertDialog(
            context: context,
            title: context.translate(LangKeys.addWorkingTime),
          );
          setState(() {
            isLoading = true;
          });
        }
      },
      builder: (context, state) {
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
                  color: context.onSecondaryColor.withAlpha(100),
                ),
              ).paddingSymmetric(horizontal: 20),
              56.hSpace,
              IconButton(
                onPressed: () => showAvailabilityBottomSheet(context),
                icon: Icon(
                  CupertinoIcons.add_circled,
                  color: context.primaryColor,
                  size: 90.sp,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
