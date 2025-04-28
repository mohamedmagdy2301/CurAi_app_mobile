// ignore_for_file: inference_failure_on_instance_creation

import 'package:curai_app_mobile/core/extensions/int_extensions.dart'
    as int_ext;
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/navigation_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/routes/routes.dart';
import 'package:curai_app_mobile/core/utils/widgets/custom_button.dart';
import 'package:curai_app_mobile/core/utils/widgets/custom_loading_widget.dart';
import 'package:curai_app_mobile/core/utils/widgets/sankbar/snackbar_helper.dart';
import 'package:curai_app_mobile/features/appointment/data/models/my_appointment/my_appointment_patient_model.dart';
import 'package:curai_app_mobile/features/appointment/presentation/cubit/appointment_patient_cubit/appointment_patient_cubit.dart';
import 'package:curai_app_mobile/features/appointment/presentation/widgets/my_appointment/appointment_card_widget.dart';
import 'package:curai_app_mobile/features/appointment/presentation/widgets/my_appointment/my_appointment_loading_card.dart';
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
            final appointment = appointments[index];
            final doctorResults = cubit.doctorsData[appointment.doctorId];

            if (doctorResults == null) {
              return const SizedBox();
            }

            if (isPending) {
              return AppointmentCardWidget(
                appointment: appointment,
                doctorResults: doctorResults,
                topTrailingWidget: const Spacer(),
                bottomButtons: [
                  CustomButton(
                    isHalf: true,
                    title: LangKeys.paymentBook,
                    onPressed: () {
                      context.pushNamed(
                        Routes.paymentAppointmentScreen,
                        arguments: {
                          'doctorResults': doctorResults,
                          'appointmentId': appointment.id,
                        },
                      );
                    },
                  ).expand(),
                  15.wSpace,
                  CustomButton(
                    isHalf: true,
                    title: LangKeys.cancelAppointment,
                    colorBackground:
                        context.isDark ? Colors.black : Colors.white,
                    colorBorder: Colors.redAccent,
                    colorText: Colors.redAccent,
                    onPressed: () {
                      showMessage(
                        context,
                        type: SnackBarType.success,
                        message: 'Cancel appointment successfully',
                      );
                    },
                  ).expand(),
                ],
              );
            } else {
              return AppointmentCardWidget(
                appointment: appointment,
                doctorResults: doctorResults,
                topTrailingWidget: StatefulBuilder(
                  builder: (context, setState) {
                    var isSwitched = false;
                    return Switch.adaptive(
                      value: isSwitched,
                      onChanged: (_) {
                        setState(() => isSwitched = !isSwitched);
                        if (isSwitched) {
                          showMessage(
                            context,
                            type: SnackBarType.success,
                            message: context.isStateArabic
                                ? 'تم تفعيل الاشعار للموعد بنجاح 🔔'
                                : 'You have successfully enabled '
                                    'notifications for the appointment 🔔',
                          );
                        } else {
                          showMessage(
                            context,
                            type: SnackBarType.success,
                            message: context.isStateArabic
                                ? 'تم تعطيل الاشعار للموعد بنجاح 🔕'
                                : 'You have successfully disabled '
                                    'notifications for the appointment 🔕',
                          );
                        }
                      },
                    );
                  },
                ),
                bottomButtons: [
                  CustomButton(
                    isHalf: true,
                    title: LangKeys.reschedule,
                    onPressed: () {
                      showMessage(
                        context,
                        type: SnackBarType.success,
                        message: 'Reschedule appointment successfully',
                      );
                    },
                  ).expand(),
                  15.wSpace,
                  CustomButton(
                    isHalf: true,
                    title: LangKeys.cancelAppointment,
                    colorBackground:
                        context.isDark ? Colors.black : Colors.white,
                    colorBorder: Colors.redAccent,
                    colorText: Colors.redAccent,
                    onPressed: () {
                      showMessage(
                        context,
                        type: SnackBarType.success,
                        message: 'Cancel appointment successfully',
                      );
                    },
                  ).expand(),
                ],
              );
            }
          }
          return const MyAppointmentCardLoadingList();
        },
      ),
    );
  }
}
