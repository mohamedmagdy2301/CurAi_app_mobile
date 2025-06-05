import 'package:curai_app_mobile/core/extensions/int_extensions.dart';
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/core/utils/widgets/custom_refreah_header.dart';
import 'package:curai_app_mobile/features/appointment_doctor/data/models/reservations_doctor_model.dart';
import 'package:curai_app_mobile/features/appointment_doctor/presentation/cubit/appointment_doctor_cubit.dart';
import 'package:curai_app_mobile/features/appointment_doctor/presentation/widgets/reservations_doctor/reservations_doctor_date_header.dart';
import 'package:curai_app_mobile/features/appointment_doctor/presentation/widgets/reservations_doctor/reservations_doctor_patient_item_card.dart';
import 'package:curai_app_mobile/features/profile/presentation/widgets/help_center/row_navigate_contact_us_widget.dart';
import 'package:fl_chart/fl_chart.dart';
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
  final Set<String> _expandedDates = {};
  int _touchedIndex = -1;

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

  void _toggleExpanded(String date) {
    setState(() {
      if (_expandedDates.contains(date)) {
        _expandedDates.remove(date);
      } else {
        _expandedDates.add(date);
      }
    });
  }

  Map<String, int> _calculateStats() {
    var total = 0;
    var pending = 0;
    var paid = 0;

    widget.appointments.forEach((date, appointmentsList) {
      for (final appointment in appointmentsList) {
        total++;
        if (appointment.paymentStatus == 'pending') pending++;
        if (appointment.paymentStatus == 'paid') paid++;
      }
    });

    return {
      'total': total,
      'pending': pending,
      'paid': paid,
    };
  }

  @override
  Widget build(BuildContext context) {
    final stats = _calculateStats();
    final sortedDates = widget.appointments.keys.toList()..sort();

    return SmartRefresher(
      controller: _refreshController,
      onRefresh: _onRefresh,
      header: const CustomRefreahHeader(),
      child: ListView.separated(
        padding: const EdgeInsets.all(16),
        physics: const AlwaysScrollableScrollPhysics(
          parent: ClampingScrollPhysics(),
        ),
        itemCount: sortedDates.length + 1,
        separatorBuilder: (_, __) => 16.hSpace,
        itemBuilder: (context, index) {
          if (index == 0) {
            return _buildStatsSection(stats);
          }

          final date = sortedDates[index - 1];
          final isExpanded = _expandedDates.contains(date);

          return Container(
            padding: EdgeInsets.only(bottom: !isExpanded ? 0 : 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.r),
                topRight: Radius.circular(16.r),
                bottomLeft: Radius.circular(16.r),
                bottomRight: Radius.circular(16.r),
              ),
              color: Colors.transparent,
              border: Border.all(
                width: !isExpanded ? 0 : .6,
                color: context.primaryColor,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.r),
                    topRight: Radius.circular(16.r),
                    bottomLeft: Radius.circular(isExpanded ? 0 : 16.r),
                    bottomRight: Radius.circular(isExpanded ? 0 : 16.r),
                  ),
                  onTap: () => _toggleExpanded(date),
                  child: ReservationsDoctorDateHeader(
                    date: date,
                    isExpanded: isExpanded,
                    appointmentsCount: widget.appointments[date]!.length,
                  ),
                ),
                if (isExpanded) ...[
                  12.hSpace,
                  ...widget.appointments[date]!.map(
                    (appointment) => ReservationsDoctorItemPatientCard(
                      appointment: appointment,
                      isExpanded: isExpanded,
                    ),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatsSection(Map<String, int> stats) {
    return CustomExpansionTile(
      title: context.translate(LangKeys.statistics),
      leadingIcon: const Icon(Icons.pie_chart),
      contentWidget: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildEnhancedLegend(stats).expand(flex: 2),
          16.wSpace,
          _buildEnhancedPieChart(stats).expand(flex: 3),
        ],
      ),
    );
  }

  Widget _buildEnhancedPieChart(Map<String, int> stats) {
    return AspectRatio(
      aspectRatio: 1,
      child: PieChart(
        PieChartData(
          pieTouchData: PieTouchData(
            touchCallback: (FlTouchEvent event, pieTouchResponse) {
              setState(() {
                if (!event.isInterestedForInteractions ||
                    pieTouchResponse == null ||
                    pieTouchResponse.touchedSection == null) {
                  _touchedIndex = -1;
                  return;
                }
                _touchedIndex =
                    pieTouchResponse.touchedSection!.touchedSectionIndex;
              });
            },
          ),
          borderData: FlBorderData(show: false),
          sectionsSpace: 4,
          centerSpaceRadius: 40.r,
          sections: _buildEnhancedPieChartSections(stats),
        ),
      ),
    );
  }

  List<PieChartSectionData> _buildEnhancedPieChartSections(
    Map<String, int> stats,
  ) {
    final total = stats['total']!;
    if (total == 0) {
      return [
        PieChartSectionData(
          value: 1,
          color: Colors.grey.shade300,
          title: context.translate(LangKeys.noData),
          radius: 60.r,
          titleStyle: TextStyleApp.medium12().copyWith(
            color: Colors.grey.shade600,
          ),
        ),
      ];
    }

    final pending = stats['pending']!;
    final paid = stats['paid']!;

    final pendingPercentage = ((pending / total) * 100).toStringAsFixed(1);
    final paidPercentage = ((paid / total) * 100).toStringAsFixed(1);

    return [
      // Paid section
      PieChartSectionData(
        value: paid.toDouble(),
        color: const Color(0xFF4CAF50),
        title:
            _touchedIndex == 0 ? '$paid\n$paidPercentage%' : '$paidPercentage%',
        radius: _touchedIndex == 0 ? 80.r : 70.r,
        titleStyle: TextStyleApp.semiBold14().copyWith(
          color: Colors.white,
          fontSize: _touchedIndex == 0 ? 16.sp : 14.sp,
        ),
        titlePositionPercentageOffset: 0.6,
        badgeWidget: _touchedIndex == 0
            ? _buildBadge(
                Icons.check_circle,
                const Color(0xFF4CAF50),
              )
            : null,
        badgePositionPercentageOffset: 1.3,
      ),
      PieChartSectionData(
        value: pending.toDouble(),
        color: const Color(0xFFFF9800),
        title: _touchedIndex == 1
            ? '$pending\n$pendingPercentage%'
            : '$pendingPercentage%',
        radius: _touchedIndex == 1 ? 80.r : 70.r,
        titleStyle: TextStyleApp.semiBold14().copyWith(
          color: Colors.white,
          fontSize: _touchedIndex == 1 ? 16.sp : 14.sp,
        ),
        titlePositionPercentageOffset: 0.6,
        badgeWidget: _touchedIndex == 1
            ? _buildBadge(
                Icons.pending,
                const Color(0xFFFF9800),
              )
            : null,
        badgePositionPercentageOffset: 1.3,
      ),
    ];
  }

  Widget _buildBadge(IconData icon, Color color) {
    return Container(
      width: 40.w,
      height: 40.h,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
        boxShadow: [
          BoxShadow(
            color: color.withAlpha(50),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Icon(
        icon,
        color: Colors.white,
        size: 20.sp,
      ),
    );
  }

  Widget _buildEnhancedLegend(Map<String, int> stats) {
    final total = stats['total']!;
    final pending = stats['pending']!;
    final paid = stats['paid']!;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _enhancedLegendItem(
          title: context.translate(LangKeys.totalAppointments),
          count: total,
          color: context.theme.primaryColor,
          icon: Icons.calendar_today,
        ),
        16.hSpace,
        _enhancedLegendItem(
          title: context.translate(LangKeys.paided),
          count: paid,
          color: const Color(0xFF4CAF50),
          icon: Icons.check_circle,
        ),
        16.hSpace,
        _enhancedLegendItem(
          title: context.translate(LangKeys.unpaid),
          count: pending,
          color: const Color(0xFFFF9800),
          icon: Icons.pending,
        ),
      ],
    );
  }

  Widget _enhancedLegendItem({
    required String title,
    required int count,
    required Color color,
    required IconData icon,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: color.withAlpha(25),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: color..withAlpha(75)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 24.w,
            height: 24.h,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 14.sp,
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyleApp.medium12().copyWith(
                    color: Colors.grey.shade600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  count.toString(),
                  style: TextStyleApp.bold16().copyWith(
                    color: color,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
