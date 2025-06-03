import 'package:curai_app_mobile/features/appointment_doctor/data/models/appointment_booking_model.dart';
import 'package:flutter/material.dart';

class DoctorAppointmentsScreen extends StatelessWidget {
  const DoctorAppointmentsScreen({required this.appointmentsByDate, super.key});
  final Map<String, List<AppointmentBookingDoctorModel>> appointmentsByDate;

  @override
  Widget build(BuildContext context) {
    if (appointmentsByDate.isEmpty) {
      return const Center(child: Text('لا توجد حجوزات حاليًا.'));
    }

    final sortedDates = appointmentsByDate.keys.toList()..sort();

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: sortedDates.length,
      itemBuilder: (context, index) {
        final date = sortedDates[index];
        final appointments = appointmentsByDate[date]!;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _formatDate(date),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            ...appointments.map(
              (appointment) => _buildAppointmentCard(context, appointment),
            ),
            const SizedBox(height: 24),
          ],
        );
      },
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
