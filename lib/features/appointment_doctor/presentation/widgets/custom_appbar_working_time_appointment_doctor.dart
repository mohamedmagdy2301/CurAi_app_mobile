// ignore_for_file: use_if_null_to_convert_nulls_to_bools, use_build_context_synchronously

import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
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

class CustomAppbarWorkingTimeAppointmentDoctor extends StatefulWidget
    implements PreferredSizeWidget {
  const CustomAppbarWorkingTimeAppointmentDoctor({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  State<CustomAppbarWorkingTimeAppointmentDoctor> createState() =>
      _CustomAppbarWorkingTimeAppointmentDoctorState();
}

class _CustomAppbarWorkingTimeAppointmentDoctorState
    extends State<CustomAppbarWorkingTimeAppointmentDoctor> {
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
      final day = result['days_of_week'];
      final start = result['available_from'];
      final end = result['available_to'];

      if (day is! String || start is! String || end is! String) return;

      final shouldDelete = await AdaptiveDialogs.showOkCancelAlertDialog<bool>(
        context: context,
        title: context.translate(LangKeys.addWorkingTime),
        message: context.translate(LangKeys.addWorkingTimeMessage),
        onPressedOk: () => Navigator.of(context).pop(true),
        onPressedCancel: () => Navigator.of(context).pop(false),
      );

      if (shouldDelete == true && context.mounted) {
        await context.read<AppointmentDoctorCubit>().addWorkingTimeDoctor(
              day: day,
              startTime: start,
              endTime: end,
            );
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
          if (isLoading && Navigator.canPop(context)) {
            Navigator.pop(context);
          }
          if (mounted) {
            setState(() => isLoading = false);
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
          if (isLoading && Navigator.canPop(context)) {
            Navigator.pop(context);
          }
          if (mounted) {
            setState(() => isLoading = false);
          }
        }

        if (state is AddWorkingTimeDoctorLoading && !isLoading) {
          await AdaptiveDialogs.showLoadingAlertDialog(
            context: context,
            title: context.translate(LangKeys.addWorkingTime),
          );
          if (mounted) {
            setState(() => isLoading = true);
          }
        }
      },
      builder: (context, state) {
        return AppBar(
          elevation: 0,
          flexibleSpace: Container(color: context.backgroundColor),
          title: AutoSizeText(
            context.translate(LangKeys.workingTime),
            maxLines: 1,
            style: TextStyleApp.medium24().copyWith(
              color: context.onPrimaryColor,
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () => showAvailabilityBottomSheet(context),
              icon: Icon(
                CupertinoIcons.add_circled_solid,
                color: context.onPrimaryColor,
                size: 30.sp,
              ),
            ),
          ],
        );
      },
    );
  }
}
