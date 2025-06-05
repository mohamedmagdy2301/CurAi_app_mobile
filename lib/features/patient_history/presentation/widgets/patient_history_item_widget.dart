// ignore_for_file: deprecated_member_use

import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/extensions/int_extensions.dart';
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/string_extensions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/features/patient_history/data/models/patient_history_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PatientHistoryItemWidget extends StatefulWidget {
  const PatientHistoryItemWidget({
    required this.history,
    this.onTap,
    super.key,
  });

  final PatientHistoryModel history;
  final VoidCallback? onTap;

  @override
  State<PatientHistoryItemWidget> createState() =>
      _PatientHistoryItemWidgetState();
}

class _PatientHistoryItemWidgetState extends State<PatientHistoryItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: context.padding(horizontal: 16, vertical: 16),
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: context.isDark
            ? Colors.black
            : const Color.fromARGB(255, 254, 251, 251),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: context.primaryColor.withAlpha(60),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          12.hSpace,
          _buildNotesSection(),
          12.hSpace,
          _buildFooter(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          width: 56.w,
          height: 56.h,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.blue.shade400,
                Colors.blue.shade600,
              ],
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.blue.withAlpha(75),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Icon(
            Icons.medical_services_rounded,
            color: Colors.white,
            size: 28.sp,
          ),
        ),
        16.wSpace,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.person_rounded,
                  size: 18.sp,
                  color: context.primaryColor,
                ),
                4.wSpace,
                AutoSizeText(
                  '${context.translate(LangKeys.dr)} ${widget.history.doctorUsername}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyleApp.bold16().copyWith(
                    color: context.onPrimaryColor,
                  ),
                ).flexible(),
              ],
            ),
            4.hSpace,
            Row(
              children: [
                Icon(
                  Icons.sick_rounded,
                  size: 14.sp,
                  color: context.onSecondaryColor,
                ),
                4.wSpace,
                AutoSizeText(
                  '${context.translate(LangKeys.patient)}: ${widget.history.patientUsername}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyleApp.medium14().copyWith(
                    color: context.onSecondaryColor,
                  ),
                ).flexible(),
              ],
            ),
          ],
        ).expand(),
        _buildIdBadge(),
      ],
    );
  }

  Widget _buildIdBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.green.shade400,
            Colors.green.shade600,
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withAlpha(75),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.tag_rounded,
            size: 14,
            color: Colors.white,
          ),
          const SizedBox(width: 4),
          Text(
            '${widget.history.id}',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotesSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: context.onPrimaryColor.withAlpha(6),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: context.onPrimaryColor.withAlpha(16),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(6.sp),
                decoration: BoxDecoration(
                  color: Colors.orange.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.note_alt_rounded,
                  size: 16.sp,
                  color: Colors.orange.shade700,
                ),
              ),
              8.wSpace,
              AutoSizeText(
                '${context.translate(LangKeys.notes)}:',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyleApp.bold14().copyWith(
                  color: context.onPrimaryColor,
                ),
              ),
            ],
          ),
          10.hSpace,
          AutoSizeText(
            widget.history.notes!,
            textDirection: widget.history.notes!.isArabicFormat
                ? TextDirection.rtl
                : TextDirection.ltr,
            style: TextStyleApp.regular16().copyWith(
              color: context.onPrimaryColor,
            ),
          ).withWidth(context.W * .8),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(6.sp),
          decoration: BoxDecoration(
            color: context.primaryColor.withAlpha(50),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Icon(
            Icons.schedule_rounded,
            size: 16.sp,
            color: context.primaryColor,
          ),
        ),
        10.wSpace,
        AutoSizeText(
          widget.history.createdAt.toDateWithTime12H(context),
          maxLines: 1,
          style: TextStyleApp.medium14().copyWith(
            color: context.onSecondaryColor,
          ),
        ).expand(),
      ],
    );
  }
}
