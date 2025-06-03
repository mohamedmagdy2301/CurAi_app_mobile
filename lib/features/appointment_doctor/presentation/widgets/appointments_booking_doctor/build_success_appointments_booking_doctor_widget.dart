import 'package:curai_app_mobile/core/utils/widgets/custom_refreah_header.dart';
import 'package:curai_app_mobile/features/appointment_doctor/data/models/appointment_booking_model.dart';
import 'package:curai_app_mobile/features/appointment_doctor/presentation/cubit/appointment_doctor_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class BuildSuccessAppointmentsBookingDoctorWidget extends StatefulWidget {
  const BuildSuccessAppointmentsBookingDoctorWidget({
    required this.appointments,
    super.key,
  });
  final Map<String, List<AppointmentBookingDoctorModel>> appointments;

  @override
  State<BuildSuccessAppointmentsBookingDoctorWidget> createState() =>
      _BuildSuccessAppointmentsBookingDoctorWidgetState();
}

class _BuildSuccessAppointmentsBookingDoctorWidgetState
    extends State<BuildSuccessAppointmentsBookingDoctorWidget> {
  final _refreshController = RefreshController();
  Future<void> _onRefresh() async {
    try {
      await Future<void>.delayed(const Duration(milliseconds: 600));
      if (!mounted) return;
      await context
          .read<AppointmentDoctorCubit>()
          .getAppointmentsBookingDoctor();
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
        itemCount: sortedDates.length,
        itemBuilder: (context, index) {
          final date = sortedDates[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _formatDate(date),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                ...widget.appointments[date]!.map(
                  (appointment) => _buildAppointmentCard(context, appointment),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildAppointmentCard(
    BuildContext context,
    AppointmentBookingDoctorModel appointment,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(appointment.patientPicture),
        ),
        title: Text(appointment.patient),
        subtitle: Text('الوقت: ${appointment.appointmentTime}'),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _getStatusText(appointment.status),
              style: TextStyle(
                color: appointment.status == 'completed'
                    ? Colors.green
                    : Colors.orange,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              appointment.paymentStatus == 'paid' ? 'مدفوع' : 'لم يُدفع',
              style: TextStyle(
                color: appointment.paymentStatus == 'paid'
                    ? Colors.green
                    : Colors.red,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(String date) {
    final parsedDate = DateTime.tryParse(date);
    if (parsedDate != null) {
      return "${parsedDate.year}/${parsedDate.month.toString().padLeft(2, '0')}/${parsedDate.day.toString().padLeft(2, '0')}";
    }
    return date;
  }

  String _getStatusText(String status) {
    switch (status) {
      case 'pending':
        return 'قيد الانتظار';
      case 'completed':
        return 'مكتمل';
      default:
        return 'غير معروف';
    }
  }
}
