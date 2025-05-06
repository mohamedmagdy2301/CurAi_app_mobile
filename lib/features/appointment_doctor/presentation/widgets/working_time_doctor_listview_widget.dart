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
  bool _isDialogVisible = false;

  @override
  void initState() {
    super.initState();
    _workingTimeList = widget.workingTimeList;
  }

  @override
  void didUpdateWidget(
    covariant WorkingTimeDoctorAvailabilityListView oldWidget,
  ) {
    super.didUpdateWidget(oldWidget);
    if (widget.workingTimeList != oldWidget.workingTimeList) {
      _workingTimeList = widget.workingTimeList;
    }
  }

  Future<void> _showUpdateBottomSheet({
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

    if (!mounted || result == null) return;

    final newFrom = result['available_from'];
    final newTo = result['available_to'];

    if (newFrom == from && newTo == to) return;

    final confirm = await AdaptiveDialogs.showOkCancelAlertDialog<bool>(
      context: context,
      title: context.translate(LangKeys.updateWorkingTime),
      message: context.translate(LangKeys.updateWorkingTimeMessage),
      onPressedOk: () => Navigator.of(context).pop(true),
      onPressedCancel: () => Navigator.of(context).pop(false),
    );

    if (confirm == true && mounted) {
      _showLoadingDialog(
        context,
        context.translate(LangKeys.updateWorkingTime),
      );
      await context.read<AppointmentDoctorCubit>().updateWorkingTimeDoctor(
            workingTimeId: workingTimeId,
            startTime: newFrom as String,
            endTime: newTo as String,
          );
    }
  }

  void _showLoadingDialog(BuildContext context, String title) {
    if (!_isDialogVisible && context.mounted) {
      _isDialogVisible = true;
      AdaptiveDialogs.showLoadingAlertDialog(
        context: context,
        title: title,
      );
    }
  }

  void _safePopDialog() {
    if (_isDialogVisible && mounted) {
      Navigator.of(context).pop();
      _isDialogVisible = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final grouped = groupBy(_workingTimeList, (e) => e.id).entries.toList();

    return BlocConsumer<AppointmentDoctorCubit, AppointmentDoctorState>(
      listenWhen: (prev, curr) =>
          curr is UpdateWorkingTimeDoctorSuccess ||
          curr is UpdateWorkingTimeDoctorFailure ||
          curr is RemoveWorkingTimeDoctorSuccess ||
          curr is RemoveWorkingTimeDoctorFailure,
      listener: (context, state) {
        _safePopDialog();

        if (state is UpdateWorkingTimeDoctorSuccess) {
          showMessage(
            context,
            type: SnackBarType.success,
            message: context.translate(LangKeys.updateWorkingTimeSuccess),
          );
          context
              .read<AppointmentDoctorCubit>()
              .getWorkingTimeAvailableDoctor();
        } else if (state is UpdateWorkingTimeDoctorFailure) {
          showMessage(
            context,
            type: SnackBarType.error,
            message:
                '${context.translate(LangKeys.updateWorkingTimeFailed)}\n${state.message}',
          );
        } else if (state is RemoveWorkingTimeDoctorSuccess) {
          showMessage(
            context,
            type: SnackBarType.success,
            message: context.translate(LangKeys.deleteWorkingTimeSuccess),
          );
          context
              .read<AppointmentDoctorCubit>()
              .getWorkingTimeAvailableDoctor();
        } else if (state is RemoveWorkingTimeDoctorFailure) {
          showMessage(
            context,
            type: SnackBarType.error,
            message:
                '${context.translate(LangKeys.deleteWorkingTimeFailed)}\n${state.message}',
          );
        }
      },
      builder: (context, state) {
        return ListView.builder(
          itemCount: grouped.length,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemBuilder: (context, index) {
            final item = grouped[index];
            final id = item.key;
            final items = item.value;

            return Dismissible(
              key: ValueKey(id),
              background: _buildSwipeBackground(
                context,
                icon: CupertinoIcons.pencil,
                text: context.translate(LangKeys.swipeToUpdate),
                alignment: Alignment.centerLeft,
                color: Colors.blue,
              ),
              secondaryBackground: _buildSwipeBackground(
                context,
                icon: CupertinoIcons.trash,
                text: context.translate(LangKeys.swipeToDelete),
                alignment: Alignment.centerRight,
                color: Colors.red,
              ),
              confirmDismiss: (direction) async {
                if (direction == DismissDirection.startToEnd) {
                  await _showUpdateBottomSheet(
                    workingTimeId: id!,
                    from: items.first.availableFrom!,
                    to: items.first.availableTo!,
                  );
                  return false;
                } else if (direction == DismissDirection.endToStart) {
                  final confirm =
                      await AdaptiveDialogs.showOkCancelAlertDialog<bool>(
                    context: context,
                    title: context.translate(LangKeys.deleteWorkingTime),
                    message:
                        context.translate(LangKeys.deleteWorkingTimeMessage),
                    onPressedOk: () => Navigator.of(context).pop(true),
                    onPressedCancel: () => Navigator.of(context).pop(false),
                  );
                  if (confirm == true && mounted) {
                    _showLoadingDialog(
                      context,
                      context.translate(LangKeys.deleteWorkingTime),
                    );
                    context
                        .read<AppointmentDoctorCubit>()
                        .removeWorkingTimeDoctor(
                          workingTimeId: id!,
                        );
                  }
                  return false;
                }
                return false;
              },
              child: WorkingTimeDoctorCardWidget(items: items),
            );
          },
        );
      },
    );
  }

  Widget _buildSwipeBackground(
    BuildContext context, {
    required IconData icon,
    required String text,
    required Alignment alignment,
    required Color color,
  }) {
    return Card(
      margin: context.padding(vertical: 10),
      elevation: 3,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
      color: color,
      child: Align(
        alignment: alignment,
        child: Row(
          mainAxisAlignment: alignment == Alignment.centerLeft
              ? MainAxisAlignment.start
              : MainAxisAlignment.end,
          children: [
            if (alignment == Alignment.centerLeft)
              Icon(icon, color: Colors.white, size: 30.sp)
                  .paddingSymmetric(horizontal: 14),
            Text(
              text,
              style: TextStyleApp.regular18().copyWith(color: Colors.white),
            ),
            if (alignment == Alignment.centerRight)
              Icon(icon, color: Colors.white, size: 30.sp)
                  .paddingSymmetric(horizontal: 14),
          ],
        ),
      ),
    );
  }
}
