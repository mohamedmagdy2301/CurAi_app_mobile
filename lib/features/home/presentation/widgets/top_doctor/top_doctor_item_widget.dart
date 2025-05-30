import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/dependency_injection/service_locator.dart'
    as di;
import 'package:curai_app_mobile/core/extensions/int_extensions.dart';
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/navigation_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/string_extensions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/core/styles/images/app_images.dart';
import 'package:curai_app_mobile/core/utils/models/doctor_model/doctor_info_model.dart';
import 'package:curai_app_mobile/core/utils/widgets/custom_cached_network_image.dart';
import 'package:curai_app_mobile/features/appointment_patient/presentation/cubit/appointment_patient_cubit/appointment_patient_cubit.dart';
import 'package:curai_app_mobile/features/home/presentation/screens/details_doctor_screen.dart';
import 'package:curai_app_mobile/features/home/presentation/widgets/doctor_speciality/specialization_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TopDoctorItemWidget extends StatelessWidget {
  const TopDoctorItemWidget({
    required this.doctorsList,
    super.key,
    this.isLoading,
  });

  final DoctorInfoModel doctorsList;
  final bool? isLoading;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.push(
        BlocProvider<AppointmentPatientCubit>(
          create: (context) => di.sl<AppointmentPatientCubit>(),
          child: DoctorDetailsScreen(doctorResults: doctorsList),
        ),
      ),
      borderRadius: BorderRadius.circular(10.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isLoading ?? false)
            Container(
              width: context.H * 0.21,
              height: context.H * 0.19,
              color: context.onSecondaryColor,
            ).cornerRadiusWithClipRRect(15)
          else
            CustomCachedNetworkImage(
              imgUrl:
                  doctorsList.profilePicture ?? AppImages.avatarOnlineDoctor,
              width: context.H * 0.21,
              height: context.H * 0.19,
              loadingImgPadding: 80.w,
              errorIconSize: 50.sp,
            ).cornerRadiusWithClipRRect(15),
          10.hSpace,
          SizedBox(
            width: context.W * .39,
            child: AutoSizeText(
              '${context.translate(LangKeys.dr)} '
              '${doctorsList.firstName?.capitalizeFirstChar} '
              '${doctorsList.lastName?.capitalizeFirstChar}',
              maxLines: 1,
              textAlign: TextAlign.start,
              overflow: TextOverflow.ellipsis,
              style: TextStyleApp.extraBold18().copyWith(
                color: context.onPrimaryColor,
              ),
            ),
          ),
          SizedBox(
            width: context.W * .3,
            child: AutoSizeText(
              specializationName(
                doctorsList.specialization ?? '',
                isArabic: context.isStateArabic,
              ),
              maxLines: 1,
              textAlign: TextAlign.start,
              overflow: TextOverflow.ellipsis,
              style: TextStyleApp.medium16().copyWith(
                color: context.onSecondaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
