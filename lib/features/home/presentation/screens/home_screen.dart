// ignore_for_file: use_build_context_synchronously

import 'package:curai_app_mobile/core/extensions/int_extensions.dart';
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/navigation_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/local_storage/menage_user_data.dart';
import 'package:curai_app_mobile/core/routes/routes.dart';
import 'package:curai_app_mobile/core/utils/widgets/custom_refreah_header.dart';
import 'package:curai_app_mobile/features/home/presentation/cubit/home_cubit/home_cubit.dart';
import 'package:curai_app_mobile/features/home/presentation/widgets/doctor_speciality/specializations_home_widget_listview.dart';
import 'package:curai_app_mobile/features/home/presentation/widgets/home_widgets/banner_emergency_home_widget.dart';
import 'package:curai_app_mobile/features/home/presentation/widgets/home_widgets/banner_home_widget.dart';
import 'package:curai_app_mobile/features/home/presentation/widgets/home_widgets/custom_appbar_home.dart';
import 'package:curai_app_mobile/features/home/presentation/widgets/home_widgets/title_section.dart';
import 'package:curai_app_mobile/features/home/presentation/widgets/popular_doctor/doctor_home_widget_listview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>()
      ..getPopularDoctor()
      ..getSpecializations();
  }

  Future<void> _onRefresh() async {
    try {
      await Future<void>.delayed(const Duration(milliseconds: 800));

      // Refresh data
      await context.read<HomeCubit>().getSpecializations();
      await context.read<HomeCubit>().getPopularDoctor();

      _refreshController.refreshCompleted();
    } on Exception {
      _refreshController.refreshFailed();
    }
  }

  final RefreshController _refreshController = RefreshController();

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: SmartRefresher(
        header: const CustomRefreahHeader(),
        onRefresh: _onRefresh,
        controller: _refreshController,
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(child: 10.hSpace),
            const CustomAppBarHome(),
            SliverToBoxAdapter(child: const BannerHomeWidget().center()),
            SliverToBoxAdapter(child: 5.hSpace),
            if (getRole() == 'patient')
              SliverToBoxAdapter(
                child: const BannerEmergencyHomeWidget().center(),
              ),
            SliverToBoxAdapter(child: 10.hSpace),
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
      ),
    );
  }
}
