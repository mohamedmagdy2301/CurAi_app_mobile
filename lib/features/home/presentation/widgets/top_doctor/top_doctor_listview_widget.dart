// ignore_for_file: use_build_context_synchronously

import 'package:carousel_slider/carousel_slider.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/core/utils/helper/shimmer_effect.dart';
import 'package:curai_app_mobile/core/utils/models/doctor_model/doctor_info_model.dart';
import 'package:curai_app_mobile/features/home/presentation/cubit/home_cubit/home_cubit.dart';
import 'package:curai_app_mobile/features/home/presentation/cubit/home_cubit/home_state.dart';
import 'package:curai_app_mobile/features/home/presentation/widgets/top_doctor/top_doctor_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class TopDoctorListviewWidget extends StatelessWidget {
  const TopDoctorListviewWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) =>
          current is GetTopDoctorSuccess ||
          current is GetTopDoctorFailure ||
          current is GetTopDoctorLoading,
      builder: (context, state) {
        if (state is GetTopDoctorSuccess) {
          final doctorsList = state.doctorResults;
          return CarouselSlider.builder(
            options: CarouselOptions(
              height: context.H * 0.3,
              viewportFraction: 0.45,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 2),
              enlargeCenterPage: true,
            ),
            itemCount: doctorsList.length,
            itemBuilder:
                (BuildContext context, int itemIndex, int pageViewIndex) {
              return TopDoctorItemWidget(doctorsList: doctorsList[itemIndex]);
            },
          );
        } else if (state is GetTopDoctorFailure) {
          return Text(
            state.message,
            textAlign: TextAlign.center,
            style: TextStyleApp.regular26().copyWith(
              color: context.onSecondaryColor,
            ),
          ).center().paddingSymmetric(vertical: 45);
        }

        return CarouselSlider.builder(
          options: CarouselOptions(
            height: context.H * 0.3,
            viewportFraction: 0.45,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 2),
            enlargeCenterPage: true,
          ),
          itemCount: doctorsListDome.length,
          itemBuilder:
              (BuildContext context, int itemIndex, int pageViewIndex) {
            return Skeletonizer(
              effect: shimmerEffect(context),
              child: TopDoctorItemWidget(
                isLoading: true,
                doctorsList: doctorsListDome[itemIndex],
              ),
            );
          },
        );
      },
    );
  }
}
