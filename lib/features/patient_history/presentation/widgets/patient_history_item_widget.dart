import 'package:curai_app_mobile/features/patient_history/data/models/patient_history_model.dart';
import 'package:flutter/material.dart';

class PatientHistoryItemWidget extends StatelessWidget {
  const PatientHistoryItemWidget({
    required this.history,
    super.key,
  });

  final PatientHistoryModel history;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with doctor and patient info
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.blue.shade100,
                  child: Icon(
                    Icons.medical_services,
                    color: Colors.blue.shade700,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'د. ${history.doctorUsername}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.blue.shade700,
                        ),
                      ),
                      Text(
                        'المريض: ${history.patientUsername}',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.green.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '#${history.id}',
                    style: TextStyle(
                      color: Colors.green.shade700,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Notes section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.note_alt,
                        size: 16,
                        color: Colors.grey.shade600,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'الملاحظات:',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    history.notes ?? 'لا يوجد ملاحظات',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey.shade800,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Date and time
            Row(
              children: [
                Icon(
                  Icons.access_time,
                  size: 16,
                  color: Colors.grey.shade500,
                ),
                const SizedBox(width: 6),
                Text(
                  history.createdAt,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
