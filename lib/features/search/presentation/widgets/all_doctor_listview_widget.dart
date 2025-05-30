// ignore_for_file: parameter_assignments, use_build_context_synchronously

import 'package:curai_app_mobile/core/utils/helper/shimmer_effect.dart';
import 'package:curai_app_mobile/core/utils/models/doctor_model/doctor_info_model.dart';
import 'package:curai_app_mobile/features/home/presentation/widgets/popular_doctor/popular_doctor_item_widget.dart';
import 'package:curai_app_mobile/features/search/presentation/cubit/search_doctor_cubit/search_doctor_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AllDoctorListviewWidget extends StatelessWidget {
  const AllDoctorListviewWidget({
    required this.doctorsList,
    required this.cubit,
    super.key,
  });

  final List<DoctorInfoModel> doctorsList;
  final SearchDoctorCubit cubit;

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: doctorsList.length + (cubit.isLoading ? 1 : 0),
      itemBuilder: (context, index) {
        if (index < doctorsList.length) {
          return DoctorItemWidget(
            doctorResults: doctorsList[index],
          );
        } else {
          return Skeletonizer(
            effect: shimmerEffect(context),
            child: DoctorItemWidget(
              doctorResults: doctorsListDome[0],
            ),
          );
        }
      },
    );
  }
}
