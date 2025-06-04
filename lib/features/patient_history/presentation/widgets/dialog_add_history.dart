import 'package:curai_app_mobile/core/dependency_injection/service_locator.dart';
import 'package:curai_app_mobile/core/extensions/navigation_context_extansions.dart';
import 'package:curai_app_mobile/features/patient_history/presentation/cubit/patient_history_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DialogAddHistory extends StatefulWidget {
  const DialogAddHistory({
    required this.patientId,
    required this.noteController,
    super.key,
  });
  final int patientId;
  final TextEditingController noteController;

  @override
  State<DialogAddHistory> createState() => _DialogAddHistoryState();
}

class _DialogAddHistoryState extends State<DialogAddHistory> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<PatientHistoryCubit>(),
      child: AlertDialog(
        title: const Text('إضافة ملاحظة جديدة'),
        content: TextField(
          controller: widget.noteController,
          maxLines: 4,
          decoration: InputDecoration(
            hintText: 'اكتب الملاحظة هنا...',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              context.pop();
              widget.noteController.clear();
            },
            child: const Text('إلغاء'),
          ),
          BlocBuilder<PatientHistoryCubit, PatientHistoryState>(
            builder: (context, state) {
              final isLoading = state is AddPatientHistoryLoading;

              return ElevatedButton(
                onPressed: isLoading
                    ? null
                    : () {
                        if (widget.noteController.text.trim().isNotEmpty) {
                          context.read<PatientHistoryCubit>().addPatientHistory(
                                patientId: widget.patientId,
                                noteHistory: widget.noteController.text.trim(),
                              );
                          context.pop();
                          widget.noteController.clear();
                        }
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade700,
                  foregroundColor: Colors.white,
                ),
                child: isLoading
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : const Text('إضافة'),
              );
            },
          ),
        ],
      ),
    );
  }
}
