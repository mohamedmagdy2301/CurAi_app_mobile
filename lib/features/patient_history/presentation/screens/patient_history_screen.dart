import 'package:curai_app_mobile/features/patient_history/presentation/cubit/patient_history_cubit.dart';
import 'package:curai_app_mobile/features/patient_history/presentation/widgets/build_empty_patient_history.dart';
import 'package:curai_app_mobile/features/patient_history/presentation/widgets/build_error_patient_history.dart';
import 'package:curai_app_mobile/features/patient_history/presentation/widgets/build_loading_patient_history.dart';
import 'package:curai_app_mobile/features/patient_history/presentation/widgets/build_success_patient_history.dart';
import 'package:curai_app_mobile/features/patient_history/presentation/widgets/custom_appbar_patient_history.dart';
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
  @override
  void initState() {
    super.initState();
    context.read<PatientHistoryCubit>().getPatientHistory(
          patientId: widget.patientId,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarPatientHistory(
        patientId: widget.patientId,
      ),
      body: BlocBuilder<PatientHistoryCubit, PatientHistoryState>(
        buildWhen: (previous, current) =>
            current is GetPatientHistoryEmpty ||
            current is GetPatientHistoryLoading ||
            current is GetPatientHistorySuccess ||
            current is GetPatientHistoryError ||
            current is AddPatientHistorySuccess,
        builder: (context, state) {
          if (state is GetPatientHistoryLoading) {
            return const BuildLoadingPatientHistory();
          } else if (state is GetPatientHistorySuccess) {
            return BuildSuccessPatientHistory(
              histories: state.histories,
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
    );
  }
}
