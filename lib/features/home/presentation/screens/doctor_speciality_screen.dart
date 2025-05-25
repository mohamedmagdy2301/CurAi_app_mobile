import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/core/utils/helper/shimmer_effect.dart';
import 'package:curai_app_mobile/features/home/presentation/cubit/home_cubit/home_cubit.dart';
import 'package:curai_app_mobile/features/home/presentation/cubit/home_cubit/home_state.dart';
import 'package:curai_app_mobile/features/home/presentation/widgets/doctor_speciality/custom_appbar_doctor_specialities.dart';
import 'package:curai_app_mobile/features/home/presentation/widgets/doctor_speciality/filter_doctor_speciality_widget.dart';
import 'package:curai_app_mobile/features/home/presentation/widgets/doctor_speciality/specializations_home_widget_listview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class DoctorSpecialitiesScreen extends StatefulWidget {
  const DoctorSpecialitiesScreen({super.key});

  @override
  State<DoctorSpecialitiesScreen> createState() =>
      _DoctorSpecialitiesScreenState();
}

class _DoctorSpecialitiesScreenState extends State<DoctorSpecialitiesScreen> {
  @override
  void initState() {
    context.read<HomeCubit>().getSpecializations();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarDoctorSpecialities(),
      body: BlocBuilder<HomeCubit, HomeState>(
        buildWhen: (previous, current) =>
            current is GetSpecializationsSuccess ||
            current is GetSpecializationsFailure ||
            current is GetSpecializationsLoading,
        builder: (context, state) {
          if (state is GetSpecializationsSuccess) {
            final specializationsList = state.specializationsList;
            return FilterDoctorSpeciality(
              specializationsList: specializationsList,
            );
          } else if (state is GetSpecializationsFailure) {
            return Text(
              state.message,
              textAlign: TextAlign.center,
              style: TextStyleApp.regular26().copyWith(
                color: context.onSecondaryColor,
              ),
            ).center();
          }
          return Skeletonizer(
            effect: shimmerEffect(context),
            child: FilterDoctorSpeciality(
              isLoading: true,
              specializationsList: specializationsListDome,
            ),
          );
        },
      ),
    );
  }
}
