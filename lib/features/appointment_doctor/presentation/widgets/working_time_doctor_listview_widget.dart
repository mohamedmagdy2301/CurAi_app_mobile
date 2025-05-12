// ignore_for_file: lines_longer_than_80_chars

import 'package:collection/collection.dart';
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/core/utils/widgets/adaptive_dialogs/adaptive_dialogs.dart';
import 'package:curai_app_mobile/core/utils/widgets/sankbar/snackbar_helper.dart';
import 'package:curai_app_mobile/features/appointment_doctor/data/models/working_time_doctor_available/working_time_doctor_available_model.dart';
import 'package:curai_app_mobile/features/appointment_doctor/presentation/cubit/appointment_doctor_cubit.dart';
import 'package:curai_app_mobile/features/appointment_doctor/presentation/widgets/update_working_time_doctor_bottom_sheet.dart';
import 'package:curai_app_mobile/features/appointment_doctor/presentation/widgets/working_time_doctor_card_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toastification/toastification.dart';

class WorkingTimeDoctorAvailabilityListView extends StatefulWidget {
  const WorkingTimeDoctorAvailabilityListView({
    required this.workingTimeList,
    super.key,
  });
  final List<WorkingTimeDoctorAvailableModel> workingTimeList;

  @override
  State<WorkingTimeDoctorAvailabilityListView> createState() =>
      _WorkingTimeDoctorAvailabilityListViewState();
}

class _WorkingTimeDoctorAvailabilityListViewState
    extends State<WorkingTimeDoctorAvailabilityListView> {
  late List<WorkingTimeDoctorAvailableModel> _workingTimeList;

  @override
  void initState() {
    super.initState();
    _workingTimeList = widget.workingTimeList;
  }

  @override
  void didUpdateWidget(WorkingTimeDoctorAvailabilityListView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.workingTimeList != oldWidget.workingTimeList) {
      _workingTimeList = widget.workingTimeList;
    }
  }

  Future<void> showAvailabilityBottomSheet({
    required BuildContext context,
    required int workingTimeId,
    required String from,
    required String to,
  }) async {
    final result = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (_) => UpdateWorkingTimeDoctorBottomSheet(
        existingData: {
          'available_from': from,
          'available_to': to,
        },
      ),
    );

    if (result != null && context.mounted) {
      if (result['available_from'] == from && result['available_to'] == to) {
        return;
      }
      final shouldDelete = await AdaptiveDialogs.showOkCancelAlertDialog<bool>(
        context: context,
        title: context.translate(LangKeys.updateWorkingTime),
        message: context.translate(LangKeys.updateWorkingTimeMessage),
        onPressedOk: () => Navigator.of(context).pop(true),
        onPressedCancel: () => Navigator.of(context).pop(false),
      );

      if (shouldDelete! && context.mounted) {
        await context.read<AppointmentDoctorCubit>().updateWorkingTimeDoctor(
              workingTimeId: workingTimeId,
              startTime: result['available_from'] as String,
              endTime: result['available_to'] as String,
            );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final groupedData = groupBy(
      _workingTimeList,
      (item) => item.id,
    );
    final groupedItemsList = groupedData.entries.toList();

    return BlocConsumer<AppointmentDoctorCubit, AppointmentDoctorState>(
      listenWhen: (previous, current) =>
          current is RemoveWorkingTimeDoctorFailure ||
          current is RemoveWorkingTimeDoctorSuccess ||
          current is RemoveWorkingTimeDoctorLoading ||
          current is UpdateWorkingTimeDoctorFailure ||
          current is UpdateWorkingTimeDoctorSuccess ||
          current is UpdateWorkingTimeDoctorLoading,
      buildWhen: (previous, current) =>
          current is RemoveWorkingTimeDoctorFailure ||
          current is RemoveWorkingTimeDoctorSuccess ||
          current is RemoveWorkingTimeDoctorLoading ||
          current is UpdateWorkingTimeDoctorFailure ||
          current is UpdateWorkingTimeDoctorSuccess ||
          current is UpdateWorkingTimeDoctorLoading,
      listener: (context, state) {
        if (state is UpdateWorkingTimeDoctorSuccess) {
          context
              .read<AppointmentDoctorCubit>()
              .getWorkingTimeAvailableDoctor();
          // showMessage(
          //   context,
          //   type: ToastificationType.success,
          //   message: context.translate(LangKeys.updateWorkingTimeSuccess),
          // );
        }
        if (state is UpdateWorkingTimeDoctorFailure) {
          showMessage(
            context,
            type: ToastificationType.error,
            message: '${context.translate(LangKeys.updateWorkingTimeFailed)}'
                '\n'
                '${state.message}',
          );
        }

        /// Delete Working Time Doctor
        if (state is RemoveWorkingTimeDoctorSuccess) {
          context
              .read<AppointmentDoctorCubit>()
              .getWorkingTimeAvailableDoctor();
          // showMessage(
          //   context,
          //   type: ToastificationType.success,
          //   message: context.translate(LangKeys.deleteWorkingTimeSuccess),
          // );
        }
        if (state is RemoveWorkingTimeDoctorFailure) {
          showMessage(
            context,
            type: ToastificationType.error,
            message: '${context.translate(LangKeys.deleteWorkingTimeFailed)}'
                '\n'
                '${state.message}',
          );
        }
      },
      builder: (context, state) {
        return ListView.builder(
          itemCount: _workingTimeList.length,
          itemBuilder: (context, index) {
            if (index < groupedItemsList.length) {
              final groupedItem = groupedItemsList[index];
              final items = groupedItem.value;
              return Dismissible(
                key: ValueKey(groupedItem.key),
                background: Card(
                  margin: context.padding(vertical: 10),
                  elevation: 3,
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  color: Colors.blue,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        Icon(
                          CupertinoIcons.pencil,
                          color: Colors.white,
                          size: 30.sp,
                        ).paddingSymmetric(horizontal: 14),
                        Text(
                          context.translate(LangKeys.swipeToUpdate),
                          style: TextStyleApp.regular18().copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                secondaryBackground: Card(
                  margin: context.padding(vertical: 10),
                  elevation: 3,
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  color: Colors.red,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          context.translate(LangKeys.swipeToDelete),
                          style: TextStyleApp.regular18().copyWith(
                            color: Colors.white,
                          ),
                        ),
                        Icon(
                          CupertinoIcons.trash,
                          color: Colors.white,
                          size: 30.sp,
                        ).paddingSymmetric(horizontal: 14),
                      ],
                    ),
                  ),
                ),
                confirmDismiss: (direction) async {
                  final itemId = groupedItem.key;

                  /// Edit working time
                  if (direction == DismissDirection.startToEnd) {
                    if (itemId != null) {
                      await showAvailabilityBottomSheet(
                        context: context,
                        workingTimeId: itemId,
                        from: items.first.availableFrom!,
                        to: items.first.availableTo!,
                      );
                    }
                    return false;
                  }

                  /// Delete working time
                  if (direction == DismissDirection.endToStart) {
                    final shouldDelete =
                        await AdaptiveDialogs.showOkCancelAlertDialog<bool>(
                      context: context,
                      title: context.translate(LangKeys.deleteWorkingTime),
                      message:
                          context.translate(LangKeys.deleteWorkingTimeMessage),
                      onPressedOk: () => Navigator.of(context).pop(true),
                      onPressedCancel: () => Navigator.of(context).pop(false),
                    );

                    if (shouldDelete!) {
                      if (itemId != null) {
                        setState(() {
                          _workingTimeList
                              .removeWhere((item) => item.id == itemId);
                        });
                        if (context.mounted) {
                          await context
                              .read<AppointmentDoctorCubit>()
                              .removeWorkingTimeDoctor(workingTimeId: itemId);
                        }
                      }
                    }
                    return false;
                  }
                  return false;
                },
                child: WorkingTimeDoctorCardWidget(items: items),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        );
      },
    ).paddingSymmetric(horizontal: 16);
  }
}
