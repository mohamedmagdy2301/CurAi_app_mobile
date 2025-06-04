import 'package:curai_app_mobile/features/patient_history/presentation/cubit/patient_history_cubit.dart';
import 'package:curai_app_mobile/features/patient_history/presentation/widgets/build_empty_patient_history.dart';
import 'package:curai_app_mobile/features/patient_history/presentation/widgets/build_error_patient_history.dart';
import 'package:curai_app_mobile/features/patient_history/presentation/widgets/build_loading_patient_history.dart';
import 'package:curai_app_mobile/features/patient_history/presentation/widgets/build_success_patient_history.dart';
import 'package:curai_app_mobile/features/patient_history/presentation/widgets/dialog_add_history.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PatientHistoryScreen extends StatefulWidget {
  const PatientHistoryScreen({
    required this.patientId,
    super.key,
  });
  final int patientId;

  @override
  State<PatientHistoryScreen> createState() => _PatientHistoryScreenState();
}

class _PatientHistoryScreenState extends State<PatientHistoryScreen> {
  final TextEditingController _noteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<PatientHistoryCubit>().getPatientHistory(
          patientId: widget.patientId,
        );
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تاريخ المريض'),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
        elevation: 2,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showAddNoteDialog(context),
          ),
        ],
      ),
      body: BlocBuilder<PatientHistoryCubit, PatientHistoryState>(
        buildWhen: (previous, current) =>
            current is GetPatientHistoryEmpty ||
            current is GetPatientHistoryLoading ||
            current is GetPatientHistorySuccess ||
            current is GetPatientHistoryError,
        builder: (context, state) {
          if (state is GetPatientHistoryLoading) {
            return const BuildLoadingPatientHistory();
          } else if (state is GetPatientHistorySuccess) {
            return BuildSuccessPatientHistory(
              histories: state.patientHistoryList,
              patientId: widget.patientId,
            );
          } else if (state is GetPatientHistoryError) {
            return BuildErrorPatientHistory(
              message: state.message,
              patientId: widget.patientId,
            );
          } else {
            return const BuildEmptyPatientHistory();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddNoteDialog(context),
        backgroundColor: Colors.blue.shade700,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  void _showAddNoteDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return DialogAddHistory(
          patientId: widget.patientId,
          noteController: _noteController,
        );
      },
    );
  }
}
