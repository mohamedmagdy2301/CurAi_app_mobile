import 'package:curai_app_mobile/core/utils/widgets/custom_refreah_header.dart';
import 'package:curai_app_mobile/features/patient_history/data/models/patient_history_model.dart';
import 'package:curai_app_mobile/features/patient_history/presentation/cubit/patient_history_cubit.dart';
import 'package:curai_app_mobile/features/patient_history/presentation/widgets/patient_history_item_widget.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class BuildSuccessPatientHistory extends StatefulWidget {
  const BuildSuccessPatientHistory({
    required this.histories,
    required this.patientId,
    super.key,
  });
  final int patientId;

  final List<PatientHistoryModel> histories;

  @override
  State<BuildSuccessPatientHistory> createState() =>
      _BuildSuccessPatientHistoryState();
}

class _BuildSuccessPatientHistoryState
    extends State<BuildSuccessPatientHistory> {
  final _refreshcontroller = RefreshController();

  Future<void> _onRefresh() async {
    try {
      await Future<void>.delayed(const Duration(milliseconds: 600));
      if (!mounted) return;
      await context.read<PatientHistoryCubit>().getPatientHistory(
            patientId: widget.patientId,
          );
      _refreshcontroller.refreshCompleted();
    } on Exception {
      _refreshcontroller.refreshFailed();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: _refreshcontroller,
      onRefresh: _onRefresh,
      header: const CustomRefreahHeader(),
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: widget.histories.length,
        itemBuilder: (context, index) {
          final history = widget.histories[index];
          return PatientHistoryItemWidget(history: history);
        },
      ),
    );
  }
}
