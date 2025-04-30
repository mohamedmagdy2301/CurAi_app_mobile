// ignore_for_file: lines_longer_than_80_chars

import 'package:curai_app_mobile/core/utils/helper/shimmer_effect.dart';
import 'package:curai_app_mobile/features/appointment_doctor/data/models/working_time_doctor_available/working_time_doctor_available_model.dart';
import 'package:curai_app_mobile/features/appointment_doctor/presentation/cubit/appointment_doctor_cubit.dart';
import 'package:curai_app_mobile/features/appointment_doctor/presentation/widgets/working_time_doctor_empty_widget.dart';
import 'package:curai_app_mobile/features/appointment_doctor/presentation/widgets/working_time_doctor_error_widget.dart';
import 'package:curai_app_mobile/features/appointment_doctor/presentation/widgets/working_time_doctor_listview_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class BuildWorkingTimeDoctorListview extends StatefulWidget {
  const BuildWorkingTimeDoctorListview({super.key});

  @override
  State<BuildWorkingTimeDoctorListview> createState() =>
      _BuildWorkingTimeDoctorListviewState();
}

class _BuildWorkingTimeDoctorListviewState
    extends State<BuildWorkingTimeDoctorListview> {
  @override
  void initState() {
    super.initState();
    context.read<AppointmentDoctorCubit>().getWorkingTimeAvailableDoctor();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppointmentDoctorCubit, AppointmentDoctorState>(
      buildWhen: (previous, current) =>
          current is GetWorkingTimeDoctorAvailableFailure ||
          current is GetWorkingTimeDoctorAvailableSuccess ||
          current is GetWorkingTimeDoctorAvailableEmpty ||
          current is GetWorkingTimeDoctorAvailableLoading,
      builder: (context, state) {
        if (state is GetWorkingTimeDoctorAvailableFailure) {
          return WorkingTimeDoctorErrorWidget(state: state);
        } else if (state is GetWorkingTimeDoctorAvailableEmpty) {
          return const WorkingTimeDoctorEmptyWidget();
        } else if (state is GetWorkingTimeDoctorAvailableSuccess) {
          return WorkingTimeDoctorAvailabilityListView(
            workingTimeList: state.workingTimeList,
          );
        }
        return Skeletonizer(
          effect: shimmerEffect(context),
          child: WorkingTimeDoctorAvailabilityListView(
            workingTimeList:
                WorkingTimeDoctorAvailableModel.removeDuplicatesAndEmptyDays(
              workingTimeDoctorListDummy,
            ),
          ),
        );
      },
    );
  }
}
