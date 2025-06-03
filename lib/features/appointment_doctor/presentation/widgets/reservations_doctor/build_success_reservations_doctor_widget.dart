import 'package:curai_app_mobile/core/extensions/int_extensions.dart';
import 'package:curai_app_mobile/core/utils/widgets/custom_refreah_header.dart';
import 'package:curai_app_mobile/features/appointment_doctor/data/models/reservations_doctor_model.dart';
import 'package:curai_app_mobile/features/appointment_doctor/presentation/cubit/appointment_doctor_cubit.dart';
import 'package:curai_app_mobile/features/appointment_doctor/presentation/widgets/reservations_doctor/reservations_doctor_patient_item_card.dart';
import 'package:curai_app_mobile/features/appointment_doctor/presentation/widgets/reservations_doctor/reservations_doctor_date_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  @override
  Widget build(BuildContext context) {
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
        itemCount: sortedDates.length,
        separatorBuilder: (_, __) => 16.hSpace,
        itemBuilder: (context, index) {
          final date = sortedDates[index];
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
                ...widget.appointments[date]!.asMap().entries.map(
                      (entry) => ReservationsDoctorItemPatientCard(
                        appointment: entry.value,
                      ),
                    ),
              ],
            ],
          );
        },
      ),
    );
  }
}
