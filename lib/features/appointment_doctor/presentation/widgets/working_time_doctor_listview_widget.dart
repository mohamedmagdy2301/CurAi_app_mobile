// ignore_for_file: lines_longer_than_80_chars

import 'package:collection/collection.dart';
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/features/appointment_doctor/data/models/working_time_doctor_available/working_time_doctor_available_model.dart';
import 'package:curai_app_mobile/features/appointment_doctor/presentation/cubit/appointment_doctor_cubit.dart';
import 'package:curai_app_mobile/features/appointment_doctor/presentation/widgets/working_time_doctor_card_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WorkingTimeDoctorAvailabilityListView extends StatelessWidget {
  const WorkingTimeDoctorAvailabilityListView({
    required this.workingTimeList,
    super.key,
  });
  final List<WorkingTimeDoctorAvailableModel> workingTimeList;

  @override
  Widget build(BuildContext context) {
    final groupedData = groupBy(
      workingTimeList,
      (item) => item.id,
    );
    final groupedItemsList = groupedData.entries.toList();
    return ListView.builder(
      itemCount: workingTimeList.length,
      itemBuilder: (context, index) {
        if (index < groupedItemsList.length) {
          final groupedItem = groupedItemsList[index];
          final items = groupedItem.value;
          return Dismissible(
            key: ValueKey(groupedItem.key),
            direction: DismissDirection.endToStart,
            background: Card(
              margin: context.padding(horizontal: 8, vertical: 10),
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
                          : 'Swipe to delete ${groupedItem.key}',
                      style: TextStyleApp.regular18().copyWith(
                        color: Colors.white,
                      ),
                    ),
                    Icon(
                      CupertinoIcons.trash,
                      color: Colors.white,
                      size: 30.sp,
                    ).paddingSymmetric(horizontal: 10),
                  ],
                ),
              ),
            ),
            onDismissed: (direction) {
              if (direction == DismissDirection.endToStart) {
                final id = groupedItem.key;
                if (id != null) {
                  context
                      .read<AppointmentDoctorCubit>()
                      .removeWorkingTimeDoctor(
                        workingTimeId: id,
                      );
                }
              }
            },
            child: WorkingTimeDoctorCardWidget(items: items),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    ).paddingSymmetric(horizontal: 10);
  }
}
