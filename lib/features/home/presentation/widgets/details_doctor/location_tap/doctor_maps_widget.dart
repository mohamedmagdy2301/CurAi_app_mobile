import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/cubit/get_loction/get_loction_cubit.dart';
import 'package:curai_app_mobile/core/cubit/route/route_cubit.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/core/utils/helper/shimmer_effect.dart';
import 'package:curai_app_mobile/core/utils/models/doctor_model/doctor_info_model.dart';
import 'package:curai_app_mobile/features/home/presentation/widgets/details_doctor/location_tap/flutter_map_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:latlong2/latlong.dart';
import 'package:skeletonizer/skeletonizer.dart';

class DoctorMapsWidget extends StatelessWidget {
  const DoctorMapsWidget({
    required this.doctorResults,
    super.key,
  });

  final DoctorInfoModel doctorResults;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GetLoctionCubit>(
          create: (context) => GetLoctionCubit()
            ..getCurrentLocation(
              image: doctorResults.profilePicture,
              doctorPostion: LatLng(
                doctorResults.latitude ?? 0.0,
                doctorResults.longitude ?? 0.0,
              ),
            ),
        ),
        BlocProvider<RouteCubit>(
          create: (context) => RouteCubit(),
        ),
      ],
      child: BlocBuilder<GetLoctionCubit, GetLoctionState>(
        builder: (context, state) {
          if (state is GetLoctionSuccess) {
            return BlocBuilder<RouteCubit, RouteState>(
              builder: (context, routeState) {
                if (routeState is DirectionRouteLoaded) {
                  return FlutterMapBuilder(
                    points: routeState.routePoints,
                    doctorResults: doctorResults,
                  );
                }
                return FlutterMapBuilder(
                  points: const [],
                  doctorResults: doctorResults,
                );
              },
            );
          } else if (state is GetLoctionError) {
            return AutoSizeText(
              'Something went wrong',
              maxLines: 1,
              textAlign: TextAlign.start,
              overflow: TextOverflow.ellipsis,
              style: TextStyleApp.bold20().copyWith(
                color: context.onPrimaryColor,
              ),
            );
          }
          return Skeletonizer(
            effect: shimmerEffect(context),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.r),
              child: SizedBox(
                height: context.H * .4,
                width: double.infinity,
                child: Image.asset(
                  'assets/images/loading.gif',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
