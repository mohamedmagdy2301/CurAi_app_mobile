import 'dart:io';

import 'package:curai_app_mobile/core/extensions/int_extensions.dart';
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/navigation_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/core/utils/widgets/custom_button.dart';
import 'package:curai_app_mobile/features/appointment/presentation/cubit/appointment_patient_cubit/appointment_patient_cubit.dart';
import 'package:curai_app_mobile/features/appointment/presentation/cubit/appointment_patient_cubit/appointment_patient_state.dart';
import 'package:curai_app_mobile/features/appointment/presentation/screens/book_appointment_screen.dart';
import 'package:curai_app_mobile/features/user/data/models/doctor/doctor_model.dart';
import 'package:curai_app_mobile/features/user/presentation/widgets/home/details_doctor/about_tap.dart';
import 'package:curai_app_mobile/features/user/presentation/widgets/home/details_doctor/custom_appbar_details_doctor.dart';
import 'package:curai_app_mobile/features/user/presentation/widgets/home/details_doctor/header_details_doctor_widget.dart';
import 'package:curai_app_mobile/features/user/presentation/widgets/home/details_doctor/location_tap.dart';
import 'package:curai_app_mobile/features/user/presentation/widgets/home/details_doctor/reviews_tap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoctorDetailsScreen extends StatefulWidget {
  const DoctorDetailsScreen({
    required this.doctorResults,
    super.key,
  });

  final DoctorResults doctorResults;

  @override
  State<DoctorDetailsScreen> createState() => _DoctorDetailsScreenState();
}

class _DoctorDetailsScreenState extends State<DoctorDetailsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AppointmentPatientCubit>().getAppointmentAvailable(
          doctorId: widget.doctorResults.id!,
        );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: const CustomAppBarDetailsDoctor(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderDetailsDoctorWidget(doctorResults: widget.doctorResults),
            20.hSpace,
            TabBar(
              labelColor: context.primaryColor,
              unselectedLabelColor: context.onPrimaryColor,
              indicatorColor: context.primaryColor,
              indicatorWeight: 3.w,
              indicatorSize: TabBarIndicatorSize.tab,
              labelStyle: TextStyleApp.bold16().copyWith(
                color: context.primaryColor,
              ),
              unselectedLabelStyle: TextStyleApp.regular16().copyWith(
                color: context.onPrimaryColor,
              ),
              dividerColor: context.onSecondaryColor.withAlpha(120),
              overlayColor: WidgetStateProperty.all(
                context.primaryColor.withAlpha(25),
              ),
              tabs: [
                Tab(text: context.translate(LangKeys.about)),
                Tab(text: context.translate(LangKeys.location)),
                Tab(text: context.translate(LangKeys.reviews)),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  AboutTap(doctorResults: widget.doctorResults),
                  LocationTap(doctorResults: widget.doctorResults),
                  ReviewsTap(doctorResults: widget.doctorResults),
                ],
              ),
            ),
            BlocBuilder<AppointmentPatientCubit, AppointmentPatientState>(
              builder: (context, state) {
                return CustomButton(
                  title: state is! AppointmentPatientAvailableSuccess
                      ? LangKeys.notAvailableToBook
                      : LangKeys.bookAppointment,
                  isLoading: state is AppointmentPatientAvailableLoading,
                  colorBackground: state is! AppointmentPatientAvailableSuccess
                      ? Colors.grey
                      : context.primaryColor,
                  onPressed: state is! AppointmentPatientAvailableSuccess
                      ? () {}
                      : () {
                          context.push(
                            BookAppointmentScreen(
                              doctorResults: widget.doctorResults,
                              appointmentAvailableModel:
                                  state.appointmentAvailableModel,
                            ),
                          );
                        },
                );
              },
            ).paddingOnly(bottom: Platform.isIOS ? 17 : 10),
          ],
        ),
      ).paddingSymmetric(horizontal: 12, vertical: 5),
    );
  }
}
