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
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildLegend(),
                PieChart(
                  PieChartData(
                    sections: _buildPieChartSections(stats),
                    centerSpaceRadius: 30,
                    sectionsSpace: 3,
                    borderData: FlBorderData(show: false),
                  ),
                ).withWidth(context.W * .25),
              ],
            ).withHeight(context.H * .25);
          }

          final date = sortedDates[index - 1];
          final isExpanded = _expandedDates.contains(date);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () => _toggleExpanded(date),
                child: ReservationsDoctorDateHeader(
                  date: date,
                  appointmentsCount: widget.appointments[date]!.length,
                ),
              ),
              if (isExpanded) ...[
                12.hSpace,
                ...widget.appointments[date]!.map(
                  (appointment) => ReservationsDoctorItemPatientCard(
                    appointment: appointment,
                  ),
                ),
              ],
            ],
          );
        },
      ),
    );
  }

  List<PieChartSectionData> _buildPieChartSections(Map<String, int> stats) {
    final total = stats['total']!;
    if (total == 0) return [];

    final pending = stats['pending']!;
    final paid = stats['paid']!;

    final pendingPercentage = ((pending / total) * 100).toStringAsFixed(1);
    final paidPercentage = ((paid / total) * 100).toStringAsFixed(1);

    return [
      PieChartSectionData(
        value: pending.toDouble(),
        color: Colors.orange,
        title: '$pendingPercentage%',
        radius: 70.r,
        titleStyle: TextStyleApp.semiBold14().copyWith(
          color: Colors.white,
        ),
      ),
      PieChartSectionData(
        value: paid.toDouble(),
        color: Colors.green,
        title: '$paidPercentage%',
        radius: 60.r,
        titleStyle: TextStyleApp.semiBold14().copyWith(
          color: Colors.white,
        ),
      ),
    ];
  }

  Widget _buildLegend() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 12.sp,
      children: [
        _legendItem(context.translate(LangKeys.paided), Colors.green),
        _legendItem(context.translate(LangKeys.unpaid), Colors.orange),
      ],
    );
  }

  Widget _legendItem(String title, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(width: 12, height: 12, color: color),
        const SizedBox(width: 4),
        Text(title),
      ],
    );
  }
}
