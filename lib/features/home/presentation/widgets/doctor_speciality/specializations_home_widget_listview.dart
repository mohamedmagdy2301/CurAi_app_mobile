import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/core/utils/helper/shimmer_effect.dart';
import 'package:curai_app_mobile/features/home/data/models/specializations_model/specializations_model.dart';
import 'package:curai_app_mobile/features/home/presentation/cubit/home_cubit/home_cubit.dart';
import 'package:curai_app_mobile/features/home/presentation/cubit/home_cubit/home_state.dart';
import 'package:curai_app_mobile/features/home/presentation/widgets/doctor_speciality/specialization_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SpecializationsListViewHome extends StatelessWidget {
  const SpecializationsListViewHome({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) =>
          current is GetSpecializationsSuccess ||
          current is GetSpecializationsFailure ||
          current is GetSpecializationsLoading,
      builder: (context, state) {
        if (state is GetSpecializationsSuccess) {
          final specializationsList = state.specializationsList;
          return SpecializationWidget(
            specializationsList: specializationsList,
          );
        } else if (state is GetSpecializationsFailure) {
          return Text(
            state.message,
            textAlign: TextAlign.center,
            style: TextStyleApp.regular26().copyWith(
              color: context.onSecondaryColor,
            ),
          ).center().withHeight(context.H * 0.15);
        }
        return Skeletonizer(
          effect: shimmerEffect(context),
          child: SpecializationWidget(
            isLoading: true,
            specializationsList: specializationsListDome,
          ),
        );
      },
    );
  }
}

final specializationsListDome = List.filled(
  12,
  SpecializationsModel(
    id: 0,
    name: 'mkm mkm',
    image:
        'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    doctorCount: 2,
  ),
);
