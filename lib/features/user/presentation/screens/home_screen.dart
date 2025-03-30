import 'package:curai_app_mobile/core/dependency_injection/service_locator.dart';
import 'package:curai_app_mobile/core/extensions/int_extensions.dart';
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/navigation_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/routes/routes.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/core/utils/helper/shimmer_effect.dart';
import 'package:curai_app_mobile/features/user/presentation/cubit/home_cubit.dart';
import 'package:curai_app_mobile/features/user/presentation/cubit/home_state.dart';
import 'package:curai_app_mobile/features/user/presentation/screens/all_doctor_screen.dart';
import 'package:curai_app_mobile/features/user/presentation/widgets/home/banner_home_widget.dart';
import 'package:curai_app_mobile/features/user/presentation/widgets/home/custom_appbar_home.dart';
import 'package:curai_app_mobile/features/user/presentation/widgets/home/doctor_speciality/doctor_speciality_widget.dart';
import 'package:curai_app_mobile/features/user/presentation/widgets/home/popular_doctor/popular_doctor_item_widget.dart';
import 'package:curai_app_mobile/features/user/presentation/widgets/home/title_section.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeCubit>(
      create: (context) => sl<HomeCubit>()..getAllDoctor(),
      child: SafeArea(
        bottom: false,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: 20.hSpace),
            const CustomAppBarHome(),
            SliverToBoxAdapter(child: 0.hSpace),
            const SliverToBoxAdapter(child: Center(child: BannerHomeWidget())),
            SliverToBoxAdapter(child: 20.hSpace),
            SliverToBoxAdapter(
              child: TitleSectionWidget(
                title: context.translate(LangKeys.doctorSpeciality),
                onPressed: () => context.pushNamed(Routes.doctorSpeciality),
              ),
            ),
            SliverToBoxAdapter(child: 20.hSpace),
            const SliverToBoxAdapter(child: DoctorSpecialityWidget()),
            SliverToBoxAdapter(child: 5.hSpace),
            SliverToBoxAdapter(
              child: TitleSectionWidget(
                title: context.translate(LangKeys.popularDoctor),
                onPressed: () => context.pushNamed(Routes.allDoctors),
              ),
            ),
            SliverToBoxAdapter(child: 10.hSpace),
            BlocBuilder<HomeCubit, HomeState>(
              buildWhen: (previous, current) =>
                  current is GetAllDoctorSuccess ||
                  current is GetAllDoctorFailure ||
                  current is GetAllDoctorLoading,
              builder: (context, state) {
                if (state is GetAllDoctorSuccess) {
                  final doctorsList = state.doctorModel;
                  return SliverList.separated(
                    itemCount: doctorsList.length,
                    separatorBuilder: (context, index) => 10.hSpace,
                    itemBuilder: (context, index) {
                      return PopularDoctorItemWidget(
                        doctorModel: doctorsList[index],
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
                        doctorModel: doctorsListDome[index],
                      ),
                    );
                  },
                );
              },
            ),
            SliverToBoxAdapter(child: 10.hSpace),
          ],
        ),
      ),
    );
  }
}
