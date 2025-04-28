// ignore_for_file: inference_failure_on_instance_creation

import 'package:curai_app_mobile/core/utils/widgets/custom_loading_widget.dart';
import 'package:curai_app_mobile/features/appointment/data/models/my_appointment/my_appointment_patient_model.dart';
import 'package:curai_app_mobile/features/appointment/presentation/cubit/appointment_patient_cubit/appointment_patient_cubit.dart';
import 'package:curai_app_mobile/features/appointment/presentation/widgets/my_appointment/my_appointment_loading_card.dart';
import 'package:curai_app_mobile/features/appointment/presentation/widgets/my_appointment/paided_card_item_widget.dart';
import 'package:curai_app_mobile/features/appointment/presentation/widgets/my_appointment/pending_card_item_widget.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';

class BuildAppointmentsList extends StatelessWidget {
  const BuildAppointmentsList({
    required this.cubit,
    required this.appointments,
    required this.scrollController,
    required this.isLoadingMore,
    required this.isPending,
    super.key,
  });
  final AppointmentPatientCubit cubit;
  final List<ResultsMyAppointmentPatient> appointments;
  final ScrollController scrollController;
  final bool isLoadingMore;
  final bool isPending;
  @override
  Widget build(BuildContext context) {
    return CustomRefreshIndicator(
      onRefresh: () async {
        await Future.delayed(const Duration(milliseconds: 500));
        await cubit.getMyAppointmentPatient();
      },
      builder: (context, child, controller) {
        return AnimatedBuilder(
          animation: controller,
          builder: (context, _) {
            return Stack(
              children: [
                if (!controller.isIdle)
                  Positioned(
                    top: controller.value.clamp(0, 1) * 30,
                    left: MediaQuery.of(context).size.width / 2 - 15,
                    child: Transform.scale(
                      scale: controller.value.clamp(0, 1) * 1.5,
                      child: const CustomLoadingWidget(),
                    ),
                  ),
                Transform.translate(
                  offset: Offset(0, 90 * controller.value),
                  child: child,
                ),
              ],
            );
          },
        );
      },
      child: ListView.builder(
        controller: scrollController,
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        itemCount: appointments.length + (isLoadingMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index < appointments.length) {
            if (isPending) {
              return PendingCardItemWidget(
                pendingAppointment: appointments[index],
              );
            } else {
              return PaidedCardItemWidget(
                paidAppointment: appointments[index],
              );
            }
          }
          return const MyAppointmentCardLoadingList();
        },
      ),
    );
  }
}
