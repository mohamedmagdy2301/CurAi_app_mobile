import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/extensions/int_extensions.dart'
    as int_ext;
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/string_extensions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/core/styles/images/app_images.dart';
import 'package:curai_app_mobile/core/utils/widgets/custom_button.dart';
import 'package:curai_app_mobile/core/utils/widgets/custom_cached_network_image.dart';
import 'package:curai_app_mobile/core/utils/widgets/custom_divider.dart';
import 'package:curai_app_mobile/core/utils/widgets/custom_refreah_header.dart';
import 'package:curai_app_mobile/core/utils/widgets/image_viewer_full_screen.dart';
import 'package:curai_app_mobile/features/appointment_doctor/data/models/reservations_doctor_model.dart';
import 'package:curai_app_mobile/features/appointment_doctor/presentation/cubit/appointment_doctor_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class BuildSuccessReservationsDoctorWidget extends StatefulWidget {
  const BuildSuccessReservationsDoctorWidget({
    required this.appointments,
    super.key,
  });
  final Map<String, List<ReservationsDoctorModel>> appointments;

  @override
  State<BuildSuccessReservationsDoctorWidget> createState() =>
      _BuildSuccessReservationsDoctorWidgetState();
}

class _BuildSuccessReservationsDoctorWidgetState
    extends State<BuildSuccessReservationsDoctorWidget>
    with SingleTickerProviderStateMixin {
  final _refreshController = RefreshController();

  Future<void> _onRefresh() async {
    try {
      await Future<void>.delayed(const Duration(milliseconds: 600));
      if (!mounted) return;
      await context.read<AppointmentDoctorCubit>().getReservationsDoctor();
      _refreshController.refreshCompleted();
    } on Exception catch (_) {
      _refreshController.refreshFailed();
    }
  }

  @override
  Widget build(BuildContext context) {
    final sortedDates = widget.appointments.keys.toList()..sort();

    return SmartRefresher(
      controller: _refreshController,
      onRefresh: _onRefresh,
      header: const CustomRefreahHeader(),
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(
          parent: ClampingScrollPhysics(),
        ),
        padding: const EdgeInsets.all(16),
        itemCount: sortedDates.length,
        itemBuilder: (context, index) {
          return _buildDateExpansionTile(
            sortedDates[index],
            widget.appointments[sortedDates[index]]!,
          );
        },
      ),
    );
  }

  Widget _buildDateExpansionTile(
    String date,
    List<ReservationsDoctorModel> appointments,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            context.primaryColor.withAlpha(140),
            context.primaryColor.withAlpha(180),
            context.primaryColor.withAlpha(220),
            context.primaryColor.withAlpha(250),
            context.primaryColor,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: context.primaryColor.withAlpha(60),
            blurRadius: 12,
            offset: const Offset(1, 2),
          ),
        ],
      ),
      child: ExpansionTile(
        tilePadding: context.padding(horizontal: 20, vertical: 8),
        childrenPadding: const EdgeInsets.only(bottom: 16),
        backgroundColor: Colors.transparent, // خلفية شفافة عند التوسع
        collapsedBackgroundColor: Colors.transparent, // خلفية شفافة عند الطي
        iconColor: Colors.white,
        collapsedIconColor: Colors.white,

        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: context.backgroundColor.withAlpha(70),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                Icons.calendar_month_rounded,
                color: Colors.white,
                size: 24.sp,
              ),
            ),
            12.wSpace,
            Expanded(
              child: AutoSizeText(
                date.toFullWithWeekdayTwoLine(context),
                maxLines: 2,
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
                style: TextStyleApp.semiBold18().copyWith(
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      color: Colors.black.withAlpha(100),
                      offset: const Offset(1, 1),
                      blurRadius: 2,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: context.padding(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: context.backgroundColor.withAlpha(60),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.white.withAlpha(40),
                ),
              ),
              child: AutoSizeText(
                '${appointments.length} ${context.translate(LangKeys.appointments)}',
                style: TextStyleApp.medium12().copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        children: [
          _buildAppointmentsList(appointments),
        ],
      ),
    );
  }

  Widget _buildAppointmentsList(
    List<ReservationsDoctorModel> appointments,
  ) {
    return Column(
      children: appointments.asMap().entries.map((entry) {
        final index = entry.key;
        final appointment = entry.value;
        return _buildAppointmentCard(appointment, index);
      }).toList(),
    );
  }

  Widget _buildAppointmentCard(
    ReservationsDoctorModel appointment,
    int index,
  ) {
    return Card(
      margin: context.padding(vertical: 8, horizontal: 14),
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      color: context.isDark
          ? const Color.fromARGB(255, 0, 0, 0)
          : const Color.fromARGB(255, 255, 255, 255),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        children: [
          Row(
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(10.r),
                onTap: () {
                  showImageViewerFullScreen(
                    context,
                    imageUrl: appointment.patientPicture ??
                        AppImages.avatarOnlineDoctor,
                  );
                },
                child: CustomCachedNetworkImage(
                  imgUrl: appointment.patientPicture ??
                      AppImages.avatarOnlineDoctor,
                  width: context.H * 0.1,
                  height: context.H * 0.1,
                  loadingImgPadding: 40.sp,
                  errorIconSize: 60.sp,
                ).cornerRadiusWithClipRRect(10.r),
              ),
              16.wSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      appointment.patient,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyleApp.semiBold22().copyWith(
                        color: context.onPrimaryColor,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time_rounded,
                          color: context.onSecondaryColor,
                          size: 18.sp,
                        ),
                        4.wSpace,
                        AutoSizeText(
                          appointment.appointmentTime.toLocalizedTime(context),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.start,
                          style: TextStyleApp.medium16().copyWith(
                            color: context.onSecondaryColor,
                          ),
                        ),
                        const Spacer(),
                        _buildPaymentStatusChip(appointment.paymentStatus),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          16.hSpace,
          const CustomDivider(),
          16.hSpace,
          Row(
            children: [
              CustomButton(
                title: LangKeys.addHistory,
                isHalf: true,
                onPressed: () {},
              ).expand(),
              16.wSpace,
              CustomButton(
                title: LangKeys.viewHistory,
                isHalf: true,
                colorBackground: context.isDark
                    ? Colors.black45
                    : const Color.fromARGB(255, 255, 255, 255),
                colorBorder: context.primaryColor,
                colorText: context.primaryColor,
                onPressed: () {},
              ).expand(),
            ],
          ),
        ],
      ).paddingSymmetric(horizontal: 16, vertical: 16),
    );
  }

  Widget _buildPaymentStatusChip(String paymentStatus) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: paymentStatus == 'paid'
              ? [Colors.green.shade600, Colors.green.shade400]
              : [Colors.orange.shade600, Colors.orange.shade400],
        ),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: paymentStatus == 'paid'
                ? Colors.green.withAlpha(50)
                : Colors.orange.withAlpha(50),
            blurRadius: 8,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: AutoSizeText(
        paymentStatus == 'paid'
            ? context.translate(LangKeys.paided)
            : context.translate(LangKeys.pending),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
        style: TextStyleApp.semiBold12().copyWith(
          color: Colors.white,
        ),
      ),
    );
  }
}
