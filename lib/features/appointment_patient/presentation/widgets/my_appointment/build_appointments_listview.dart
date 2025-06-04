// ignore_for_file: inference_failure_on_instance_creation, use_build_context_synchronously

import 'package:curai_app_mobile/core/dependency_injection/service_locator.dart'
    as di;
import 'package:curai_app_mobile/core/extensions/navigation_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/string_extensions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/routes/routes.dart';
import 'package:curai_app_mobile/core/services/local_notification/local_notification_manager.dart';
import 'package:curai_app_mobile/core/styles/images/app_images.dart';
import 'package:curai_app_mobile/core/utils/models/doctor_model/doctor_info_model.dart';
import 'package:curai_app_mobile/core/utils/widgets/custom_button.dart';
import 'package:curai_app_mobile/core/utils/widgets/custom_refreah_header.dart';
import 'package:curai_app_mobile/core/utils/widgets/sankbar/snackbar_helper.dart';
import 'package:curai_app_mobile/features/appointment_patient/data/models/my_appointment_patient/my_appointment_patient_model.dart';
import 'package:curai_app_mobile/features/appointment_patient/presentation/cubit/appointment_patient_cubit/appointment_patient_cubit.dart';
import 'package:curai_app_mobile/features/appointment_patient/presentation/widgets/my_appointment/appointment_patient_card_widget.dart';
import 'package:curai_app_mobile/features/appointment_patient/presentation/widgets/my_appointment/build_appointments_patient_empty_listview.dart';
import 'package:curai_app_mobile/features/appointment_patient/presentation/widgets/my_appointment/my_appointment_patient_loading_card.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:toastification/toastification.dart';

class BuildAppointmentsList extends StatefulWidget {
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
  State<BuildAppointmentsList> createState() => _BuildAppointmentsListState();
}

class _BuildAppointmentsListState extends State<BuildAppointmentsList> {
  Map<int, bool> isSwitchedMap = {};

  @override
  void initState() {
    super.initState();
    _loadNotificationPreferences();
  }

  Future<void> _loadNotificationPreferences() async {
    final tempMap = <int, bool>{};

    for (final appointment in widget.appointments) {
      if (appointment.id != null) {
        final isActive =
            await di.sl<LocalNotificationService>().getNotificationStatus(
                  id: appointment.id!,
                );
        tempMap[appointment.id!] = isActive;
      }
    }

    setState(() {
      isSwitchedMap = tempMap;
    });
  }

  @override
  void didUpdateWidget(covariant BuildAppointmentsList oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.appointments != oldWidget.appointments) {
      for (final appointment in widget.appointments) {
        if (appointment.id != null) {
          isSwitchedMap.putIfAbsent(appointment.id!, () => false);
        }
      }
    }
  }

  final RefreshController _refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    final filteredAppointments = widget.appointments.where((appointment) {
      final dateStr = appointment.appointmentDate;
      final timeStr = appointment.appointmentTime;

      if (dateStr == null || timeStr == null) return false;

      try {
        final appointmentDateTime = DateTime.parse('$dateStr $timeStr');
        return appointmentDateTime.isAfter(now);
      } on Exception catch (_) {
        return false;
      }
    }).toList();

    return SmartRefresher(
      controller: _refreshController,
      header: const CustomRefreahHeader(),
      onRefresh: () async {
        try {
          await Future.delayed(const Duration(milliseconds: 800));

          await widget.cubit.refreshMyAppointmentPatient();
          _refreshController.refreshCompleted();
        } on Exception {
          _refreshController.refreshFailed();
        }
      },
      child: filteredAppointments.isEmpty
          ? BuildAppointmentsPatientEmptyList(isPending: widget.isPending)
              .center()
          : ListView.builder(
              controller: widget.scrollController,
              physics: const AlwaysScrollableScrollPhysics(
                parent: ClampingScrollPhysics(),
              ),
              itemCount:
                  filteredAppointments.length + (widget.isLoadingMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index < filteredAppointments.length) {
                  final appointment = filteredAppointments[index];
                  final doctorResults =
                      widget.cubit.doctorsData[appointment.doctorId];

                  if (doctorResults == null) {
                    return const SizedBox();
                  }

                  final isSwitched = isSwitchedMap[appointment.id] ?? false;

                  if (widget.isPending) {
                    return AppointmentPatientCardWidget(
                      appointment: appointment,
                      doctorResults: doctorResults,
                      topTrailingWidget: const Spacer(),
                      bottomButton: _buildPaymentBookButton(
                        context,
                        doctorResults,
                        appointment,
                      ),
                    );
                  } else {
                    return AppointmentPatientCardWidget(
                      appointment: appointment,
                      doctorResults: doctorResults,
                      topTrailingWidget: _buildNotificationSwitch(
                        isSwitched,
                        appointment,
                        context,
                      ),
                      bottomButton: _buildRescheduleButton(
                        context,
                        doctorResults,
                        appointment,
                      ),
                    );
                  }
                }
                return const MyAppointmentCardLoadingList();
              },
            ),
    );
  }

  CustomButton _buildRescheduleButton(
    BuildContext context,
    DoctorInfoModel doctorResults,
    ResultsMyAppointmentPatient appointment,
  ) {
    return CustomButton(
      isHalf: true,
      title: LangKeys.reschedule,
      onPressed: () async {
        // Update notification preference to off for this appointment
        if (appointment.id != null) {
          setState(() {
            isSwitchedMap[appointment.id!] = false;
          });
        }

        await context.pushNamed(
          Routes.rescheduleAppointmentScreen,
          arguments: {
            'doctorResults': doctorResults,
            'appointment': appointment,
          },
        );
      },
    );
  }

  CustomButton _buildPaymentBookButton(
    BuildContext context,
    DoctorInfoModel doctorResults,
    ResultsMyAppointmentPatient appointment,
  ) {
    return CustomButton(
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
    );
  }

  Switch _buildNotificationSwitch(
    bool isSwitched,
    ResultsMyAppointmentPatient appointment,
    BuildContext context,
  ) {
    return Switch.adaptive(
      activeColor: context.primaryColor,
      inactiveTrackColor: context.onSecondaryColor,
      thumbColor: WidgetStateProperty.all(Colors.white),
      value: isSwitched,
      onChanged: (value) async {
        if (appointment.id == null) {
          return;
        }

        setState(() {
          isSwitchedMap[appointment.id!] = value;
        });

        if (value) {
          await _scheduleNotificationForAppointment(appointment);
        } else {
          if (appointment.id != null) {
            await di.sl<LocalNotificationService>().cancelNotificationById(
                  appointment.id!,
                );
          }
        }
      },
    );
  }

  Future<void> _scheduleNotificationForAppointment(
    ResultsMyAppointmentPatient appointment,
  ) async {
    try {
      final dateStr = appointment.appointmentDate;
      final timeStr = appointment.appointmentTime;

      if (dateStr == null || timeStr == null || appointment.id == null) {
        return;
      }

      final appointmentDateTime = DateTime.parse('$dateStr $timeStr');

      final notificationTime =
          appointmentDateTime.subtract(const Duration(hours: 1));

      final reminderTime =
          appointmentDateTime.subtract(const Duration(days: 1));

      final doctorName =
          '${widget.cubit.doctorsData[appointment.doctorId]?.firstName ?? ''} '
                  '${widget.cubit.doctorsData[appointment.doctorId]?.lastName ?? ''}'
              .capitalizeFirstChar;

      final now = tz.TZDateTime.now(tz.local);

      await di.sl<LocalNotificationService>().showScheduledNotification(
            context,
            id: appointment.id! + 12345,
            title: 'إشعار تجريبي',
            body: 'عندك كشف مع دكتور $doctorName يوم '
                '${dateStr.substring(0, 10).toFullWithWeekday(context)}',
            imageUrl: widget
                    .cubit.doctorsData[appointment.doctorId]?.profilePicture ??
                AppImages.avatarOnlineDoctor,
            day: now.day,
            hour: now.hour,
            minute: now.minute,
            second: now.second + 10,
          );

      await di.sl<LocalNotificationService>().showScheduledNotification(
            context,
            id: appointment.id!,
            title: 'تذكير بموعدك',
            body: 'عندك كشف مع $doctorName بعد ساعة',
            imageUrl: widget
                    .cubit.doctorsData[appointment.doctorId]?.profilePicture ??
                AppImages.avatarOnlineDoctor,
            day: notificationTime.day,
            hour: notificationTime.hour,
            minute: notificationTime.minute,
          );

      await di.sl<LocalNotificationService>().showScheduledNotification(
            context,
            id: appointment.id! + 10000,
            title: 'موعدك غدًا',
            body: 'فكرك عندك كشف مع $doctorName '
                'بكرة الساعة ${timeStr.substring(0, 5).toLocalizedTime(context)}',
            imageUrl: widget
                    .cubit.doctorsData[appointment.doctorId]?.profilePicture ??
                AppImages.avatarOnlineDoctor,
            day: reminderTime.day,
            hour: 9,
            minute: 0,
          );
    } on Exception catch (e) {
      showMessage(
        context,
        message: e.toString(),
        type: ToastificationType.error,
      );
    }
  }
}
