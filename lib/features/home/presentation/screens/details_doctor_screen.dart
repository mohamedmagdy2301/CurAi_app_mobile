import 'package:curai_app_mobile/core/extensions/int_extensions.dart';
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/services/local_storage/menage_user_data.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/core/utils/models/doctor_model/doctor_info_model.dart';
import 'package:curai_app_mobile/features/appointment_patient/presentation/cubit/appointment_patient_cubit/appointment_patient_cubit.dart';
import 'package:curai_app_mobile/features/home/presentation/widgets/details_doctor/custom_appbar_details_doctor.dart';
import 'package:curai_app_mobile/features/home/presentation/widgets/details_doctor/header_details_doctor_widget.dart';
import 'package:curai_app_mobile/features/home/presentation/widgets/details_doctor/location_tap/location_tap.dart';
import 'package:curai_app_mobile/features/home/presentation/widgets/details_doctor/reviews_tap.dart';
import 'package:curai_app_mobile/features/home/presentation/widgets/details_doctor/schedule_tap/schedule_tap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoctorDetailsScreen extends StatefulWidget {
  const DoctorDetailsScreen({
    required this.doctorResults,
    super.key,
  });

  final DoctorInfoModel doctorResults;

  @override
  State<DoctorDetailsScreen> createState() => _DoctorDetailsScreenState();
}

class _DoctorDetailsScreenState extends State<DoctorDetailsScreen> {
  int selectedIndex = 0;
  @override
  void initState() {
    super.initState();
    if (getRole() == 'patient') {
      context.read<AppointmentPatientCubit>().getAppointmentPatientAvailable(
            doctorId: widget.doctorResults.id!,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: (getRole() == 'patient') ? 3 : 2,
      child: Scaffold(
        appBar: CustomAppBarDetailsDoctor(doctor: widget.doctorResults),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderDetailsDoctorWidget(doctorResults: widget.doctorResults),
            10.hSpace,
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
              onTap: (value) {
                setState(() {
                  selectedIndex = value;
                });
              },
              tabs: [
                if (getRole() == 'patient')
                  Tab(text: context.translate(LangKeys.schedule)),
                Tab(text: context.translate(LangKeys.location)),
                Tab(text: context.translate(LangKeys.reviews)),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  if (getRole() == 'patient')
                    ScheduleTap(doctorResults: widget.doctorResults),
                  LocationTap(doctorResults: widget.doctorResults),
                  ReviewsTap(doctorResults: widget.doctorResults),
                ],
              ),
            ),
          ],
        ),
      ).paddingSymmetric(horizontal: 10, vertical: 5),
    );
  }
}
