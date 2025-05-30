// ignore_for_file: parameter_assignments, use_build_context_synchronously

import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/extensions/int_extensions.dart';
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/features/search/presentation/cubit/search_doctor_cubit/search_doctor_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Bottom sheet for sorting
void customBottomSheetSortingDoctors(BuildContext context) {
  final cubit = context.read<SearchDoctorCubit>();

  // Use StatefulBuilder to rebuild bottom sheet UI when state changes
  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(30),
      ),
    ),
    backgroundColor: context.backgroundColor,
    builder: (_) => StatefulBuilder(
      builder: (context, setModalState) => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            10.hSpace,
            Row(
              children: [
                5.wSpace,
                Icon(
                  CupertinoIcons.line_horizontal_3_decrease,
                  color: context.primaryColor,
                  size: 30.sp,
                ),
                20.wSpace,
                AutoSizeText(
                  context.isStateArabic
                      ? 'اختيار ترتيب الأطباء'
                      : 'Sort Doctors',
                  style: TextStyleApp.medium24().copyWith(
                    color: context.primaryColor,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
            16.hSpace,
            Divider(
              color: context.onSecondaryColor.withAlpha(120),
              thickness: .5,
            ),
            8.hSpace,
            ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                buildSortItem(
                  context,
                  cubit,
                  SortType.none,
                  CupertinoIcons.clear,
                  context.isStateArabic ? 'بدون ترتيب' : 'No Sorting',
                ),
                buildSortItem(
                  context,
                  cubit,
                  SortType.firstName,
                  CupertinoIcons.person,
                  context.isStateArabic ? 'الاسم الاول' : 'Name A-Z',
                ),
                buildSortItem(
                  context,
                  cubit,
                  SortType.speciality,
                  Icons.medical_services,
                  context.isStateArabic ? 'التخصص الطبي' : 'Medical Speciality',
                ),
                buildSortItem(
                  context,
                  cubit,
                  SortType.maxPrice,
                  CupertinoIcons.arrow_up,
                  context.isStateArabic ? 'السعر الاقصى' : 'Max Price',
                ),
                buildSortItem(
                  context,
                  cubit,
                  SortType.lowPrice,
                  CupertinoIcons.arrow_down,
                  context.isStateArabic ? 'السعر الادنى' : 'Min Price',
                ),
                buildSortItem(
                  context,
                  cubit,
                  SortType.maxRating,
                  CupertinoIcons.star_fill,
                  context.isStateArabic ? 'التقييم الاقصى' : 'Max Rating',
                ),
                buildSortItem(
                  context,
                  cubit,
                  SortType.lowRating,
                  CupertinoIcons.star,
                  context.isStateArabic ? 'التقييم الادنى' : 'Min Rating',
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

// Helper method to build sort item
GestureDetector buildSortItem(
  BuildContext context,
  SearchDoctorCubit cubit,
  SortType type,
  IconData icon,
  String label,
) {
  return GestureDetector(
    onTap: () {
      // Close modal then apply sort
      Navigator.pop(context);
      cubit.sortDoctorsList(type);
    },
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: cubit.currentSortType == type
            ? context.primaryColor.withAlpha(20)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: cubit.currentSortType == type
              ? context.primaryColor
              : context.onPrimaryColor,
        ),
        trailing: cubit.currentSortType == type
            ? Icon(
                CupertinoIcons.checkmark_alt,
                color: context.primaryColor,
              )
            : null,
        title: AutoSizeText(
          label.trim(),
          style: TextStyleApp.medium16().copyWith(
            color: cubit.currentSortType == type
                ? context.primaryColor
                : context.onPrimaryColor,
          ),
        ),
        selected: cubit.currentSortType == type,
      ),
    ),
  );
}
