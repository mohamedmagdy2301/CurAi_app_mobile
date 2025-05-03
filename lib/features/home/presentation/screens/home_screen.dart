import 'package:curai_app_mobile/core/extensions/int_extensions.dart';
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/navigation_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/routes/routes.dart';
import 'package:curai_app_mobile/features/home/presentation/cubit/home_cubit.dart';
import 'package:curai_app_mobile/features/home/presentation/widgets/doctor_speciality/specializations_home_widget_listview.dart';
import 'package:curai_app_mobile/features/home/presentation/widgets/home_widgets/banner_home_widget.dart';
import 'package:curai_app_mobile/features/home/presentation/widgets/home_widgets/custom_appbar_home.dart';
import 'package:curai_app_mobile/features/home/presentation/widgets/home_widgets/title_section.dart';
import 'package:curai_app_mobile/features/home/presentation/widgets/popular_doctor/doctor_home_widget_listview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<HomeCubit>()
      ..getAllDoctor(page: 2)
      ..getSpecializations();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: 20.hSpace),
          const CustomAppBarHome(),
          SliverToBoxAdapter(child: 0.hSpace),
          SliverToBoxAdapter(child: const BannerHomeWidget().center()),
          SliverToBoxAdapter(child: 20.hSpace),
          SliverToBoxAdapter(
            child: TitleSectionWidget(
              title: context.translate(LangKeys.doctorSpeciality),
              onPressed: () => context.pushNamed(Routes.doctorSpeciality),
            ),
          ),
          SliverToBoxAdapter(child: context.isTablet ? 25.hSpace : 10.hSpace),
          const SliverToBoxAdapter(child: SpecializationsListViewHome()),
          SliverToBoxAdapter(child: context.isTablet ? 5.hSpace : 0.hSpace),
          SliverToBoxAdapter(
            child: TitleSectionWidget(
              title: context.translate(LangKeys.popularDoctor),
              onPressed: () => context.pushNamed(Routes.allDoctors),
            ),
          ),
          SliverToBoxAdapter(child: 10.hSpace),
          const DoctorListViewHome(),
          SliverToBoxAdapter(child: 10.hSpace),
        ],
      ),
    );
  }
}
