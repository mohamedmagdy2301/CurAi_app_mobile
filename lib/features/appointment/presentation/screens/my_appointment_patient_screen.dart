import 'package:curai_app_mobile/core/utils/helper/shimmer_effect.dart';
import 'package:curai_app_mobile/features/appointment/data/models/my_appointment/my_appointment_patient_model.dart';
import 'package:curai_app_mobile/features/appointment/presentation/cubit/appointment_patient_cubit/appointment_patient_cubit.dart';
import 'package:curai_app_mobile/features/appointment/presentation/cubit/appointment_patient_cubit/appointment_patient_state.dart';
import 'package:curai_app_mobile/features/appointment/presentation/widgets/my_appointment/custom_appbar_my_appointment.dart';
import 'package:curai_app_mobile/features/appointment/presentation/widgets/my_appointment/paided_body_widget.dart';
import 'package:curai_app_mobile/features/appointment/presentation/widgets/my_appointment/pending_body_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MyAppointmentPatientScreen extends StatefulWidget {
  const MyAppointmentPatientScreen({super.key});

  @override
  State<MyAppointmentPatientScreen> createState() =>
      _MyAppointmentPatientScreenState();
}

class _MyAppointmentPatientScreenState extends State<MyAppointmentPatientScreen>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);

    Future.microtask(() {
      context.read<AppointmentPatientCubit>().getMyAppointmentPatient();
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbarMyAppointment(tabController: tabController),
      body: BlocBuilder<AppointmentPatientCubit, AppointmentPatientState>(
        builder: (context, state) {
          if (state is GetMyAppointmentPatientFailure) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.error, size: 80, color: Colors.redAccent),
                  const SizedBox(height: 16),
                  Text(
                    state.message,
                    style: const TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context
                          .read<AppointmentPatientCubit>()
                          .getMyAppointmentPatient();
                    },
                    child: const Text('إعادة المحاولة'),
                  ),
                ],
              ),
            );
          } else if (state is GetMyAppointmentPatientSuccess) {
            final pendingList =
                context.read<AppointmentPatientCubit>().pendingAppointments;
            final paidList =
                context.read<AppointmentPatientCubit>().paidAppointments;

            if (pendingList.isEmpty && paidList.isEmpty) {
              return const Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.event_busy, size: 80, color: Colors.grey),
                    SizedBox(height: 16),
                    Text(
                      'لا يوجد مواعيد حالياً',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              );
            }

            return TabBarView(
              controller: tabController,
              children: [
                PendingBodyWidget(pendingAppointmentsList: pendingList),
                PaidedBodyWidget(paidAppointmentsList: paidList),
              ],
            );
          }

          return Skeletonizer(
            effect: shimmerEffect(context),
            child: TabBarView(
              controller: tabController,
              children: [
                PendingBodyWidget(pendingAppointmentsList: dummyMyAppointments),
                PaidedBodyWidget(paidAppointmentsList: dummyMyAppointments),
              ],
            ),
          );
        },
      ),
    );
  }
}
