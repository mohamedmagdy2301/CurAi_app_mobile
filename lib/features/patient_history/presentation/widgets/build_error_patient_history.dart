import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/features/patient_history/presentation/cubit/patient_history_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuildErrorPatientHistory extends StatelessWidget {
  const BuildErrorPatientHistory({
    required this.message,
    required this.patientId,
    super.key,
  });
  final String message;
  final int patientId;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.error_outline,
          size: 80,
          color: Colors.red.shade400,
        ),
        const SizedBox(height: 16),
        Text(
          'حدث خطأ',
          style: TextStyle(
            fontSize: 18,
            color: Colors.red.shade600,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade600,
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            context.read<PatientHistoryCubit>().getPatientHistory(
                  patientId: patientId,
                );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue.shade700,
            foregroundColor: Colors.white,
          ),
          child: const Text('إعادة المحاولة'),
        ),
      ],
    ).center();
  }
}
