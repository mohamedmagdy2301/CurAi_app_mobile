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
import 'package:curai_app_mobile/features/appointment_doctor/presentation/widgets/working_time_doctor_card_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
  bool isLoading = false;
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
          current is RemoveWorkingTimeDoctorLoading,
      buildWhen: (previous, current) =>
          current is RemoveWorkingTimeDoctorFailure ||
          current is RemoveWorkingTimeDoctorSuccess ||
          current is RemoveWorkingTimeDoctorLoading,
      listener: (context, state) {
        if (state is RemoveWorkingTimeDoctorSuccess) {
          context
              .read<AppointmentDoctorCubit>()
              .getWorkingTimeAvailableDoctor();
          showMessage(
            context,
            type: SnackBarType.success,
            message: context.isStateArabic
                ? 'تمت حذف المواعيد بنجاح'
                : 'Working time Removed successfully',
          );
          if (isLoading) {
            Navigator.pop(context);
            setState(() {
              isLoading = false;
            });
          }
        }
        if (state is RemoveWorkingTimeDoctorFailure) {
          showMessage(
            context,
            type: SnackBarType.error,
            message: state.message,
          );
          if (isLoading) {
            Navigator.pop(context);
            setState(() {
              isLoading = false;
            });
          }
        }
        if (state is RemoveWorkingTimeDoctorLoading && !isLoading) {
          AdaptiveDialogs.showLoadingAlertDialog(
            context: context,
            title: context.translate(LangKeys.workingTime),
          );
          setState(() {
            isLoading = true;
          });
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
                direction: DismissDirection.endToStart,
                background: Card(
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
                          context.isStateArabic
                              ? 'اسحب للحذف'
                              : 'Swipe to delete',
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
                  if (direction == DismissDirection.endToStart) {
                    final shouldDelete =
                        await AdaptiveDialogs.showOkCancelAlertDialog<bool>(
                      context: context,
                      title: context.isStateArabic
                          ? 'تأكيد الحذف'
                          : 'Confirm Deletion',
                      message: context.isStateArabic
                          ? 'هل أنت متأكد أنك تريد حذف هذا الموعد؟'
                          : 'Are you sure you want to delete this working time?',
                      onPressedOk: () => Navigator.of(context).pop(true),
                      onPressedCancel: () => Navigator.of(context).pop(false),
                    );

                    if (shouldDelete!) {
                      final id = groupedItem.key;
                      if (id != null) {
                        setState(() {
                          _workingTimeList.removeWhere((item) => item.id == id);
                        });
                        if (context.mounted) {
                          await context
                              .read<AppointmentDoctorCubit>()
                              .removeWorkingTimeDoctor(workingTimeId: id);
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
