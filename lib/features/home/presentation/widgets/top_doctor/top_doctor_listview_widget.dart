// ignore_for_file: use_build_context_synchronously

import 'package:curai_app_mobile/core/extensions/int_extensions.dart';
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

          return SizedBox(
            height: context.H * 0.28,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: context.padding(horizontal: 10),
              itemCount: doctorsList.length,
              separatorBuilder: (context, index) => 12.wSpace,
              itemBuilder: (context, index) {
                return TopDoctorItemWidget(doctorsList: doctorsList[index]);
              },
            ),
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
        return SizedBox(
          height: context.H * 0.28,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: context.padding(horizontal: 10),
            itemCount: doctorsListDome.length,
            separatorBuilder: (context, index) => 12.wSpace,
            itemBuilder: (context, index) {
              return Skeletonizer(
                effect: shimmerEffect(context),
                child: TopDoctorItemWidget(
                  isLoading: true,
                  doctorsList: doctorsListDome[index],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
