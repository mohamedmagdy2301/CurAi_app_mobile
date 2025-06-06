import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/dependency_injection/service_locator.dart'
    as di;
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/navigation_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/string_extensions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/core/styles/images/app_images.dart';
import 'package:curai_app_mobile/core/utils/helper/to_arabic_number.dart';
import 'package:curai_app_mobile/core/utils/models/doctor_model/doctor_info_model.dart';
import 'package:curai_app_mobile/core/utils/widgets/image_viewer_full_screen.dart';
import 'package:curai_app_mobile/features/appointment_patient/presentation/cubit/appointment_patient_cubit/appointment_patient_cubit.dart';
import 'package:curai_app_mobile/features/home/data/models/favorite_doctor_model/favorite_doctor.dart';
import 'package:curai_app_mobile/features/home/presentation/screens/details_doctor_screen.dart';
import 'package:curai_app_mobile/features/home/presentation/widgets/doctor_speciality/specialization_widget.dart';
import 'package:curai_app_mobile/features/home/presentation/widgets/popular_doctor/image_doctor_widget.dart';
import 'package:curai_app_mobile/features/home/presentation/widgets/popular_doctor/rateing_doctor_widget.dart';
import 'package:curai_app_mobile/features/profile/presentation/favorites_cubit/favorites_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoctorItemWidget extends StatefulWidget {
  const DoctorItemWidget({
    required this.doctorResults,
    super.key,
    this.isLoading,
  });
  final DoctorInfoModel doctorResults;
  final bool? isLoading;

  @override
  State<DoctorItemWidget> createState() => _DoctorItemWidgetState();
}

class _DoctorItemWidgetState extends State<DoctorItemWidget> {
  @override
  Widget build(BuildContext context) {
    final favoriteCubit = context.watch<FavoritesCubit>();
    final isFav = favoriteCubit.isFavorite(widget.doctorResults.id ?? 0);
    return Stack(
      children: [
        InkWell(
          onLongPress: () {
            showImageViewerFullScreen(
              context,
              imageUrl: widget.doctorResults.profilePicture ??
                  AppImages.avatarOnlineDoctor,
            );
          },
          onTap: () => context.push(
            BlocProvider<AppointmentPatientCubit>(
              create: (context) => di.sl<AppointmentPatientCubit>(),
              child: DoctorDetailsScreen(doctorResults: widget.doctorResults),
            ),
          ),
          borderRadius: BorderRadius.circular(10.r),
          child: Container(
            decoration: BoxDecoration(
              color: context.isDark
                  ? const Color.fromARGB(225, 0, 0, 0)
                  : const Color.fromARGB(222, 255, 255, 255),
              borderRadius: BorderRadius.circular(8.r),
              boxShadow: [
                BoxShadow(
                  color: context.onSecondaryColor.withAlpha(5),
                ),
              ],
            ),
            child: Row(
              children: [
                ImageDoctorWidget(
                  doctorResults: widget.doctorResults,
                  isLoading: widget.isLoading,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      '${context.translate(LangKeys.dr)} '
                      '${widget.doctorResults.firstName?.capitalizeFirstChar} '
                      '${widget.doctorResults.lastName?.capitalizeFirstChar}',
                      maxLines: 1,
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyleApp.semiBold22().copyWith(
                        color: context.onPrimaryColor,
                      ),
                    ).withWidth(context.W * .52),
                    AutoSizeText(
                      '${context.translate(LangKeys.consultationPrice)}: '
                      '${context.isStateArabic ? toArabicNumber(widget.doctorResults.consultationPrice!.split('.')[0]) : widget.doctorResults.consultationPrice!.split('.')[0]} '
                      '${context.translate(LangKeys.egp)}',
                      maxLines: 1,
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyleApp.medium16().copyWith(
                        color: context.onSecondaryColor,
                      ),
                    ).withWidth(context.W * .54),
                    AutoSizeText(
                      specializationName(
                        widget.doctorResults.specialization ?? '',
                        isArabic: context.isStateArabic,
                      ),
                      maxLines: 1,
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyleApp.medium16().copyWith(
                        color: context.onSecondaryColor,
                      ),
                    ).withWidth(context.W * .55),
                    RateingDoctorWidget(doctorResults: widget.doctorResults),
                  ],
                ).paddingSymmetric(horizontal: 12, vertical: 5),
              ],
            ),
          ),
        ).paddingSymmetric(horizontal: 18, vertical: 8),
        Positioned(
          top: 6.h,
          right: context.isStateArabic ? null : 16.w,
          left: context.isStateArabic ? 16.w : null,
          child: IconButton(
            padding: EdgeInsets.zero,
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            hoverColor: Colors.transparent,
            icon: Icon(
              isFav ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
              size: 30.sp,
              color: isFav
                  ? Colors.redAccent
                  : context.onSecondaryColor.withAlpha(70),
            ),
            onPressed: () {
              final doctorHive =
                  FavoriteDoctor.fromDoctorInfoModel(widget.doctorResults);
              favoriteCubit.toggleFavorite(doctorHive);
            },
          ),
        ),
      ],
    );
  }
}
