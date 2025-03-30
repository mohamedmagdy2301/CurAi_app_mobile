import 'package:curai_app_mobile/core/extensions/int_extensions.dart';
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/navigation_context_extansions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/routes/routes.dart';
import 'package:curai_app_mobile/features/user/data/doctors_list.dart';
import 'package:curai_app_mobile/features/user/presentation/widgets/home/banner_home_widget.dart';
import 'package:curai_app_mobile/features/user/presentation/widgets/home/custom_appbar_home.dart';
import 'package:curai_app_mobile/features/user/presentation/widgets/home/doctor_speciality/doctor_speciality_widget.dart';
import 'package:curai_app_mobile/features/user/presentation/widgets/home/popular_doctor/popular_doctor_item_widget.dart';
import 'package:curai_app_mobile/features/user/presentation/widgets/home/title_section.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
          SliverList.builder(
            itemCount: doctorsList.length,
            itemBuilder: (context, index) {
              return PopularDoctorItemWidget(
                doctorModel: doctorsList[index],
              );
            },
          ),
          SliverToBoxAdapter(child: 10.hSpace),
        ],
      ),
    );
  }
}
