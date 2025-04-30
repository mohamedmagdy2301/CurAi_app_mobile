import 'package:auto_size_text/auto_size_text.dart';
import 'package:collection/collection.dart';
import 'package:curai_app_mobile/core/extensions/int_extensions.dart' as ext;
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/string_extensions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/features/appointment_doctor/data/models/working_time_doctor_available/working_time_doctor_available_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WorkingTimeDoctorAvailabilityListView extends StatelessWidget {
  const WorkingTimeDoctorAvailabilityListView({
    required this.workingTimeList,
    super.key,
  });
  final List<WorkingTimeDoctorAvailableModel> workingTimeList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: workingTimeList.length,
      itemBuilder: (context, index) {
        final groupedData = groupBy(
          workingTimeList,
          (item) => item.id,
        );
        final groupedItemsList = groupedData.entries.toList();
        if (index < groupedItemsList.length) {
          final groupedItem = groupedItemsList[index];
          // final id = groupedItem.key;
          final items = groupedItem.value;
          return Card(
            margin: context.padding(horizontal: 8, vertical: 10),
            elevation: 3,
            clipBehavior: Clip.antiAlias,
            color: context.isDark
                ? Colors.black45
                : const Color.fromARGB(255, 232, 232, 232),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: ListTile(
              title: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        CupertinoIcons.calendar_today,
                        color: context.primaryColor.withAlpha(160),
                        size: 26.sp,
                      ),
                      8.wSpace,
                      Wrap(
                        children: [
                          if (items.length == 1)
                            AutoSizeText(
                              'يوم ',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyleApp.medium18().copyWith(
                                color: context.onPrimaryColor,
                              ),
                            ),
                          if (items.length > 1)
                            AutoSizeText(
                              'أيام ',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyleApp.medium18().copyWith(
                                color: context.onPrimaryColor,
                              ),
                            ),
                          for (int i = 0; i < items.length; i++)
                            AutoSizeText(
                              '${items[i].getLocalizedDays(isArabic: context.isStateArabic).join(', ')}${i != items.length - 1 ? ' و ' : ''}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyleApp.medium18().copyWith(
                                color: context.onPrimaryColor,
                              ),
                            ),
                        ],
                      ).expand(),
                    ],
                  ),
                  _customDivider(context),
                ],
              ),
              subtitle: Wrap(
                children: [
                  AutoSizeText(
                    context.isStateArabic
                        ? ' وقت بدء العمل من '
                        : 'Work start time from',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyleApp.regular16().copyWith(
                      color: context.onSecondaryColor,
                    ),
                  ),
                  AutoSizeText(
                    '${items.first.availableFrom?.toLocalizedTime(context)} ',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyleApp.medium16().copyWith(
                      color: context.primaryColor,
                    ),
                  ),
                  AutoSizeText(
                    context.isStateArabic ? 'حتى' : 'to',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyleApp.regular16().copyWith(
                      color: context.onSecondaryColor,
                    ),
                  ),
                  AutoSizeText(
                    ' ${items.first.availableTo?.toLocalizedTime(context)}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyleApp.medium16().copyWith(
                      color: context.primaryColor,
                    ),
                  ),
                ],
              ).expand(),
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    ).paddingSymmetric(horizontal: 10);
  }

  Divider _customDivider(BuildContext context) {
    return Divider(
      height: 28.h,
      thickness: .2,
      color: context.onSecondaryColor.withAlpha(120),
    );
  }
}
