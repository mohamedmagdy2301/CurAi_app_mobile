import 'package:curai_app_mobile/core/extensions/int_extensions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/core/utils/helper/shimmer_effect.dart';
import 'package:curai_app_mobile/features/user/presentation/cubit/home_cubit.dart';
import 'package:curai_app_mobile/features/user/presentation/cubit/home_state.dart';
import 'package:curai_app_mobile/features/user/presentation/screens/all_doctor_screen.dart';
import 'package:curai_app_mobile/features/user/presentation/widgets/home/popular_doctor/popular_doctor_item_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class DoctorHomeWidgetListView extends StatelessWidget {
  const DoctorHomeWidgetListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) =>
          current is GetAllDoctorSuccess ||
          current is GetAllDoctorFailure ||
          current is GetAllDoctorLoading,
      builder: (context, state) {
        if (state is GetAllDoctorSuccess) {
          final doctorsList = state.doctorResults;
          return SliverList.separated(
            itemCount: doctorsList.length,
            separatorBuilder: (context, index) => 10.hSpace,
            itemBuilder: (context, index) {
              return PopularDoctorItemWidget(
                doctorResults: doctorsList[index],
              );
            },
          );
        } else if (state is GetAllDoctorFailure) {
          return SliverToBoxAdapter(
            child: Text(
              state.message,
              textAlign: TextAlign.center,
              style: TextStyleApp.regular26().copyWith(
                color: context.onSecondaryColor,
              ),
            ).center().paddingSymmetric(vertical: 45),
          );
        }
        return SliverList.separated(
          itemCount: doctorsListDome.length,
          separatorBuilder: (context, index) => 10.hSpace,
          itemBuilder: (context, index) {
            return Skeletonizer(
              effect: shimmerEffect(context),
              child: PopularDoctorItemWidget(
                doctorResults: doctorsListDome[index],
              ),
            );
          },
        );
      },
    );
  }
}
